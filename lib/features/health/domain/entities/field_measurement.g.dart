// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SourceMeasurementImpl _$$SourceMeasurementImplFromJson(
        Map<String, dynamic> json) =>
    _$SourceMeasurementImpl(
      id: json['id'] as String,
      nodeId: json['nodeId'] as String,
      measuredAt: DateTime.parse(json['measuredAt'] as String),
      measuredBy: json['measuredBy'] as String,
      instrument: json['instrument'] as String?,
      notes: json['notes'] as String?,
      photoUrls: (json['photoUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      voltageLN: (json['voltageLN'] as num?)?.toDouble(),
      voltageLL: (json['voltageLL'] as num?)?.toDouble(),
      frequency: (json['frequency'] as num?)?.toDouble(),
      externalZe: (json['externalZe'] as num?)?.toDouble(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SourceMeasurementImplToJson(
        _$SourceMeasurementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nodeId': instance.nodeId,
      'measuredAt': instance.measuredAt.toIso8601String(),
      'measuredBy': instance.measuredBy,
      'instrument': instance.instrument,
      'notes': instance.notes,
      'photoUrls': instance.photoUrls,
      'voltageLN': instance.voltageLN,
      'voltageLL': instance.voltageLL,
      'frequency': instance.frequency,
      'externalZe': instance.externalZe,
      'runtimeType': instance.$type,
    };

_$RcdMeasurementImpl _$$RcdMeasurementImplFromJson(Map<String, dynamic> json) =>
    _$RcdMeasurementImpl(
      id: json['id'] as String,
      nodeId: json['nodeId'] as String,
      measuredAt: DateTime.parse(json['measuredAt'] as String),
      measuredBy: json['measuredBy'] as String,
      instrument: json['instrument'] as String?,
      notes: json['notes'] as String?,
      photoUrls: (json['photoUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      tripTimeMs: (json['tripTimeMs'] as num?)?.toDouble(),
      tripCurrentmA: (json['tripCurrentmA'] as num?)?.toDouble(),
      contactVoltage: (json['contactVoltage'] as num?)?.toDouble(),
      mechanicalTestPassed: json['mechanicalTestPassed'] as bool?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$RcdMeasurementImplToJson(
        _$RcdMeasurementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nodeId': instance.nodeId,
      'measuredAt': instance.measuredAt.toIso8601String(),
      'measuredBy': instance.measuredBy,
      'instrument': instance.instrument,
      'notes': instance.notes,
      'photoUrls': instance.photoUrls,
      'tripTimeMs': instance.tripTimeMs,
      'tripCurrentmA': instance.tripCurrentmA,
      'contactVoltage': instance.contactVoltage,
      'mechanicalTestPassed': instance.mechanicalTestPassed,
      'runtimeType': instance.$type,
    };

_$InsulationMeasurementImpl _$$InsulationMeasurementImplFromJson(
        Map<String, dynamic> json) =>
    _$InsulationMeasurementImpl(
      id: json['id'] as String,
      nodeId: json['nodeId'] as String,
      measuredAt: DateTime.parse(json['measuredAt'] as String),
      measuredBy: json['measuredBy'] as String,
      instrument: json['instrument'] as String?,
      notes: json['notes'] as String?,
      photoUrls: (json['photoUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      resistancePhaseEarth: (json['resistancePhaseEarth'] as num?)?.toDouble(),
      resistancePhaseNeutral:
          (json['resistancePhaseNeutral'] as num?)?.toDouble(),
      continuityPE: json['continuityPE'] as bool?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$InsulationMeasurementImplToJson(
        _$InsulationMeasurementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nodeId': instance.nodeId,
      'measuredAt': instance.measuredAt.toIso8601String(),
      'measuredBy': instance.measuredBy,
      'instrument': instance.instrument,
      'notes': instance.notes,
      'photoUrls': instance.photoUrls,
      'resistancePhaseEarth': instance.resistancePhaseEarth,
      'resistancePhaseNeutral': instance.resistancePhaseNeutral,
      'continuityPE': instance.continuityPE,
      'runtimeType': instance.$type,
    };

_$LoadMeasurementImpl _$$LoadMeasurementImplFromJson(
        Map<String, dynamic> json) =>
    _$LoadMeasurementImpl(
      id: json['id'] as String,
      nodeId: json['nodeId'] as String,
      measuredAt: DateTime.parse(json['measuredAt'] as String),
      measuredBy: json['measuredBy'] as String,
      instrument: json['instrument'] as String?,
      notes: json['notes'] as String?,
      photoUrls: (json['photoUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      loopImpedanceZs: (json['loopImpedanceZs'] as num?)?.toDouble(),
      voltageAtLoad: (json['voltageAtLoad'] as num?)?.toDouble(),
      polarityOk: json['polarityOk'] as bool?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LoadMeasurementImplToJson(
        _$LoadMeasurementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nodeId': instance.nodeId,
      'measuredAt': instance.measuredAt.toIso8601String(),
      'measuredBy': instance.measuredBy,
      'instrument': instance.instrument,
      'notes': instance.notes,
      'photoUrls': instance.photoUrls,
      'loopImpedanceZs': instance.loopImpedanceZs,
      'voltageAtLoad': instance.voltageAtLoad,
      'polarityOk': instance.polarityOk,
      'runtimeType': instance.$type,
    };

_$PanelMeasurementImpl _$$PanelMeasurementImplFromJson(
        Map<String, dynamic> json) =>
    _$PanelMeasurementImpl(
      id: json['id'] as String,
      nodeId: json['nodeId'] as String,
      measuredAt: DateTime.parse(json['measuredAt'] as String),
      measuredBy: json['measuredBy'] as String,
      instrument: json['instrument'] as String?,
      notes: json['notes'] as String?,
      photoUrls: (json['photoUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      earthResistanceRa: (json['earthResistanceRa'] as num?)?.toDouble(),
      phaseCurrentR: (json['phaseCurrentR'] as num?)?.toDouble(),
      phaseCurrentS: (json['phaseCurrentS'] as num?)?.toDouble(),
      phaseCurrentT: (json['phaseCurrentT'] as num?)?.toDouble(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$PanelMeasurementImplToJson(
        _$PanelMeasurementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nodeId': instance.nodeId,
      'measuredAt': instance.measuredAt.toIso8601String(),
      'measuredBy': instance.measuredBy,
      'instrument': instance.instrument,
      'notes': instance.notes,
      'photoUrls': instance.photoUrls,
      'earthResistanceRa': instance.earthResistanceRa,
      'phaseCurrentR': instance.phaseCurrentR,
      'phaseCurrentS': instance.phaseCurrentS,
      'phaseCurrentT': instance.phaseCurrentT,
      'runtimeType': instance.$type,
    };

_$GenericMeasurementImpl _$$GenericMeasurementImplFromJson(
        Map<String, dynamic> json) =>
    _$GenericMeasurementImpl(
      id: json['id'] as String,
      nodeId: json['nodeId'] as String,
      measuredAt: DateTime.parse(json['measuredAt'] as String),
      measuredBy: json['measuredBy'] as String,
      instrument: json['instrument'] as String?,
      notes: json['notes'] as String?,
      photoUrls: (json['photoUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      measuredVoltageLN: (json['measuredVoltageLN'] as num?)?.toDouble(),
      measuredRcdTripTime: (json['measuredRcdTripTime'] as num?)?.toDouble(),
      measuredEarthResistance:
          (json['measuredEarthResistance'] as num?)?.toDouble(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$GenericMeasurementImplToJson(
        _$GenericMeasurementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nodeId': instance.nodeId,
      'measuredAt': instance.measuredAt.toIso8601String(),
      'measuredBy': instance.measuredBy,
      'instrument': instance.instrument,
      'notes': instance.notes,
      'photoUrls': instance.photoUrls,
      'measuredVoltageLN': instance.measuredVoltageLN,
      'measuredRcdTripTime': instance.measuredRcdTripTime,
      'measuredEarthResistance': instance.measuredEarthResistance,
      'runtimeType': instance.$type,
    };
