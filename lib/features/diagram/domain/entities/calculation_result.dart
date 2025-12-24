import 'package:freezed_annotation/freezed_annotation.dart';
import 'validation_status.dart';

part 'calculation_result.freezed.dart';

/// Resultado completo del cálculo eléctrico para un nodo
@freezed
class CalculationResult with _$CalculationResult {
  const factory CalculationResult({
    // === PASADA 1: Bottom-Up (Suma de Cargas) ===

    /// Intensidad de diseño (Ib) en Amperios
    @Default(0.0) double designCurrent,

    /// Intensidad admisible (Iz) del cable en Amperios
    @Default(0.0) double admissibleCurrent,

    /// Potencia activa (P) en Watts
    @Default(0.0) double activePower,

    /// Potencia reactiva (Q) en VAR
    @Default(0.0) double reactivePower,

    /// Potencia aparente (S) en VA
    @Default(0.0) double apparentPower,

    /// Factor de potencia (cos φ)
    @Default(1.0) double powerFactor,

    // === PASADA 2: Top-Down (Caída de Tensión) ===

    /// Tensión real en este nodo (V)
    @Default(230.0) double voltageAtNode,

    /// Caída de tensión acumulada (%)
    @Default(0.0) double voltageDrop,

    /// Caída de tensión acumulada (V)
    @Default(0.0) double voltageDropVolts,

    /// Corriente de cortocircuito máxima (kA)
    @Default(0.0) double maxShortCircuitCurrent,

    /// Corriente de cortocircuito mínima (kA)
    @Default(0.0) double minShortCircuitCurrent,

    /// Impedancia del bucle (Ω)
    @Default(0.0) double loopImpedance,

    // === VALIDACIÓN ===

    /// Estado de validación del nodo
    @Default(ValidationStatus.pending) ValidationStatus status,

    /// Lista de errores críticos
    @Default([]) List<ValidationError> errors,

    /// Lista de advertencias
    @Default([]) List<ValidationWarning> warnings,
  }) = _CalculationResult;

  const CalculationResult._();

  /// Verifica si el nodo cumple la normativa
  bool get isCompliant => status == ValidationStatus.ok;

  /// Verifica si tiene algún error
  bool get hasErrors => errors.isNotEmpty;

  /// Verifica si tiene advertencias
  bool get hasWarnings => warnings.isNotEmpty;
}
