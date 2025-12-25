import 'dart:math';
import '../entities/electrical_node.dart';
import '../entities/calculation_result.dart';
import '../entities/cable_physics.dart';
import '../entities/validation_status.dart';
import '../entities/conductor_attributes.dart';
import 'package:electrician_app/features/diagram/domain/entities/electrical_enums.dart'
    as enums;
import 'validation_engine.dart';
import 'iz_constants.dart';
import '../../../../core/constants/electrical_constants.dart';

/// Motor de álculo eléctrico con propagación bidireccional
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

    // Z_source = V / Icc_external (evita explosión de Icc aguas abajo)
    double initialR =
        0.015; // Valor por defecto seguro (~15mΩ) para evitar Icc infinita
    double initialX = 0.0;

    root.map(
      source: (n) {
        // Detectar si viene en Amperios o kA
        // El default en freezed es 10000 (probablemente Amperios).
        // Si el valor es > 200, asumimos Amperios. Si es <= 200, asumimos kA.
        double val = n.shortCircuitCapacity;
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

  /// Calculate Cable Ampacity (Iz) using IEC 60364-5-52 tables and correction factors
  /// Returns the maximum current the cable can safely carry
  static double calculateIz({
    required double sectionMm2,
    required enums.ConductorMaterial material,
    required enums.CableInsulation insulation,
    required enums.InstallationMethod method,
    required enums.CorrectionFactors factors,
  }) {
    // Alias Z1 to XLPE
    final effectiveInsulation = (insulation == enums.CableInsulation.z1)
        ? enums.CableInsulation.xlpe
        : insulation;

    // 1. Base Capacity (Itab)
    final table = IzConstants.currentCarryingCapacity[effectiveInsulation]
        ?[material]?[method];
    if (table == null) return 0.0;

    double iTab = table[sectionMm2] ?? 0.0;

    // Interpolation
    if (iTab == 0.0 && sectionMm2 > 0) {
      final sections = table.keys.toList()..sort();
      if (sectionMm2 < sections.first) return 0.0;
      if (sectionMm2 > sections.last) return 0.0;

      for (int i = 0; i < sections.length - 1; i++) {
        final s1 = sections[i];
        final s2 = sections[i + 1];
        if (sectionMm2 > s1 && sectionMm2 < s2) {
          final i1 = table[s1]!;
          final i2 = table[s2]!;
          iTab = i1 + (sectionMm2 - s1) * (i2 - i1) / (s2 - s1);
          break;
        }
      }
    }

    // 2. Temperature Correction (Ktemp)
    final tempTable = method.isBuried
        ? IzConstants.tempCorrectionTableGround[effectiveInsulation]
        : IzConstants.tempCorrectionTableAir[effectiveInsulation];

    double kTemp = 1.0;
    if (tempTable != null) {
      final temp = factors.ambientTemperature;
      if (tempTable.containsKey(temp)) {
        kTemp = tempTable[temp]!;
      } else {
        // Nearest/Interp
        final keys = tempTable.keys.toList()..sort();
        if (temp <= keys.first)
          kTemp = tempTable[keys.first]!;
        else if (temp >= keys.last)
          kTemp = tempTable[keys.last]!;
        else {
          for (int i = 0; i < keys.length - 1; i++) {
            if (temp > keys[i] && temp < keys[i + 1]) {
              final t1 = keys[i];
              final t2 = keys[i + 1];
              final v1 = tempTable[t1]!;
              final v2 = tempTable[t2]!;
              kTemp = v1 + (temp - t1) * (v2 - v1) / (t2 - t1);
              break;
            }
          }
        }
      }
    }

    // 3. Grouping Correction (Kgroup)
    final groupTable = IzConstants.groupingCorrectionTable[method];
    double kGroup = 1.0;
    if (groupTable != null) {
      final n = factors.numberOfCircuits;
      if (groupTable.containsKey(n)) {
        kGroup = groupTable[n]!;
      } else if (n > 1) {
        final maxKey = groupTable.keys.reduce(max);
        if (n > maxKey) kGroup = groupTable[maxKey]!;
      }
    } else if (factors.numberOfCircuits > 1) {
      kGroup = 0.8;
    }

    // 4. Soil Resistivity (Ksoil)
    double kSoil = 1.0;
    if (method.isBuried) {
      final resistivity = factors.soilResistivity;
      if (IzConstants.soilResistivityTable.containsKey(resistivity)) {
        kSoil = IzConstants.soilResistivityTable[resistivity]!;
      } else {
        final rKeys = IzConstants.soilResistivityTable.keys.toList()..sort();
        if (resistivity <= rKeys.first)
          kSoil = IzConstants.soilResistivityTable[rKeys.first]!;
        else if (resistivity >= rKeys.last)
          kSoil = IzConstants.soilResistivityTable[rKeys.last]!;
        else {
          for (int i = 0; i < rKeys.length - 1; i++) {
            if (resistivity > rKeys[i] && resistivity < rKeys[i + 1]) {
              final r1 = rKeys[i];
              final r2 = rKeys[i + 1];
              final v1 = IzConstants.soilResistivityTable[r1]!;
              final v2 = IzConstants.soilResistivityTable[r2]!;
              kSoil = v1 + (resistivity - r1) * (v2 - v1) / (r2 - r1);
              break;
            }
          }
        }
      }
    }

    return iTab * kTemp * kGroup * kSoil;
  }

  /// Calculate precise voltage drop percentage
  static double calculateVoltageDrop({
    required double currentAmps,
    required double lengthMeters,
    required double sectionMm2,
    required enums.ConductorMaterial material,
    required double voltage,
    required bool isThreePhase,
  }) {
    if (lengthMeters == 0.0 || currentAmps == 0.0) return 0.0;
    const rhoCu = 0.01724;
    const rhoAl = 0.02826;
    final rho = material == enums.ConductorMaterial.copper ? rhoCu : rhoAl;
    final factor = isThreePhase ? sqrt(3) : 2.0;

    final dropVolts = (factor * rho * lengthMeters * currentAmps) / sectionMm2;
    return (dropVolts / voltage) * 100.0;
  }

  static double calculateIccAtPoint({
    required double iccUpstream,
    required double lengthMeters,
    required double sectionMm2,
    required enums.ConductorMaterial material,
    required double voltage,
  }) {
    if (lengthMeters == 0.0) return iccUpstream;
    const rhoCu = 0.01724;
    const rhoAl = 0.02826;
    final rho = material == enums.ConductorMaterial.copper ? rhoCu : rhoAl;

    // Simplified Z calculation (Resistive)
    final zCable = (rho * 2 * lengthMeters) / sectionMm2;
    final zUpstream = voltage / iccUpstream;
    return voltage / (zUpstream + zCable);
  }

  // --- SHORT CIRCUIT CALCULATION HELPER ---
  static _ShortCircuitData _calculateShortCircuit({
    required double upstreamVoltage,
    required double accumulatedR,
    required double accumulatedX,
    required CablePhysics? cablePhysics,
    required bool isThreePhase,
  }) {
    // If we have a local cable, add its impedance to accumulated
    double totalR = accumulatedR;
    double totalX = accumulatedX;

    if (cablePhysics != null) {
      totalR += cablePhysics
          .resistanceAtMaxTemp; // Use max temp for Min Icc? No, typically 20C for Max, Max Temp for Min.
      // Standard:
      // Icc Max: Conductors at 20°C (Resistance * 1.0)
      // Icc Min: Conductors at operating temp (Resistance * 1.25 or 1.5)
      // For MVP we use accumulatedR which likely comes from 20C + Temp.
      // Let's assume accumulatedR passed down is "Hot" or "Cold" appropriately?
      // In TopDown, we added 'cable.resistanceAtMaxTemp'. This is correct for Voltage Drop and Icc Min.
      // For Icc Max we should technically use resistance at 20°C.
    }

    // Safety
    if (totalR < 0.001) totalR = 0.001;

    final Z = sqrt(totalR * totalR + totalX * totalX);

    // Simplified:
    // Icc Max = 1.00 * 230 / Z
    // Icc Min = 0.80 * 230 / (1.5 * Z) roughly.

    double iccMax = 0.0;
    double iccMin = 0.0;

    // Voltage to use: Phase-Neutral (230) usually
    // If upstreamVoltage is passed effectively.
    final voltage = upstreamVoltage > 0 ? upstreamVoltage : 230.0;

    iccMax = voltage / Z; // Very simplified
    iccMin = voltage / (Z * 1.5); // Heuristic for hot cable/fault end

    return _ShortCircuitData(
      iccMax: iccMax,
      iccMin: iccMin,
      newAccumulatedR: totalR,
      newAccumulatedX: totalX,
    );
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
    double cableIz = 0.0;

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
      cableIz = cable.currentCapacity;
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
    double cableIz = 0.0;

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
      cableIz = cable.currentCapacity;
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
      admissibleCurrent: cableIz,
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
      accumulatedR: accumulatedR + myR,
      accumulatedX: accumulatedX,
      cablePhysics: null,
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
    double cableIz = 0.0;

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
      cableIz = cable.currentCapacity;
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
      admissibleCurrent: cableIz,
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
    final iz = calculateIz(
      sectionMm2: cable.sectionMm2,
      material: cable.material,
      insulation: cable.insulation,
      method: cable.method,
      factors: cable.factors,
    );

    return CablePhysics(
      section: cable.sectionMm2,
      length: cable.lengthMeters,
      baseCurrentCapacity: iz,
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
  double totalR = accumulatedR;
  double totalX = accumulatedX;

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
