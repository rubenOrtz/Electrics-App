// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conductor_attributes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConductorAttributes _$ConductorAttributesFromJson(Map<String, dynamic> json) {
  return _ConductorAttributes.fromJson(json);
}

/// @nodoc
mixin _$ConductorAttributes {
  double get lengthMeters => throw _privateConstructorUsedError;
  double get sectionMm2 => throw _privateConstructorUsedError;
  ConductorMaterial get material => throw _privateConstructorUsedError;
  CableInsulation get insulation => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConductorAttributesCopyWith<ConductorAttributes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConductorAttributesCopyWith<$Res> {
  factory $ConductorAttributesCopyWith(
          ConductorAttributes value, $Res Function(ConductorAttributes) then) =
      _$ConductorAttributesCopyWithImpl<$Res, ConductorAttributes>;
  @useResult
  $Res call(
      {double lengthMeters,
      double sectionMm2,
      ConductorMaterial material,
      CableInsulation insulation,
      String label});
}

/// @nodoc
class _$ConductorAttributesCopyWithImpl<$Res, $Val extends ConductorAttributes>
    implements $ConductorAttributesCopyWith<$Res> {
  _$ConductorAttributesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lengthMeters = null,
    Object? sectionMm2 = null,
    Object? material = null,
    Object? insulation = null,
    Object? label = null,
  }) {
    return _then(_value.copyWith(
      lengthMeters: null == lengthMeters
          ? _value.lengthMeters
          : lengthMeters // ignore: cast_nullable_to_non_nullable
              as double,
      sectionMm2: null == sectionMm2
          ? _value.sectionMm2
          : sectionMm2 // ignore: cast_nullable_to_non_nullable
              as double,
      material: null == material
          ? _value.material
          : material // ignore: cast_nullable_to_non_nullable
              as ConductorMaterial,
      insulation: null == insulation
          ? _value.insulation
          : insulation // ignore: cast_nullable_to_non_nullable
              as CableInsulation,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConductorAttributesImplCopyWith<$Res>
    implements $ConductorAttributesCopyWith<$Res> {
  factory _$$ConductorAttributesImplCopyWith(_$ConductorAttributesImpl value,
          $Res Function(_$ConductorAttributesImpl) then) =
      __$$ConductorAttributesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double lengthMeters,
      double sectionMm2,
      ConductorMaterial material,
      CableInsulation insulation,
      String label});
}

/// @nodoc
class __$$ConductorAttributesImplCopyWithImpl<$Res>
    extends _$ConductorAttributesCopyWithImpl<$Res, _$ConductorAttributesImpl>
    implements _$$ConductorAttributesImplCopyWith<$Res> {
  __$$ConductorAttributesImplCopyWithImpl(_$ConductorAttributesImpl _value,
      $Res Function(_$ConductorAttributesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lengthMeters = null,
    Object? sectionMm2 = null,
    Object? material = null,
    Object? insulation = null,
    Object? label = null,
  }) {
    return _then(_$ConductorAttributesImpl(
      lengthMeters: null == lengthMeters
          ? _value.lengthMeters
          : lengthMeters // ignore: cast_nullable_to_non_nullable
              as double,
      sectionMm2: null == sectionMm2
          ? _value.sectionMm2
          : sectionMm2 // ignore: cast_nullable_to_non_nullable
              as double,
      material: null == material
          ? _value.material
          : material // ignore: cast_nullable_to_non_nullable
              as ConductorMaterial,
      insulation: null == insulation
          ? _value.insulation
          : insulation // ignore: cast_nullable_to_non_nullable
              as CableInsulation,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConductorAttributesImpl implements _ConductorAttributes {
  const _$ConductorAttributesImpl(
      {this.lengthMeters = 10.0,
      this.sectionMm2 = 6.0,
      this.material = ConductorMaterial.copper,
      this.insulation = CableInsulation.xlpe,
      this.label = 'Cable'});

  factory _$ConductorAttributesImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConductorAttributesImplFromJson(json);

  @override
  @JsonKey()
  final double lengthMeters;
  @override
  @JsonKey()
  final double sectionMm2;
  @override
  @JsonKey()
  final ConductorMaterial material;
  @override
  @JsonKey()
  final CableInsulation insulation;
  @override
  @JsonKey()
  final String label;

  @override
  String toString() {
    return 'ConductorAttributes(lengthMeters: $lengthMeters, sectionMm2: $sectionMm2, material: $material, insulation: $insulation, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConductorAttributesImpl &&
            (identical(other.lengthMeters, lengthMeters) ||
                other.lengthMeters == lengthMeters) &&
            (identical(other.sectionMm2, sectionMm2) ||
                other.sectionMm2 == sectionMm2) &&
            (identical(other.material, material) ||
                other.material == material) &&
            (identical(other.insulation, insulation) ||
                other.insulation == insulation) &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, lengthMeters, sectionMm2, material, insulation, label);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConductorAttributesImplCopyWith<_$ConductorAttributesImpl> get copyWith =>
      __$$ConductorAttributesImplCopyWithImpl<_$ConductorAttributesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConductorAttributesImplToJson(
      this,
    );
  }
}

abstract class _ConductorAttributes implements ConductorAttributes {
  const factory _ConductorAttributes(
      {final double lengthMeters,
      final double sectionMm2,
      final ConductorMaterial material,
      final CableInsulation insulation,
      final String label}) = _$ConductorAttributesImpl;

  factory _ConductorAttributes.fromJson(Map<String, dynamic> json) =
      _$ConductorAttributesImpl.fromJson;

  @override
  double get lengthMeters;
  @override
  double get sectionMm2;
  @override
  ConductorMaterial get material;
  @override
  CableInsulation get insulation;
  @override
  String get label;
  @override
  @JsonKey(ignore: true)
  _$$ConductorAttributesImplCopyWith<_$ConductorAttributesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
