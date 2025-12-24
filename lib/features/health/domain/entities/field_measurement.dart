import 'package:freezed_annotation/freezed_annotation.dart';

part 'field_measurement.freezed.dart';
part 'field_measurement.g.dart';

/// Representa una medición de campo realizada con instrumentación real
/// Tipada específicamente según el componente o prueba realizada.
@freezed
sealed class FieldMeasurement with _$FieldMeasurement {
  /// Mediciones para Fuente/Acometida
  const factory FieldMeasurement.source({
    required String id,
    required String nodeId,
    required DateTime measuredAt,
    required String measuredBy,
    String? instrument,
    String? notes,
    List<String>? photoUrls,
    double? voltageLN, // Tensión L-N
    double? voltageLL, // Tensión L-L
    double? frequency, // Hz
    double? externalZe, // Impedancia externa
  }) = SourceMeasurement;

  /// Mediciones para Diferenciales (RCD)
  const factory FieldMeasurement.rcd({
    required String id,
    required String nodeId,
    required DateTime measuredAt,
    required String measuredBy,
    String? instrument,
    String? notes,
    List<String>? photoUrls,
    double? tripTimeMs, // Tiempo disparo (ms)
    double? tripCurrentmA, // Corriente disparo (mA)
    double? contactVoltage, // Tensión de contacto (V)
    bool? mechanicalTestPassed, // Test mecánico botón OK
  }) = RcdMeasurement;

  /// Mediciones de Aislamiento (Cables/Circuitos)
  const factory FieldMeasurement.insulation({
    required String id,
    required String nodeId,
    required DateTime measuredAt,
    required String measuredBy,
    String? instrument,
    String? notes,
    List<String>? photoUrls,
    double? resistancePhaseEarth, // R(L-PE) MΩ
    double? resistancePhaseNeutral, // R(L-N) MΩ
    bool? continuityPE, // Continuidad de tierra OK
  }) = InsulationMeasurement;

  /// Mediciones de Carga/Circuito Final
  const factory FieldMeasurement.load({
    required String id,
    required String nodeId,
    required DateTime measuredAt,
    required String measuredBy,
    String? instrument,
    String? notes,
    List<String>? photoUrls,
    double? loopImpedanceZs, // Zs medida
    double? voltageAtLoad, // Caída de tensión check
    bool? polarityOk, // Polaridad correcta
  }) = LoadMeasurement;

  /// Mediciones de Cuadro/Tierra
  const factory FieldMeasurement.panel({
    required String id,
    required String nodeId,
    required DateTime measuredAt,
    required String measuredBy,
    String? instrument,
    String? notes,
    List<String>? photoUrls,
    double? earthResistanceRa, // Resistencia Tierra (Ra)
    double? phaseCurrentR, // Consumo Fase R
    double? phaseCurrentS, // Consumo Fase S
    double? phaseCurrentT, // Consumo Fase T
  }) = PanelMeasurement;

  /// Fallback para migración o genérico
  const factory FieldMeasurement.generic({
    required String id,
    required String nodeId,
    required DateTime measuredAt,
    required String measuredBy,
    String? instrument,
    String? notes,
    List<String>? photoUrls,

    // Legacy mapping fields
    double? measuredVoltageLN,
    double? measuredRcdTripTime,
    double? measuredEarthResistance,
  }) = GenericMeasurement;

  factory FieldMeasurement.fromJson(Map<String, dynamic> json) =>
      _$FieldMeasurementFromJson(json);
}
