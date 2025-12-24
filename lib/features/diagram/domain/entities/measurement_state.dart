import 'package:freezed_annotation/freezed_annotation.dart';

part 'measurement_state.freezed.dart';
part 'measurement_state.g.dart';

@freezed
class MeasurementState with _$MeasurementState {
  const factory MeasurementState({
    required DateTime timestamp,

    // Medidas Eléctricas Básicas
    double? voltageLN, // Tensión Fase-Neutro (V)
    double? current, // Intensidad (A)

    // Medidas de Seguridad/Impedancia
    double? loopImpedance, // Zs Impedancia de Bucle (Ω)
    double? insulationResistance, // R_iso Resistencia de Aislamiento (MΩ)
    double? rcdTripTime, // Tiempo de disparo diferencial (ms)
    double? earthResistance, // Resistencia de Tierra (Ω)

    // Medidas Físicas
    double? temperature, // Termografía en bornas (ºC)
  }) = _MeasurementState;

  factory MeasurementState.fromJson(Map<String, dynamic> json) =>
      _$MeasurementStateFromJson(json);
}
