// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electrical_node_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SourceNodeDtoImpl _$$SourceNodeDtoImplFromJson(Map<String, dynamic> json) =>
    _$SourceNodeDtoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      state: json['state'] == null
          ? const ElectricalState()
          : ElectricalState.fromJson(json['state'] as Map<String, dynamic>),
      nominalVoltage: (json['nominalVoltage'] as num?)?.toDouble() ?? 230,
      shortCircuitCapacity:
          (json['shortCircuitCapacity'] as num?)?.toDouble() ?? 10000,
      mainFeedCable: json['mainFeedCable'] == null
          ? null
          : ConductorAttributes.fromJson(
              json['mainFeedCable'] as Map<String, dynamic>),
      lastMeasurement: json['lastMeasurement'] == null
          ? null
          : MeasurementState.fromJson(
              json['lastMeasurement'] as Map<String, dynamic>),
      assetMetadata: json['assetMetadata'] == null
          ? const AssetMetadata()
          : AssetMetadata.fromJson(
              json['assetMetadata'] as Map<String, dynamic>),
      children: (json['children'] as List<dynamic>?)
              ?.map(
                  (e) => ElectricalNodeDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SourceNodeDtoImplToJson(_$SourceNodeDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'state': instance.state,
      'nominalVoltage': instance.nominalVoltage,
      'shortCircuitCapacity': instance.shortCircuitCapacity,
      'mainFeedCable': instance.mainFeedCable,
      'lastMeasurement': instance.lastMeasurement,
      'assetMetadata': instance.assetMetadata,
      'children': instance.children,
      'runtimeType': instance.$type,
    };

_$PanelNodeDtoImpl _$$PanelNodeDtoImplFromJson(Map<String, dynamic> json) =>
    _$PanelNodeDtoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      state: json['state'] == null
          ? const ElectricalState()
          : ElectricalState.fromJson(json['state'] as Map<String, dynamic>),
      nominalVoltage: (json['nominalVoltage'] as num?)?.toDouble() ?? 230,
      inputCable: json['inputCable'] == null
          ? null
          : ConductorAttributes.fromJson(
              json['inputCable'] as Map<String, dynamic>),
      lastMeasurement: json['lastMeasurement'] == null
          ? null
          : MeasurementState.fromJson(
              json['lastMeasurement'] as Map<String, dynamic>),
      assetMetadata: json['assetMetadata'] == null
          ? const AssetMetadata()
          : AssetMetadata.fromJson(
              json['assetMetadata'] as Map<String, dynamic>),
      children: (json['children'] as List<dynamic>?)
              ?.map(
                  (e) => ElectricalNodeDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$PanelNodeDtoImplToJson(_$PanelNodeDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'state': instance.state,
      'nominalVoltage': instance.nominalVoltage,
      'inputCable': instance.inputCable,
      'lastMeasurement': instance.lastMeasurement,
      'assetMetadata': instance.assetMetadata,
      'children': instance.children,
      'runtimeType': instance.$type,
    };

_$ProtectionNodeDtoImpl _$$ProtectionNodeDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$ProtectionNodeDtoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      state: json['state'] == null
          ? const ElectricalState()
          : ElectricalState.fromJson(json['state'] as Map<String, dynamic>),
      lastMeasurement: json['lastMeasurement'] == null
          ? null
          : MeasurementState.fromJson(
              json['lastMeasurement'] as Map<String, dynamic>),
      assetMetadata: json['assetMetadata'] == null
          ? const AssetMetadata()
          : AssetMetadata.fromJson(
              json['assetMetadata'] as Map<String, dynamic>),
      protectionType: $enumDecodeNullable(
              _$ProtectionTypeEnumMap, json['protectionType']) ??
          ProtectionType.circuitBreaker,
      ratingAmps: (json['ratingAmps'] as num?)?.toDouble() ?? 16,
      pdc: (json['pdc'] as num?)?.toDouble(),
      curve: json['curve'] as String? ?? "C",
      sensitivity: (json['sensitivity'] as num?)?.toDouble() ?? 30.0,
      poles: (json['poles'] as num?)?.toInt() ?? 2,
      children: (json['children'] as List<dynamic>?)
              ?.map(
                  (e) => ElectricalNodeDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      catalogData: json['catalogData'] == null
          ? null
          : CatalogMetadata.fromJson(
              json['catalogData'] as Map<String, dynamic>),
      cableCatalogData: json['cableCatalogData'] == null
          ? null
          : CatalogMetadata.fromJson(
              json['cableCatalogData'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ProtectionNodeDtoImplToJson(
        _$ProtectionNodeDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'state': instance.state,
      'lastMeasurement': instance.lastMeasurement,
      'assetMetadata': instance.assetMetadata,
      'protectionType': _$ProtectionTypeEnumMap[instance.protectionType]!,
      'ratingAmps': instance.ratingAmps,
      'pdc': instance.pdc,
      'curve': instance.curve,
      'sensitivity': instance.sensitivity,
      'poles': instance.poles,
      'children': instance.children,
      'catalogData': instance.catalogData,
      'cableCatalogData': instance.cableCatalogData,
      'runtimeType': instance.$type,
    };

const _$ProtectionTypeEnumMap = {
  ProtectionType.circuitBreaker: 'circuitBreaker',
  ProtectionType.differential: 'differential',
  ProtectionType.fuse: 'fuse',
  ProtectionType.surgeProtection: 'surgeProtection',
};

_$LoadNodeDtoImpl _$$LoadNodeDtoImplFromJson(Map<String, dynamic> json) =>
    _$LoadNodeDtoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      state: json['state'] == null
          ? const ElectricalState()
          : ElectricalState.fromJson(json['state'] as Map<String, dynamic>),
      inputCable: json['inputCable'] == null
          ? null
          : ConductorAttributes.fromJson(
              json['inputCable'] as Map<String, dynamic>),
      lastMeasurement: json['lastMeasurement'] == null
          ? null
          : MeasurementState.fromJson(
              json['lastMeasurement'] as Map<String, dynamic>),
      assetMetadata: json['assetMetadata'] == null
          ? const AssetMetadata()
          : AssetMetadata.fromJson(
              json['assetMetadata'] as Map<String, dynamic>),
      powerWatts: (json['powerWatts'] as num?)?.toDouble() ?? 3000,
      cosPhi: (json['cosPhi'] as num?)?.toDouble() ?? 0.9,
      type: $enumDecodeNullable(_$LoadTypeEnumMap, json['type']) ??
          LoadType.power,
      isThreePhase: json['isThreePhase'] as bool? ?? false,
      cableCatalogData: json['cableCatalogData'] == null
          ? null
          : CatalogMetadata.fromJson(
              json['cableCatalogData'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LoadNodeDtoImplToJson(_$LoadNodeDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'state': instance.state,
      'inputCable': instance.inputCable,
      'lastMeasurement': instance.lastMeasurement,
      'assetMetadata': instance.assetMetadata,
      'powerWatts': instance.powerWatts,
      'cosPhi': instance.cosPhi,
      'type': _$LoadTypeEnumMap[instance.type]!,
      'isThreePhase': instance.isThreePhase,
      'cableCatalogData': instance.cableCatalogData,
      'runtimeType': instance.$type,
    };

const _$LoadTypeEnumMap = {
  LoadType.lighting: 'lighting',
  LoadType.power: 'power',
  LoadType.motor: 'motor',
};
