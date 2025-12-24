// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MeasurementStateImpl _$$MeasurementStateImplFromJson(
        Map<String, dynamic> json) =>
    _$MeasurementStateImpl(
      timestamp: DateTime.parse(json['timestamp'] as String),
      voltageLN: (json['voltageLN'] as num?)?.toDouble(),
      current: (json['current'] as num?)?.toDouble(),
      loopImpedance: (json['loopImpedance'] as num?)?.toDouble(),
      insulationResistance: (json['insulationResistance'] as num?)?.toDouble(),
      rcdTripTime: (json['rcdTripTime'] as num?)?.toDouble(),
      earthResistance: (json['earthResistance'] as num?)?.toDouble(),
      temperature: (json['temperature'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$MeasurementStateImplToJson(
        _$MeasurementStateImpl instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'voltageLN': instance.voltageLN,
      'current': instance.current,
      'loopImpedance': instance.loopImpedance,
      'insulationResistance': instance.insulationResistance,
      'rcdTripTime': instance.rcdTripTime,
      'earthResistance': instance.earthResistance,
      'temperature': instance.temperature,
    };
