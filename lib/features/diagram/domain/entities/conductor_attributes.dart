import 'package:freezed_annotation/freezed_annotation.dart';
import 'electrical_enums.dart';

part 'conductor_attributes.freezed.dart';
part 'conductor_attributes.g.dart';

@freezed
class ConductorAttributes with _$ConductorAttributes {
  const factory ConductorAttributes({
    @Default(10.0) double lengthMeters,
    @Default(6.0) double sectionMm2,
    @Default(ConductorMaterial.copper) ConductorMaterial material,
    @Default(CableInsulation.xlpe) CableInsulation insulation,
    @Default('Cable') String label,
  }) = _ConductorAttributes;

  factory ConductorAttributes.fromJson(Map<String, dynamic> json) =>
      _$ConductorAttributesFromJson(json);
}
