// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CatalogMetadataImpl _$$CatalogMetadataImplFromJson(
        Map<String, dynamic> json) =>
    _$CatalogMetadataImpl(
      componentId: json['componentId'] as String,
      brand: json['brand'] as String,
      series: json['series'] as String?,
      reference: json['reference'] as String?,
      displayName: json['displayName'] as String,
    );

Map<String, dynamic> _$$CatalogMetadataImplToJson(
        _$CatalogMetadataImpl instance) =>
    <String, dynamic>{
      'componentId': instance.componentId,
      'brand': instance.brand,
      'series': instance.series,
      'reference': instance.reference,
      'displayName': instance.displayName,
    };
