import 'package:freezed_annotation/freezed_annotation.dart';

part 'validation_status.freezed.dart';

/// Estado de validación de un nodo eléctrico
enum ValidationStatus {
  /// Todo correcto, cumple normativa
  ok,

  /// Advertencias (no crítico pero mejorable)
  warning,

  /// Errores críticos (no cumple normativa)
  error,

  /// No calculado aún
  pending,
}

/// Tipos de errores de validación
@freezed
class ValidationError with _$ValidationError {
  const factory ValidationError.cableOverload({
    required String message,
    required double requiredSection,
    required double currentSection,
  }) = CableOverloadError;

  const factory ValidationError.voltageDrop({
    required String message,
    required double actual,
    required double limit,
  }) = VoltageDropError;

  const factory ValidationError.shortCircuit({
    required String message,
    required double breakingCapacity,
    required double shortCircuitCurrent,
  }) = ShortCircuitError;

  const factory ValidationError.underprotection({
    required String message,
    required double designCurrent,
    required double protectionRating,
  }) = UnderprotectionError;

  // Coordination errors (Golden Rule: Ib ≤ In ≤ Iz)
  const factory ValidationError.overload({
    required String message,
    required double ibAmps,
    required double inAmps,
  }) = OverloadError;

  const factory ValidationError.fireHazard({
    required String message,
    required double inAmps,
    required double izAmps,
  }) = FireHazardError;

  const factory ValidationError.general({
    required String message,
  }) = GeneralError;
}

/// Advertencias de validación
@freezed
class ValidationWarning with _$ValidationWarning {
  const factory ValidationWarning.oversizedCable({
    required String message,
    required double currentSection,
    required double recommendedSection,
  }) = OversizedCableWarning;

  const factory ValidationWarning.lowPowerFactor({
    required String message,
    required double powerFactor,
  }) = LowPowerFactorWarning;

  const factory ValidationWarning.general({
    required String message,
  }) = GeneralWarning;
}
