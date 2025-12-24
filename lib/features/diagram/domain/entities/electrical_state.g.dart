// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electrical_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ElectricalStateImpl _$$ElectricalStateImplFromJson(
        Map<String, dynamic> json) =>
    _$ElectricalStateImpl(
      voltageDropPercent:
          (json['voltageDropPercent'] as num?)?.toDouble() ?? 0.0,
      shortCircuitCurrentAmps:
          (json['shortCircuitCurrentAmps'] as num?)?.toDouble() ?? 0.0,
      activePowerWatts: (json['activePowerWatts'] as num?)?.toDouble() ?? 0.0,
      reactivePowerVars: (json['reactivePowerVars'] as num?)?.toDouble() ?? 0.0,
      currentAmps: (json['currentAmps'] as num?)?.toDouble() ?? 0.0,
      voltageVolts: (json['voltageVolts'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$ElectricalStateImplToJson(
        _$ElectricalStateImpl instance) =>
    <String, dynamic>{
      'voltageDropPercent': instance.voltageDropPercent,
      'shortCircuitCurrentAmps': instance.shortCircuitCurrentAmps,
      'activePowerWatts': instance.activePowerWatts,
      'reactivePowerVars': instance.reactivePowerVars,
      'currentAmps': instance.currentAmps,
      'voltageVolts': instance.voltageVolts,
    };
