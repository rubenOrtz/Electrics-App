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
      method:
          $enumDecodeNullable(_$InstallationMethodEnumMap, json['method']) ??
              InstallationMethod.b1,
      factors: json['factors'] == null
          ? const CorrectionFactors()
          : CorrectionFactors.fromJson(json['factors'] as Map<String, dynamic>),
      label: json['label'] as String? ?? 'Cable',
    );

Map<String, dynamic> _$$ConductorAttributesImplToJson(
        _$ConductorAttributesImpl instance) =>
    <String, dynamic>{
      'lengthMeters': instance.lengthMeters,
      'sectionMm2': instance.sectionMm2,
      'material': _$ConductorMaterialEnumMap[instance.material]!,
      'insulation': _$CableInsulationEnumMap[instance.insulation]!,
      'method': _$InstallationMethodEnumMap[instance.method]!,
      'factors': instance.factors,
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

const _$InstallationMethodEnumMap = {
  InstallationMethod.a1: 'a1',
  InstallationMethod.a2: 'a2',
  InstallationMethod.b1: 'b1',
  InstallationMethod.b2: 'b2',
  InstallationMethod.c: 'c',
  InstallationMethod.d: 'd',
  InstallationMethod.e: 'e',
  InstallationMethod.f: 'f',
};
