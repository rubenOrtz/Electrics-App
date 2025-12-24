// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cable_physics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CablePhysics {
  double get section => throw _privateConstructorUsedError;
  CableMaterial get material => throw _privateConstructorUsedError;
  double get length => throw _privateConstructorUsedError;

  /// Temperatura máxima del conductor (70°C PVC, 90°C XLPE)
  double get temperatureRating => throw _privateConstructorUsedError;
  double get ambientTemp => throw _privateConstructorUsedError;
  double get groupingFactor => throw _privateConstructorUsedError;
  InstallationMethod get installationMethod =>
      throw _privateConstructorUsedError;
  double get baseCurrentCapacity => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CablePhysicsCopyWith<CablePhysics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CablePhysicsCopyWith<$Res> {
  factory $CablePhysicsCopyWith(
          CablePhysics value, $Res Function(CablePhysics) then) =
      _$CablePhysicsCopyWithImpl<$Res, CablePhysics>;
  @useResult
  $Res call(
      {double section,
      CableMaterial material,
      double length,
      double temperatureRating,
      double ambientTemp,
      double groupingFactor,
      InstallationMethod installationMethod,
      double baseCurrentCapacity});
}

/// @nodoc
class _$CablePhysicsCopyWithImpl<$Res, $Val extends CablePhysics>
    implements $CablePhysicsCopyWith<$Res> {
  _$CablePhysicsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? section = null,
    Object? material = null,
    Object? length = null,
    Object? temperatureRating = null,
    Object? ambientTemp = null,
    Object? groupingFactor = null,
    Object? installationMethod = null,
    Object? baseCurrentCapacity = null,
  }) {
    return _then(_value.copyWith(
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as double,
      material: null == material
          ? _value.material
          : material // ignore: cast_nullable_to_non_nullable
              as CableMaterial,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as double,
      temperatureRating: null == temperatureRating
          ? _value.temperatureRating
          : temperatureRating // ignore: cast_nullable_to_non_nullable
              as double,
      ambientTemp: null == ambientTemp
          ? _value.ambientTemp
          : ambientTemp // ignore: cast_nullable_to_non_nullable
              as double,
      groupingFactor: null == groupingFactor
          ? _value.groupingFactor
          : groupingFactor // ignore: cast_nullable_to_non_nullable
              as double,
      installationMethod: null == installationMethod
          ? _value.installationMethod
          : installationMethod // ignore: cast_nullable_to_non_nullable
              as InstallationMethod,
      baseCurrentCapacity: null == baseCurrentCapacity
          ? _value.baseCurrentCapacity
          : baseCurrentCapacity // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CablePhysicsImplCopyWith<$Res>
    implements $CablePhysicsCopyWith<$Res> {
  factory _$$CablePhysicsImplCopyWith(
          _$CablePhysicsImpl value, $Res Function(_$CablePhysicsImpl) then) =
      __$$CablePhysicsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double section,
      CableMaterial material,
      double length,
      double temperatureRating,
      double ambientTemp,
      double groupingFactor,
      InstallationMethod installationMethod,
      double baseCurrentCapacity});
}

/// @nodoc
class __$$CablePhysicsImplCopyWithImpl<$Res>
    extends _$CablePhysicsCopyWithImpl<$Res, _$CablePhysicsImpl>
    implements _$$CablePhysicsImplCopyWith<$Res> {
  __$$CablePhysicsImplCopyWithImpl(
      _$CablePhysicsImpl _value, $Res Function(_$CablePhysicsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? section = null,
    Object? material = null,
    Object? length = null,
    Object? temperatureRating = null,
    Object? ambientTemp = null,
    Object? groupingFactor = null,
    Object? installationMethod = null,
    Object? baseCurrentCapacity = null,
  }) {
    return _then(_$CablePhysicsImpl(
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as double,
      material: null == material
          ? _value.material
          : material // ignore: cast_nullable_to_non_nullable
              as CableMaterial,
      length: null == length
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as double,
      temperatureRating: null == temperatureRating
          ? _value.temperatureRating
          : temperatureRating // ignore: cast_nullable_to_non_nullable
              as double,
      ambientTemp: null == ambientTemp
          ? _value.ambientTemp
          : ambientTemp // ignore: cast_nullable_to_non_nullable
              as double,
      groupingFactor: null == groupingFactor
          ? _value.groupingFactor
          : groupingFactor // ignore: cast_nullable_to_non_nullable
              as double,
      installationMethod: null == installationMethod
          ? _value.installationMethod
          : installationMethod // ignore: cast_nullable_to_non_nullable
              as InstallationMethod,
      baseCurrentCapacity: null == baseCurrentCapacity
          ? _value.baseCurrentCapacity
          : baseCurrentCapacity // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$CablePhysicsImpl extends _CablePhysics {
  const _$CablePhysicsImpl(
      {required this.section,
      this.material = CableMaterial.copper,
      required this.length,
      this.temperatureRating = 70.0,
      this.ambientTemp = 25.0,
      this.groupingFactor = 1.0,
      this.installationMethod = InstallationMethod.underPlaster,
      this.baseCurrentCapacity = 0.0})
      : super._();

  @override
  final double section;
  @override
  @JsonKey()
  final CableMaterial material;
  @override
  final double length;

  /// Temperatura máxima del conductor (70°C PVC, 90°C XLPE)
  @override
  @JsonKey()
  final double temperatureRating;
  @override
  @JsonKey()
  final double ambientTemp;
  @override
  @JsonKey()
  final double groupingFactor;
  @override
  @JsonKey()
  final InstallationMethod installationMethod;
  @override
  @JsonKey()
  final double baseCurrentCapacity;

  @override
  String toString() {
    return 'CablePhysics(section: $section, material: $material, length: $length, temperatureRating: $temperatureRating, ambientTemp: $ambientTemp, groupingFactor: $groupingFactor, installationMethod: $installationMethod, baseCurrentCapacity: $baseCurrentCapacity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CablePhysicsImpl &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.material, material) ||
                other.material == material) &&
            (identical(other.length, length) || other.length == length) &&
            (identical(other.temperatureRating, temperatureRating) ||
                other.temperatureRating == temperatureRating) &&
            (identical(other.ambientTemp, ambientTemp) ||
                other.ambientTemp == ambientTemp) &&
            (identical(other.groupingFactor, groupingFactor) ||
                other.groupingFactor == groupingFactor) &&
            (identical(other.installationMethod, installationMethod) ||
                other.installationMethod == installationMethod) &&
            (identical(other.baseCurrentCapacity, baseCurrentCapacity) ||
                other.baseCurrentCapacity == baseCurrentCapacity));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      section,
      material,
      length,
      temperatureRating,
      ambientTemp,
      groupingFactor,
      installationMethod,
      baseCurrentCapacity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CablePhysicsImplCopyWith<_$CablePhysicsImpl> get copyWith =>
      __$$CablePhysicsImplCopyWithImpl<_$CablePhysicsImpl>(this, _$identity);
}

abstract class _CablePhysics extends CablePhysics {
  const factory _CablePhysics(
      {required final double section,
      final CableMaterial material,
      required final double length,
      final double temperatureRating,
      final double ambientTemp,
      final double groupingFactor,
      final InstallationMethod installationMethod,
      final double baseCurrentCapacity}) = _$CablePhysicsImpl;
  const _CablePhysics._() : super._();

  @override
  double get section;
  @override
  CableMaterial get material;
  @override
  double get length;
  @override

  /// Temperatura máxima del conductor (70°C PVC, 90°C XLPE)
  double get temperatureRating;
  @override
  double get ambientTemp;
  @override
  double get groupingFactor;
  @override
  InstallationMethod get installationMethod;
  @override
  double get baseCurrentCapacity;
  @override
  @JsonKey(ignore: true)
  _$$CablePhysicsImplCopyWith<_$CablePhysicsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
