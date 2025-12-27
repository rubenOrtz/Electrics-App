// ignore_for_file: non_constant_identifier_names
import '../entities/electrical_node.dart';
import '../entities/calculation_result.dart';
import '../entities/validation_status.dart';
import '../../../../core/constants/electrical_constants.dart';

/// Motor de validación que audita el árbol eléctrico
/// y genera errores/warnings según normativa REBT/IEC
class ValidationEngine {
  /// Valida todo el árbol recursivamente
  /// Retorna el árbol con ValidationStatus y errores actualizados
  static ElectricalNode validateTree(
    ElectricalNode node, {
    bool parentHasVoltageDropError = false,
  }) {
    return node.map(
      source: (n) => _validateSource(n, parentHasVoltageDropError),
      panel: (n) => _validatePanel(n, parentHasVoltageDropError),
      protection: (n) => _validateProtection(n, parentHasVoltageDropError),
      load: (n) => _validateLoad(n, parentHasVoltageDropError),
    );
  }

  // ===== VALIDACIÓN POR TIPO DE NODO =====

  static SourceNode _validateSource(
    SourceNode node,
    bool parentHasVoltageDropError,
  ) {
    // Source siempre OK (es el origen)
    final result = node.result ?? const CalculationResult();
    final updatedResult = result.copyWith(
      status: ValidationStatus.ok,
      errors: [],
      warnings: [],
    );

    // Validar hijos recursivamente
    final updatedChildren = node.children.map((child) {
      return validateTree(child, parentHasVoltageDropError: false);
    }).toList();

    return node.copyWith(
      result: updatedResult,
      children: updatedChildren,
    );
  }

  static PanelNode _validatePanel(
    PanelNode node,
    bool parentHasVoltageDropError,
  ) {
    final result = node.result ?? const CalculationResult();
    final errors = <ValidationError>[];
    final warnings = <ValidationWarning>[];

    // Paneles normalmente no tienen protección propia
    // Solo pueden tener error de caída de tensión acumulada

    // REGLA 4: Caída de Tensión
    _validateVoltageDrop(
      node,
      result,
      errors,
      warnings,
      parentHasVoltageDropError,
    );

    // Determinar status
    final status = errors.isNotEmpty
        ? ValidationStatus.error
        : warnings.isNotEmpty
            ? ValidationStatus.warning
            : ValidationStatus.ok;

    final updatedResult = result.copyWith(
      status: status,
      errors: errors,
      warnings: warnings,
    );

    // Propagar error de caída de tensión a hijos
    final hasVoltageError = errors.any((e) => e is VoltageDropError);
    final propagateError = parentHasVoltageDropError || hasVoltageError;

    final updatedChildren = node.children.map((child) {
      return validateTree(child, parentHasVoltageDropError: propagateError);
    }).toList();

    return node.copyWith(
      result: updatedResult,
      children: updatedChildren,
    );
  }

  static ProtectionNode _validateProtection(
    ProtectionNode node,
    bool parentHasVoltageDropError,
  ) {
    final result = node.result ?? const CalculationResult();
    final errors = <ValidationError>[];
    final warnings = <ValidationWarning>[];

    // REGLA 1: Regla de Oro (Ib ≤ In ≤ Iz)
    _validateGoldenRule(node, result, errors, warnings);

    // REGLA 2: Poder de Corte (Pdc ≥ IccMax)
    _validateBreakingCapacity(node, result, errors, warnings);

    // REGLA 3: Disparo Magnético (Imag ≤ IccMin)
    _validateMagneticTrip(node, result, errors, warnings);

    // REGLA 4: Caída de Tensión
    _validateVoltageDrop(
      node,
      result,
      errors,
      warnings,
      parentHasVoltageDropError,
    );

    // Determinar status
    final status = errors.isNotEmpty
        ? ValidationStatus.error
        : warnings.isNotEmpty
            ? ValidationStatus.warning
            : ValidationStatus.ok;

    final updatedResult = result.copyWith(
      status: status,
      errors: errors,
      warnings: warnings,
    );

    // Propagar error de caída de tensión a hijos
    final hasVoltageError = errors.any((e) => e is VoltageDropError);
    final propagateError = parentHasVoltageDropError || hasVoltageError;

    final updatedChildren = node.children.map((child) {
      return validateTree(child, parentHasVoltageDropError: propagateError);
    }).toList();

    return node.copyWith(
      result: updatedResult,
      children: updatedChildren,
    );
  }

  static LoadNode _validateLoad(
    LoadNode node,
    bool parentHasVoltageDropError,
  ) {
    final result = node.result ?? const CalculationResult();
    final errors = <ValidationError>[];
    final warnings = <ValidationWarning>[];

    // Las cargas normalmente no tienen protección propia
    // Solo validar caída de tensión

    // REGLA 4: Caída de Tensión
    _validateVoltageDrop(
      node,
      result,
      errors,
      warnings,
      parentHasVoltageDropError,
    );

    // Determinar status
    final status = errors.isNotEmpty
        ? ValidationStatus.error
        : warnings.isNotEmpty
            ? ValidationStatus.warning
            : ValidationStatus.ok;

    final updatedResult = result.copyWith(
      status: status,
      errors: errors,
      warnings: warnings,
    );

    return node.copyWith(result: updatedResult);
  }

  // ===== COORDINATION VALIDATION (Golden Rule: Ib ≤ In ≤ Iz) =====

  // ===== REGLAS DE VALIDACIÓN =====

  /// REGLA 1: Regla de Oro (Ib ≤ In ≤ Iz)
  static void _validateGoldenRule(
    ProtectionNode node,
    CalculationResult result,
    List<ValidationError> errors,
    List<ValidationWarning> warnings,
  ) {
    final Ib = result.designCurrent;
    final In = node.ratingAmps;

    // Protection nodes don't have cables - they're devices only
    // Cable validation happens on the downstream load/panel nodes
    // So we skip Iz checks here

    // ADELANTAMIENTO WARNING: Ib > In (sobrecarga continua)
    if (Ib > In * 1.05) {
      warnings.add(ValidationWarning.general(
        message:
            'La corriente de diseño (${Ib.toStringAsFixed(1)}A) excede el calibre de protección (${In.toStringAsFixed(1)}A).',
      ));
    }

    // Gap protection: Ib should be reasonably close to In (no more than 2x)
    if (In > Ib * 2.0 && Ib > 1.0) {
      warnings.add(ValidationWarning.general(
        message:
            'Brecha de protección: In=${In.toStringAsFixed(0)}A es demasiado alto para Ib=${Ib.toStringAsFixed(1)}A. Considerar un calibre menor.',
      ));
    }
  }

  /// REGLA 2: Poder de Corte (Pdc ≥ IccMax)
  static void _validateBreakingCapacity(
    ProtectionNode node,
    CalculationResult result,
    List<ValidationError> errors,
    List<ValidationWarning> warnings,
  ) {
    final pdc = node.pdc ?? ElectricalConstants.defaultBreakingCapacityKA;
    final iccMax = result.maxShortCircuitCurrent; // Amperes

    // Convertir Icc a kA
    final iccMaxKA = iccMax / 1000.0;

    // ERROR CRÍTICO: Icc > Pdc (protección puede explotar)
    if (iccMaxKA > pdc) {
      errors.add(ValidationError.shortCircuit(
        message:
            'Icc máx ${iccMaxKA.toStringAsFixed(1)}kA > Poder corte ${pdc.toStringAsFixed(0)}kA',
        breakingCapacity: pdc,
        shortCircuitCurrent: iccMaxKA,
      ));
    }
  }

  /// REGLA 3: Disparo Magnético (Imag ≤ IccMin)
  static void _validateMagneticTrip(
    ProtectionNode node,
    CalculationResult result,
    List<ValidationError> errors,
    List<ValidationWarning> warnings,
  ) {
    final In = node.ratingAmps;
    final curve = node.curve;
    final iccMin = result.minShortCircuitCurrent;

    // Umbral magnético según curva
    final magneticMultiplier = _getMagneticMultiplier(curve);
    final Imag = In * magneticMultiplier;

    // ERROR: IccMin < Imag (cable caliente no dispara el magnético)
    if (iccMin < Imag) {
      errors.add(ValidationError.underprotection(
        message:
            'Icc mín ${iccMin.toStringAsFixed(0)}A < Umbral magnético ${Imag.toStringAsFixed(0)}A (curva $curve)',
        designCurrent: iccMin,
        protectionRating: Imag,
      ));
    }
  }

  /// REGLA 4: Caída de Tensión (ΔU% ≤ Limit)
  static void _validateVoltageDrop(
    ElectricalNode node,
    CalculationResult result,
    List<ValidationError> errors,
    List<ValidationWarning> warnings,
    bool parentHasError,
  ) {
    final dropPercent = result.voltageDrop;

    // Determinar límite según tipo de carga (REBT ITC-BT-19)
    double limit = ElectricalConstants.voltageDropLimitDefault;

    // Por ahora todos los nodos usan el mismo límite (5% - fuerza)
    // En futuras versiones se podrá ajustar según LoadNode.loadType cuando se añada
    node.map(
      load: (_) => limit = ElectricalConstants.voltageDropLimitForce,
      panel: (_) => limit = ElectricalConstants.voltageDropLimitForce,
      protection: (_) => limit = ElectricalConstants.voltageDropLimitForce,
      source: (_) => limit = ElectricalConstants.voltageDropLimitForce,
    );

    // ERROR: ΔU > Limit
    if (dropPercent > limit) {
      if (parentHasError) {
        // Masked error - marcar como heredado
        warnings.add(ValidationWarning.general(
          message:
              'ΔU ${dropPercent.toStringAsFixed(2)}% > ${limit.toStringAsFixed(0)}% (error heredado)',
        ));
      } else {
        errors.add(ValidationError.voltageDrop(
          message:
              'ΔU ${dropPercent.toStringAsFixed(2)}% > ${limit.toStringAsFixed(0)}%',
          actual: dropPercent,
          limit: limit,
        ));
      }
    }
  }

  // ===== HELPERS =====

  /// Multiplicador magnético según curva IEC 60898
  static double _getMagneticMultiplier(String curve) {
    switch (curve.toUpperCase()) {
      case 'B':
        return 5.0; // 3-5 In
      case 'C':
        return 10.0; // 5-10 In
      case 'D':
        return 20.0; // 10-20 In
      default:
        return 10.0; // Asume C por defecto
    }
  }
}
