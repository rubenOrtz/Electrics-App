import 'package:freezed_annotation/freezed_annotation.dart';

part 'component_template.freezed.dart';

/// Component templates for the electrical component library.
/// These are reusable specifications that can be instantiated in diagrams.
@freezed
sealed class ComponentTemplate with _$ComponentTemplate {
  // Protection device template (Circuit breaker, Differential, etc.)
  const factory ComponentTemplate.protection({
    required String id,
    required String name,
    String? manufacturer,
    String? series,
    @Default(false) bool isFavorite,

    // Protection-specific attributes
    required double ratedCurrent, // In (A)
    required String curveType, // B, C, D, K, Z
    required double breakingCapacity, // kA (PDC)
    required int poles, // 1, 2, 3, 4
    @Default(ProtectionDeviceType.circuitBreaker)
    ProtectionDeviceType deviceType,
    double? sensitivity, // For differential (mA)
    double? price, // Euro price
  }) = ProtectionTemplate;

  // Cable template
  const factory ComponentTemplate.cable({
    required String id,
    required String name,
    String? manufacturer,
    String? series,
    @Default(false) bool isFavorite,

    // Cable-specific attributes
    required double section, // mm²
    required CableMaterial material, // Copper or Aluminum
    required String insulationType, // PVC, XLPE, EPR
    required double maxOperatingTemp, // °C
    String? installationMethod, // B1, B2, C, D, E, F, G
    double? price, // Euro price per meter
  }) = CableTemplate;

  // Source/Transformer template
  const factory ComponentTemplate.source({
    required String id,
    required String name,
    String? manufacturer,
    String? series,
    @Default(false) bool isFavorite,

    // Source-specific attributes
    required double voltage, // V
    required double maxShortCircuitCurrent, // Icc in kA
    double? ratedPower, // kVA (for transformers)
    @Default(SourceType.grid) SourceType sourceType,
    double? price, // Euro price
  }) = SourceTemplate;
}

/// Type of protection device
enum ProtectionDeviceType {
  circuitBreaker,
  differential,
  fuse,
  motorProtector,
}

/// Cable conductor material
enum CableMaterial {
  copper,
  aluminum,
}

/// Type of electrical source
enum SourceType {
  grid,
  transformer,
  generator,
  ups,
}
