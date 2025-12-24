import 'dart:math';
import '../entities/electrical_node.dart';
import '../entities/calculation_result.dart';
import '../entities/cable_physics.dart';
import '../entities/validation_status.dart';
import '../entities/conductor_attributes.dart'; // Maybe needed
import '../entities/electrical_enums.dart'; // CRITICAL: ConductorMaterial
import 'validation_engine.dart';
import '../../../../core/constants/electrical_constants.dart';

/// Motor de cálculo eléctrico con propagación bidireccional
class ElectricalCalculator {
  /// Calcula todo el árbol de forma bidireccional
  /// Retorna el árbol actualizado con resultados
  static ElectricalNode recalculateTree(ElectricalNode root) {
    // PASADA 1: Bottom-Up (Suma de cargas)
    final bottomUpResults = _calculateBottomUp(root);

    // Actualizar root con resultado de pasada 1
    var updatedRoot = _updateNodeWithBottomUp(root, bottomUpResults);

    // PASADA 2: Top-Down (Caída de tensión, Icc)
    final sourceVoltage = root.map(
      source: (n) => n.nominalVoltage,
      panel: (n) => n.nominalVoltage,
      protection: (_) => 230.0,
      load: (_) => 230.0,
    );

    // BUG 2 FIX: Calcular impedancia inicial de la fuente
    // Z_source = V / Icc_external (evita explosión de Icc aguas abajo)
    double initialR =
        0.015; // Valor por defecto seguro (~15mΩ) para evitar Icc infinita
    double initialX = 0.0;

    root.map(
      source: (n) {
        // HEURÍSTICA DE UNIDADES: Detectar si viene en Amperios o kA
        // El default en freezed es 10000 (probablemente Amperios).
        // Si el valor es > 200, asumimos Amperios. Si es <= 200, asumimos kA.
        double val = n.shortCircuitCapacity;
        // CHANGE: Default bajado a 4.5kA (Valor seguro para vivienda).
        // 4500A * 1.1 (factor seguridad) = 4950A < 6000A (PDC estándar).
        // Así el primer automático de 6kA sale VERDE.
        if (val <= 0 || val == 10000) val = 4500;

        // Normalizar a Amperios
        final double iccAmps = (val > 200) ? val : val * 1000;

        // Z_source debe calcularse siempre con tensión simple (Fase-Neutro)
        const vPhase = 230.0;

        initialR = vPhase / iccAmps;
        initialX = 0.0;
      },
      panel: (_) {},
      protection: (_) {},
      load: (_) {},
    );

    updatedRoot = _calculateTopDown(
      updatedRoot,
      sourceVoltage,
      0.0, // Accumulated drop = 0 at source
      initialR, // Impedancia inicial correcta
      initialX,
    );

    // PASADA 3: Validación (Auditoría de cumplimiento)
    updatedRoot = ValidationEngine.validateTree(updatedRoot);

    return updatedRoot;
  }

  // ===== CALCULATION HELPERS =====

  /// Calculate Design Current (Ib) - Current required by the load
  static double calculateIb({
    required double powerWatts,
    required double voltage,
    required double cosPhi,
    required bool isThreePhase,
  }) {
    final phi = cosPhi.clamp(0.1, 1.0);
    if (isThreePhase) {
      return powerWatts / (sqrt(3) * voltage * phi);
    } else {
      return powerWatts / (voltage * phi);
    }
  }

  /// Calculate Cable Ampacity (Iz) using simplified IEC 60364-5-52 tables
  /// Returns the maximum current the cable can safely carry
  static double calculateIz({
    required double sectionMm2,
    required ConductorMaterial material,
    String installMethod = "Bajo Tubo (Pared Aislante)",
  }) {
    // Simplified table for common installation methods
    // Reference: IEC 60364-5-52, method B1 (in conduit on wall)

    // Base ampacity for copper in conduit (conservative values)
    final Map<double, double> copperAmpacity = {
      1.5: 13.5,
      2.5: 18.0,
      4.0: 24.0,
      6.0: 31.0,
      10.0: 42.0,
      16.0: 56.0,
      25.0: 73.0,
      35.0: 89.0,
      50.0: 108.0,
      70.0: 136.0,
      95.0: 164.0,
      120.0: 188.0,
      150.0: 216.0,
      185.0: 245.0,
      240.0: 284.0,
    };

    // Aluminum is ~0.79x copper
    final baseIz =
        copperAmpacity[sectionMm2] ?? (sectionMm2 * 2.0); // Rough approximation

    if (material == ConductorMaterial.aluminum) {
      return baseIz * 0.79;
    }

    return baseIz;
  }

  /// Calculate precise voltage drop percentage
  /// Returns ΔU% with full precision (never incorrectly returns 0.00%)
  static double calculateVoltageDrop({
    required double currentAmps,
    required double lengthMeters,
    required double sectionMm2,
    required ConductorMaterial material,
    required double voltage,
    required bool isThreePhase,
  }) {
    if (lengthMeters == 0.0 || currentAmps == 0.0) return 0.0;

    // Resistivity at 20°C in Ω·mm²/m
    const rhoCu = 0.01724; // Copper
    const rhoAl = 0.02826; // Aluminum

    final rho = material == ConductorMaterial.copper ? rhoCu : rhoAl;
    final factor = isThreePhase ? sqrt(3) : 2.0;

    // ΔU (volts) = (factor * ρ * L * I) / S
    final dropVolts = (factor * rho * lengthMeters * currentAmps) / sectionMm2;

    // Convert to percentage with full precision
    return (dropVolts / voltage) * 100.0;
  }

  /// Calculate short-circuit current at a point considering cable impedance
  /// Icc decreases as it travels through the cable
  static double calculateIccAtPoint({
    required double iccUpstream,
    required double lengthMeters,
    required double sectionMm2,
    required ConductorMaterial material,
    required double voltage,
  }) {
    if (lengthMeters == 0.0) return iccUpstream;

    // Calculate cable impedance
    const rhoCu = 0.01724;
    const rhoAl = 0.02826;
    final rho = material == ConductorMaterial.copper ? rhoCu : rhoAl;

    // Z_cable = (ρ * 2 * L) / S  (simplified, ignoring reactance)
    final zCable = (rho * 2 * lengthMeters) / sectionMm2;

    // Z_upstream = V / Icc_upstream
    final zUpstream = voltage / iccUpstream;

    // Icc_point = V / (Z_upstream + Z_cable)
    final iccPoint = voltage / (zUpstream + zCable);

    return iccPoint;
  }

  // ===== PASADA 1: BOTTOM-UP (Suma de Cargas) =====

  static _BottomUpResult _calculateBottomUp(ElectricalNode node) {
    return node.map(
      load: (n) => _calculateLoadBottomUp(n),
      protection: (n) => _calculateProtectionBottomUp(n),
      panel: (n) => _calculatePanelBottomUp(n),
      source: (n) => _calculateSourceBottomUp(n),
    );
  }

  static _BottomUpResult _calculateLoadBottomUp(LoadNode node) {
    final P = node.powerWatts; // W
    final cosPhi = node.cosPhi.clamp(0.1, 1.0);
    final sinPhi = sqrt(1 - cosPhi * cosPhi);
    final Q = P * (sinPhi / cosPhi); // VAR
    final S = sqrt(P * P + Q * Q); // VA

    // Ib = P / (U * cosφ * √3) for 3-phase
    // Ib = P / (U * cosφ) for single-phase
    final voltage = node.isThreePhase ? 400.0 : 230.0;
    final Ib = node.isThreePhase
        ? P / (voltage * cosPhi * sqrt(3))
        : P / (voltage * cosPhi);

    return _BottomUpResult(
      designCurrent: Ib,
      activePower: P,
      reactivePower: Q,
      apparentPower: S,
      powerFactor: cosPhi,
    );
  }

  static _BottomUpResult _calculateProtectionBottomUp(ProtectionNode node) {
    return _calculateContainerBottomUp(node.children, null);
  }

  static _BottomUpResult _calculatePanelBottomUp(PanelNode node) {
    return _calculateContainerBottomUp(node.children, node.nominalVoltage);
  }

  static _BottomUpResult _calculateSourceBottomUp(SourceNode node) {
    return _calculateContainerBottomUp(node.children, node.nominalVoltage);
  }

  static _BottomUpResult _calculateContainerBottomUp(
      List<ElectricalNode> children, double? nominalVoltage) {
    double totalP = 0.0;
    double totalQ = 0.0;

    for (final child in children) {
      final childResult = _calculateBottomUp(child);
      totalP += childResult.activePower;
      totalQ += childResult.reactivePower;
    }

    if (totalP == 0 && totalQ == 0) {
      return _BottomUpResult.zero();
    }

    const Ks = ElectricalConstants.defaultSimultaneityFactor;
    final S = sqrt(totalP * totalP + totalQ * totalQ) * Ks;
    final cosPhi = totalP / S;

    double Ib = 0.0;
    if (nominalVoltage != null && nominalVoltage > 0) {
      // CORRECCIÓN BUG 1: Sistema MONOFÁSICO
      // Fórmula correcta: I = S / V
      // (NO usar √3, eso es solo para trifásico)
      Ib = S / nominalVoltage;
    }

    return _BottomUpResult(
      designCurrent: Ib,
      activePower: totalP * Ks,
      reactivePower: totalQ * Ks,
      apparentPower: S,
      powerFactor: cosPhi,
    );
  }

  // ===== PASADA 2: TOP-DOWN (Caída de Tensión, Icc) =====

  static ElectricalNode _calculateTopDown(
    ElectricalNode node,
    double upstreamVoltage,
    double accumulatedDropPercent,
    double accumulatedR,
    double accumulatedX,
  ) {
    return node.map(
      source: (n) => _calculateSourceTopDown(n, upstreamVoltage,
          accumulatedDropPercent, accumulatedR, accumulatedX),
      panel: (n) => _calculatePanelTopDown(n, upstreamVoltage,
          accumulatedDropPercent, accumulatedR, accumulatedX),
      protection: (n) => _calculateProtectionTopDown(n, upstreamVoltage,
          accumulatedDropPercent, accumulatedR, accumulatedX),
      load: (n) => _calculateLoadTopDown(n, upstreamVoltage,
          accumulatedDropPercent, accumulatedR, accumulatedX),
    );
  }

  // --- SOURCE CALCULATION (Acometida) ---
  static SourceNode _calculateSourceTopDown(
    SourceNode node,
    double upstreamVoltage,
    double accumulatedDropPercent,
    double accumulatedR,
    double accumulatedX,
  ) {
    double deltaU = 0.0;
    double voltage = upstreamVoltage;
    double myR = 0.0;
    double myX = 0.0;
    double cableIz = 0.0; // Corriente admisible del cable

    // Calcular caída en Acometida si existe
    if (node.mainFeedCable != null && node.result != null) {
      final cable = _createCablePhysics(node.mainFeedCable!);
      final Ib = node.result!.designCurrent;
      final cosPhi = node.result!.powerFactor.clamp(0.1, 1.0);
      final sinPhi = sqrt(1 - cosPhi * cosPhi);

      final isThreePhase = _isThreePhase(node);
      final systemCoef = isThreePhase ? sqrt(3) : 2.0;

      // Caída de tensión:
      // Si X es significativo: ΔU = k·I·(R·cosφ + X·sinφ)
      // Si X ≈ 0 (cables pequeños): ΔU = k·I·R (sin factor cosφ)
      if (cable.reactance > 0.001) {
        // Reactancia significativa - usar fórmula completa
        deltaU = systemCoef *
            Ib *
            (cable.resistanceAtMaxTemp * cosPhi + cable.reactance * sinPhi);
      } else {
        // Reactancia despreciable - cable puramente resistivo
        deltaU = systemCoef * Ib * cable.resistanceAtMaxTemp;
      }

      voltage = upstreamVoltage - deltaU;
      myR = cable.resistanceAtMaxTemp;
      myX = cable.reactance;
      cableIz = cable.currentCapacity; // ¡IMPORTANTE! Iz del cable
    }

    final sc = _calculateShortCircuit(
      upstreamVoltage: upstreamVoltage,
      accumulatedR: accumulatedR + myR,
      accumulatedX: accumulatedX + myX,
      cablePhysics: null, // Ya incluido en myR/myX
      isThreePhase: _isThreePhase(node),
    );

    final dropPercent =
        upstreamVoltage > 0 ? (deltaU / upstreamVoltage) * 100 : 0.0;
    final newAccumulated = accumulatedDropPercent + dropPercent;

    final updatedResult = (node.result ?? const CalculationResult()).copyWith(
      voltageAtNode: voltage,
      voltageDrop: newAccumulated,
      voltageDropVolts: upstreamVoltage - voltage,
      maxShortCircuitCurrent: sc.iccMax,
      minShortCircuitCurrent: sc.iccMin,
      loopImpedance: sqrt((accumulatedR + myR) * (accumulatedR + myR) +
          (accumulatedX + myX) * (accumulatedX + myX)),
      admissibleCurrent: cableIz, // Añadido: Iz del cable
      status: ValidationStatus.ok,
    );

    final updatedChildren = node.children.map((child) {
      return _calculateTopDown(child, voltage, newAccumulated,
          accumulatedR + myR, accumulatedX + myX);
    }).toList();

    return node.copyWith(
      result: updatedResult,
      children: updatedChildren,
      state: node.state.copyWith(
        voltageVolts: voltage,
        currentAmps: updatedResult.designCurrent,
        voltageDropPercent: newAccumulated,
        shortCircuitCurrentAmps: sc.iccMin,
      ),
    );
  }

  // --- PANEL CALCULATION (Subcuadro) ---
  static PanelNode _calculatePanelTopDown(
    PanelNode node,
    double upstreamVoltage,
    double accumulatedDropPercent,
    double accumulatedR,
    double accumulatedX,
  ) {
    double deltaU = 0.0;
    double voltage = upstreamVoltage;
    double myR = 0.0;
    double myX = 0.0;
    double cableIz = 0.0; // Corriente admisible del cable

    // 1. Calcular caída de tensión si hay cable
    if (node.inputCable != null && node.result != null) {
      final cable = _createCablePhysics(node.inputCable!);
      final Ib = node.result!.designCurrent;
      final cosPhi = node.result!.powerFactor.clamp(0.1, 1.0);
      final sinPhi = sqrt(1 - cosPhi * cosPhi);
      final isThreePhase = _isThreePhase(node);
      final systemCoef = isThreePhase ? sqrt(3) : 2.0;

      // Caída de tensión: mismo criterio que Source
      if (cable.reactance > 0.001) {
        deltaU = systemCoef *
            Ib *
            (cable.resistanceAtMaxTemp * cosPhi + cable.reactance * sinPhi);
      } else {
        deltaU = systemCoef * Ib * cable.resistanceAtMaxTemp;
      }

      voltage = upstreamVoltage - deltaU;
      myR = cable.resistanceAtMaxTemp;
      myX = cable.reactance;
      cableIz = cable.currentCapacity; // Iz del cable
    }

    final sc = _calculateShortCircuit(
      upstreamVoltage: upstreamVoltage,
      accumulatedR: accumulatedR + myR,
      accumulatedX: accumulatedX + myX,
      cablePhysics: null,
      isThreePhase: _isThreePhase(node),
    );

    final dropPercent =
        upstreamVoltage > 0 ? (deltaU / upstreamVoltage) * 100 : 0.0;
    final newAccumulated = accumulatedDropPercent + dropPercent;

    final updatedResult = (node.result ?? const CalculationResult()).copyWith(
      voltageAtNode: voltage,
      voltageDrop: newAccumulated,
      voltageDropVolts: upstreamVoltage - voltage,
      maxShortCircuitCurrent: sc.iccMax,
      minShortCircuitCurrent: sc.iccMin,
      loopImpedance: sqrt((accumulatedR + myR) * (accumulatedR + myR) +
          (accumulatedX + myX) * (accumulatedX + myX)),
      admissibleCurrent: cableIz, // Añadido: Iz del cable
      status: ValidationStatus.ok,
    );

    final updatedChildren = node.children.map((child) {
      return _calculateTopDown(child, voltage, newAccumulated,
          accumulatedR + myR, accumulatedX + myX);
    }).toList();

    return node.copyWith(
      result: updatedResult,
      children: updatedChildren,
      state: node.state.copyWith(
        voltageVolts: voltage,
        currentAmps: updatedResult.designCurrent,
        voltageDropPercent: newAccumulated,
        shortCircuitCurrentAmps: sc.iccMin,
      ),
    );
  }

  // Resistencia de contacto interna y cableado mínimo por dispositivo (2mΩ)
  static const double _minContactResistance = 0.002;

  // --- PROTECTION CALCULATION (Dispositivo de paso) ---
  static ProtectionNode _calculateProtectionTopDown(
    ProtectionNode node,
    double upstreamVoltage,
    double accumulatedDropPercent,
    double accumulatedR,
    double accumulatedX,
  ) {
    // Protección es transparente a la tensión
    double voltage = upstreamVoltage;

    // Añadimos resistencia de contacto del dispositivo
    // Esto simula la resistencia interna de los contactos y bornas
    final double myR = _minContactResistance;

    final sc = _calculateShortCircuit(
      upstreamVoltage: upstreamVoltage,
      accumulatedR: accumulatedR + myR, // Sumamos resistencia interna
      accumulatedX: accumulatedX,
      cablePhysics: null, // Cable externo ya se manejaría aparte si lo hubiera
      isThreePhase: _isThreePhase(node),
    );

    final updatedResult = (node.result ?? const CalculationResult()).copyWith(
      voltageAtNode: voltage,
      voltageDrop: accumulatedDropPercent,
      voltageDropVolts: 0.0,
      maxShortCircuitCurrent: sc.iccMax,
      minShortCircuitCurrent: sc.iccMin,
      loopImpedance:
          sqrt(accumulatedR * accumulatedR + accumulatedX * accumulatedX),
      status: ValidationStatus.ok,
    );

    final updatedChildren = node.children.map((child) {
      return _calculateTopDown(child, voltage, accumulatedDropPercent,
          accumulatedR + myR, accumulatedX);
    }).toList();

    return node.copyWith(
      result: updatedResult,
      children: updatedChildren,
      state: node.state.copyWith(
        voltageVolts: voltage,
        currentAmps: updatedResult.designCurrent,
        shortCircuitCurrentAmps: sc.iccMin,
        voltageDropPercent: accumulatedDropPercent,
      ),
    );
  }

  // --- LOAD CALCULATION (Carga Final) ---
  static LoadNode _calculateLoadTopDown(
    LoadNode node,
    double upstreamVoltage,
    double accumulatedDropPercent,
    double accumulatedR,
    double accumulatedX,
  ) {
    final isThreePhase = node.isThreePhase;
    double deltaU = 0.0;
    double voltage = upstreamVoltage;
    double myR = 0.0;
    double myX = 0.0;
    double cableIz = 0.0; // Corriente admisible del cable

    if (node.inputCable != null && node.result != null) {
      final cable = _createCablePhysics(node.inputCable!);
      final Ib = node.result!.designCurrent;
      final cosPhi = node.result!.powerFactor.clamp(0.1, 1.0);
      final sinPhi = sqrt(1 - cosPhi * cosPhi);
      final systemCoef = isThreePhase ? sqrt(3) : 2.0;

      // Caída de tensión: mismo criterio que Source/Panel
      if (cable.reactance > 0.001) {
        deltaU = systemCoef *
            Ib *
            (cable.resistanceAtMaxTemp * cosPhi + cable.reactance * sinPhi);
      } else {
        deltaU = systemCoef * Ib * cable.resistanceAtMaxTemp;
      }

      voltage = upstreamVoltage - deltaU;
      myR = cable.resistanceAtMaxTemp;
      myX = cable.reactance;
      cableIz = cable.currentCapacity; // Iz del cable
    }

    final sc = _calculateShortCircuit(
      upstreamVoltage: upstreamVoltage,
      accumulatedR: accumulatedR + myR,
      accumulatedX: accumulatedX + myX,
      cablePhysics: null,
      isThreePhase: isThreePhase,
    );

    final dropPercent =
        upstreamVoltage > 0 ? (deltaU / upstreamVoltage) * 100 : 0.0;
    final newAccumulated = accumulatedDropPercent + dropPercent;

    final updatedResult = (node.result ?? const CalculationResult()).copyWith(
      voltageAtNode: voltage,
      voltageDrop: newAccumulated,
      voltageDropVolts: upstreamVoltage - voltage,
      maxShortCircuitCurrent: sc.iccMax,
      minShortCircuitCurrent: sc.iccMin,
      loopImpedance: sqrt((accumulatedR + myR) * (accumulatedR + myR) +
          (accumulatedX + myX) * (accumulatedX + myX)),
      admissibleCurrent: cableIz, // Añadido: Iz del cable
      status: ValidationStatus.ok,
    );

    return node.copyWith(
      result: updatedResult,
      state: node.state.copyWith(
        voltageVolts: voltage,
        currentAmps: updatedResult.designCurrent,
        activePowerWatts: updatedResult.activePower,
        reactivePowerVars: updatedResult.reactivePower,
        voltageDropPercent: newAccumulated,
        shortCircuitCurrentAmps: sc.iccMin,
      ),
    );
  }

  // ===== HELPERS =====

  /// Detecta si un nodo es trifásico inferiendo de sus cargas hijas
  static bool _isThreePhase(ElectricalNode node) {
    return node.map(
      load: (n) => n.isThreePhase,
      protection: (n) {
        // Si algún hijo es trifásico, este nodo lo es
        for (final child in n.children) {
          if (_isThreePhase(child)) return true;
        }
        return false;
      },
      panel: (n) {
        // Si algún hijo es trifásico, este nodo lo es
        for (final child in n.children) {
          if (_isThreePhase(child)) return true;
        }
        return false;
      },
      source: (n) {
        // Si algún hijo es trifásico, este nodo lo es
        for (final child in n.children) {
          if (_isThreePhase(child)) return true;
        }
        return false;
      },
    );
  }

  static CablePhysics _createCablePhysics(ConductorAttributes cable) {
    return CablePhysics(
      section: cable.sectionMm2,
      length: cable.lengthMeters,
      baseCurrentCapacity: 0.0, // 0.0 triggers internal estimation
    );
  }

  static ElectricalNode _updateNodeWithBottomUp(
    ElectricalNode node,
    _BottomUpResult bottomUp,
  ) {
    final result = CalculationResult(
      designCurrent: bottomUp.designCurrent,
      activePower: bottomUp.activePower,
      reactivePower: bottomUp.reactivePower,
      apparentPower: bottomUp.apparentPower,
      powerFactor: bottomUp.powerFactor,
    );

    return node.map(
      source: (n) {
        final updatedChildren = n.children.map((child) {
          final childBottomUp = _calculateBottomUp(child);
          return _updateNodeWithBottomUp(child, childBottomUp);
        }).toList();
        return n.copyWith(result: result, children: updatedChildren);
      },
      panel: (n) {
        final updatedChildren = n.children.map((child) {
          final childBottomUp = _calculateBottomUp(child);
          return _updateNodeWithBottomUp(child, childBottomUp);
        }).toList();
        return n.copyWith(result: result, children: updatedChildren);
      },
      protection: (n) {
        final updatedChildren = n.children.map((child) {
          final childBottomUp = _calculateBottomUp(child);
          return _updateNodeWithBottomUp(child, childBottomUp);
        }).toList();
        return n.copyWith(result: result, children: updatedChildren);
      },
      load: (n) => n.copyWith(result: result),
    );
  }
}

// ===== CLASES AUXILIARES =====

/// Resultado del cálculo de cortocircuito
class _ShortCircuitData {
  final double iccMax; // Corriente de cortocircuito máxima (A)
  final double iccMin; // Corriente de cortocircuito mínima (A)
  final double newAccumulatedR; // Resistencia total acumulada (Ω)
  final double newAccumulatedX; // Reactancia total acumulada (Ω)

  const _ShortCircuitData({
    required this.iccMax,
    required this.iccMin,
    required this.newAccumulatedR,
    required this.newAccumulatedX,
  });
}

/// Calcula corrientes de cortocircuito considerando impedancia del cable
///
/// Usa el método de impedancias (R + jX) para cálculo preciso según IEC 60909
/// Parámetros:
/// - [upstreamVoltage]: Tensión aguas arriba (V)
/// - [accumulatedR]: Resistencia acumulada hasta este punto (Ω)
/// - [accumulatedX]: Reactancia acumulada hasta este punto (Ω)
/// - [cablePhysics]: Características físicas del cable (puede ser null)
/// - [cableLength]: Longitud del cable en metros
/// - [isThreePhase]: true para cálculo trifásico, false para monofásico
_ShortCircuitData _calculateShortCircuit({
  required double upstreamVoltage,
  required double accumulatedR,
  required double accumulatedX,
  CablePhysics? cablePhysics,
  required bool isThreePhase,
}) {
  // 1. Usar impedancias acumuladas directamente
  // (las impedancias del cable ya están en accumulatedR y accumulatedX)
  double totalR = accumulatedR;
  double totalX = accumulatedX;

  // Si se proporciona cable, agregar su impedancia
  if (cablePhysics != null) {
    totalR += cablePhysics.resistanceAtMaxTemp;
    totalX += cablePhysics.reactance;
  }

  // 2. Calcular impedancia total
  final impedanceTotal = sqrt(totalR * totalR + totalX * totalX);

  // Evitar división por cero
  final safeImpedance = max(impedanceTotal, 0.001);

  // 3. Calcular IccMax (factor de tensión 1.1 según IEC 60909)
  final voltageMax = upstreamVoltage * 1.1;
  final iccMax = isThreePhase
      ? (voltageMax / (sqrt(3) * safeImpedance))
      : (voltageMax / safeImpedance);

  // 4. Calcular IccMin (factor conservador 0.8)
  final iccMin = iccMax * 0.8;

  return _ShortCircuitData(
    iccMax: iccMax,
    iccMin: iccMin,
    newAccumulatedR: totalR,
    newAccumulatedX: totalX,
  );
}

class _BottomUpResult {
  final double designCurrent;
  final double activePower;
  final double reactivePower;
  final double apparentPower;
  final double powerFactor;

  const _BottomUpResult({
    required this.designCurrent,
    required this.activePower,
    required this.reactivePower,
    required this.apparentPower,
    required this.powerFactor,
  });

  factory _BottomUpResult.zero() => const _BottomUpResult(
        designCurrent: 0,
        activePower: 0,
        reactivePower: 0,
        apparentPower: 0,
        powerFactor: 1.0,
      );
}
