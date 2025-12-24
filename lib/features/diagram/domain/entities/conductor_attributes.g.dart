// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conductor_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConductorAttributesImpl _$$ConductorAttributesImplFromJson(
        Map<String, dynamic> json) =>
    _$ConductorAttributesImpl(
      lengthMeters: (json['lengthMeters'] as num?)?.toDouble() ?? 10.0,
      sectionMm2: (json['sectionMm2'] as num?)?.toDouble() ?? 6.0,
      material:
          $enumDecodeNullable(_$ConductorMaterialEnumMap, json['material']) ??
              ConductorMaterial.copper,
      insulation:
          $enumDecodeNullable(_$CableInsulationEnumMap, json['insulation']) ??
              CableInsulation.xlpe,
      label: json['label'] as String? ?? 'Cable',
    );

Map<String, dynamic> _$$ConductorAttributesImplToJson(
        _$ConductorAttributesImpl instance) =>
    <String, dynamic>{
      'lengthMeters': instance.lengthMeters,
      'sectionMm2': instance.sectionMm2,
      'material': _$ConductorMaterialEnumMap[instance.material]!,
      'insulation': _$CableInsulationEnumMap[instance.insulation]!,
      'label': instance.label,
    };

const _$ConductorMaterialEnumMap = {
  ConductorMaterial.copper: 'copper',
  ConductorMaterial.aluminum: 'aluminum',
};

const _$CableInsulationEnumMap = {
  CableInsulation.pvc: 'pvc',
  CableInsulation.xlpe: 'xlpe',
  CableInsulation.z1: 'z1',
};
