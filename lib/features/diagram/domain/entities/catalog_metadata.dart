import 'package:freezed_annotation/freezed_annotation.dart';

part 'catalog_metadata.freezed.dart';
part 'catalog_metadata.g.dart';

/// Metadata from component library catalog
/// Preserves commercial information for budget generation
@freezed
class CatalogMetadata with _$CatalogMetadata {
  const factory CatalogMetadata({
    required String componentId,
    required String brand,
    String? series,
    String? reference,
    required String displayName,
  }) = _CatalogMetadata;

  factory CatalogMetadata.fromJson(Map<String, dynamic> json) =>
      _$CatalogMetadataFromJson(json);
}
