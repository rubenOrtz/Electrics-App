// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'component_template.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ComponentTemplate {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get manufacturer => throw _privateConstructorUsedError;
  String? get series => throw _privateConstructorUsedError;
  bool get isFavorite =>
      throw _privateConstructorUsedError; // For differential (mA)
  double? get price => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double ratedCurrent,
            String curveType,
            double breakingCapacity,
            int poles,
            ProtectionDeviceType deviceType,
            double? sensitivity,
            double? price)
        protection,
    required TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double section,
            CableMaterial material,
            String insulationType,
            double maxOperatingTemp,
            String? installationMethod,
            double? price)
        cable,
    required TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double voltage,
            double maxShortCircuitCurrent,
            double? ratedPower,
            SourceType sourceType,
            double? price)
        source,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double ratedCurrent,
            String curveType,
            double breakingCapacity,
            int poles,
            ProtectionDeviceType deviceType,
            double? sensitivity,
            double? price)?
        protection,
    TResult? Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double section,
            CableMaterial material,
            String insulationType,
            double maxOperatingTemp,
            String? installationMethod,
            double? price)?
        cable,
    TResult? Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double voltage,
            double maxShortCircuitCurrent,
            double? ratedPower,
            SourceType sourceType,
            double? price)?
        source,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double ratedCurrent,
            String curveType,
            double breakingCapacity,
            int poles,
            ProtectionDeviceType deviceType,
            double? sensitivity,
            double? price)?
        protection,
    TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double section,
            CableMaterial material,
            String insulationType,
            double maxOperatingTemp,
            String? installationMethod,
            double? price)?
        cable,
    TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double voltage,
            double maxShortCircuitCurrent,
            double? ratedPower,
            SourceType sourceType,
            double? price)?
        source,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProtectionTemplate value) protection,
    required TResult Function(CableTemplate value) cable,
    required TResult Function(SourceTemplate value) source,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProtectionTemplate value)? protection,
    TResult? Function(CableTemplate value)? cable,
    TResult? Function(SourceTemplate value)? source,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProtectionTemplate value)? protection,
    TResult Function(CableTemplate value)? cable,
    TResult Function(SourceTemplate value)? source,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ComponentTemplateCopyWith<ComponentTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ComponentTemplateCopyWith<$Res> {
  factory $ComponentTemplateCopyWith(
          ComponentTemplate value, $Res Function(ComponentTemplate) then) =
      _$ComponentTemplateCopyWithImpl<$Res, ComponentTemplate>;
  @useResult
  $Res call(
      {String id,
      String name,
      String? manufacturer,
      String? series,
      bool isFavorite,
      double? price});
}

/// @nodoc
class _$ComponentTemplateCopyWithImpl<$Res, $Val extends ComponentTemplate>
    implements $ComponentTemplateCopyWith<$Res> {
  _$ComponentTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? manufacturer = freezed,
    Object? series = freezed,
    Object? isFavorite = null,
    Object? price = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      manufacturer: freezed == manufacturer
          ? _value.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String?,
      series: freezed == series
          ? _value.series
          : series // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProtectionTemplateImplCopyWith<$Res>
    implements $ComponentTemplateCopyWith<$Res> {
  factory _$$ProtectionTemplateImplCopyWith(_$ProtectionTemplateImpl value,
          $Res Function(_$ProtectionTemplateImpl) then) =
      __$$ProtectionTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? manufacturer,
      String? series,
      bool isFavorite,
      double ratedCurrent,
      String curveType,
      double breakingCapacity,
      int poles,
      ProtectionDeviceType deviceType,
      double? sensitivity,
      double? price});
}

/// @nodoc
class __$$ProtectionTemplateImplCopyWithImpl<$Res>
    extends _$ComponentTemplateCopyWithImpl<$Res, _$ProtectionTemplateImpl>
    implements _$$ProtectionTemplateImplCopyWith<$Res> {
  __$$ProtectionTemplateImplCopyWithImpl(_$ProtectionTemplateImpl _value,
      $Res Function(_$ProtectionTemplateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? manufacturer = freezed,
    Object? series = freezed,
    Object? isFavorite = null,
    Object? ratedCurrent = null,
    Object? curveType = null,
    Object? breakingCapacity = null,
    Object? poles = null,
    Object? deviceType = null,
    Object? sensitivity = freezed,
    Object? price = freezed,
  }) {
    return _then(_$ProtectionTemplateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      manufacturer: freezed == manufacturer
          ? _value.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String?,
      series: freezed == series
          ? _value.series
          : series // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      ratedCurrent: null == ratedCurrent
          ? _value.ratedCurrent
          : ratedCurrent // ignore: cast_nullable_to_non_nullable
              as double,
      curveType: null == curveType
          ? _value.curveType
          : curveType // ignore: cast_nullable_to_non_nullable
              as String,
      breakingCapacity: null == breakingCapacity
          ? _value.breakingCapacity
          : breakingCapacity // ignore: cast_nullable_to_non_nullable
              as double,
      poles: null == poles
          ? _value.poles
          : poles // ignore: cast_nullable_to_non_nullable
              as int,
      deviceType: null == deviceType
          ? _value.deviceType
          : deviceType // ignore: cast_nullable_to_non_nullable
              as ProtectionDeviceType,
      sensitivity: freezed == sensitivity
          ? _value.sensitivity
          : sensitivity // ignore: cast_nullable_to_non_nullable
              as double?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$ProtectionTemplateImpl implements ProtectionTemplate {
  const _$ProtectionTemplateImpl(
      {required this.id,
      required this.name,
      this.manufacturer,
      this.series,
      this.isFavorite = false,
      required this.ratedCurrent,
      required this.curveType,
      required this.breakingCapacity,
      required this.poles,
      this.deviceType = ProtectionDeviceType.circuitBreaker,
      this.sensitivity,
      this.price});

  @override
  final String id;
  @override
  final String name;
  @override
  final String? manufacturer;
  @override
  final String? series;
  @override
  @JsonKey()
  final bool isFavorite;
// Protection-specific attributes
  @override
  final double ratedCurrent;
// In (A)
  @override
  final String curveType;
// B, C, D, K, Z
  @override
  final double breakingCapacity;
// kA (PDC)
  @override
  final int poles;
// 1, 2, 3, 4
  @override
  @JsonKey()
  final ProtectionDeviceType deviceType;
  @override
  final double? sensitivity;
// For differential (mA)
  @override
  final double? price;

  @override
  String toString() {
    return 'ComponentTemplate.protection(id: $id, name: $name, manufacturer: $manufacturer, series: $series, isFavorite: $isFavorite, ratedCurrent: $ratedCurrent, curveType: $curveType, breakingCapacity: $breakingCapacity, poles: $poles, deviceType: $deviceType, sensitivity: $sensitivity, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProtectionTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.manufacturer, manufacturer) ||
                other.manufacturer == manufacturer) &&
            (identical(other.series, series) || other.series == series) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.ratedCurrent, ratedCurrent) ||
                other.ratedCurrent == ratedCurrent) &&
            (identical(other.curveType, curveType) ||
                other.curveType == curveType) &&
            (identical(other.breakingCapacity, breakingCapacity) ||
                other.breakingCapacity == breakingCapacity) &&
            (identical(other.poles, poles) || other.poles == poles) &&
            (identical(other.deviceType, deviceType) ||
                other.deviceType == deviceType) &&
            (identical(other.sensitivity, sensitivity) ||
                other.sensitivity == sensitivity) &&
            (identical(other.price, price) || other.price == price));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      manufacturer,
      series,
      isFavorite,
      ratedCurrent,
      curveType,
      breakingCapacity,
      poles,
      deviceType,
      sensitivity,
      price);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProtectionTemplateImplCopyWith<_$ProtectionTemplateImpl> get copyWith =>
      __$$ProtectionTemplateImplCopyWithImpl<_$ProtectionTemplateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double ratedCurrent,
            String curveType,
            double breakingCapacity,
            int poles,
            ProtectionDeviceType deviceType,
            double? sensitivity,
            double? price)
        protection,
    required TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double section,
            CableMaterial material,
            String insulationType,
            double maxOperatingTemp,
            String? installationMethod,
            double? price)
        cable,
    required TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double voltage,
            double maxShortCircuitCurrent,
            double? ratedPower,
            SourceType sourceType,
            double? price)
        source,
  }) {
    return protection(id, name, manufacturer, series, isFavorite, ratedCurrent,
        curveType, breakingCapacity, poles, deviceType, sensitivity, price);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double ratedCurrent,
            String curveType,
            double breakingCapacity,
            int poles,
            ProtectionDeviceType deviceType,
            double? sensitivity,
            double? price)?
        protection,
    TResult? Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double section,
            CableMaterial material,
            String insulationType,
            double maxOperatingTemp,
            String? installationMethod,
            double? price)?
        cable,
    TResult? Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double voltage,
            double maxShortCircuitCurrent,
            double? ratedPower,
            SourceType sourceType,
            double? price)?
        source,
  }) {
    return protection?.call(
        id,
        name,
        manufacturer,
        series,
        isFavorite,
        ratedCurrent,
        curveType,
        breakingCapacity,
        poles,
        deviceType,
        sensitivity,
        price);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double ratedCurrent,
            String curveType,
            double breakingCapacity,
            int poles,
            ProtectionDeviceType deviceType,
            double? sensitivity,
            double? price)?
        protection,
    TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double section,
            CableMaterial material,
            String insulationType,
            double maxOperatingTemp,
            String? installationMethod,
            double? price)?
        cable,
    TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double voltage,
            double maxShortCircuitCurrent,
            double? ratedPower,
            SourceType sourceType,
            double? price)?
        source,
    required TResult orElse(),
  }) {
    if (protection != null) {
      return protection(
          id,
          name,
          manufacturer,
          series,
          isFavorite,
          ratedCurrent,
          curveType,
          breakingCapacity,
          poles,
          deviceType,
          sensitivity,
          price);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProtectionTemplate value) protection,
    required TResult Function(CableTemplate value) cable,
    required TResult Function(SourceTemplate value) source,
  }) {
    return protection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProtectionTemplate value)? protection,
    TResult? Function(CableTemplate value)? cable,
    TResult? Function(SourceTemplate value)? source,
  }) {
    return protection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProtectionTemplate value)? protection,
    TResult Function(CableTemplate value)? cable,
    TResult Function(SourceTemplate value)? source,
    required TResult orElse(),
  }) {
    if (protection != null) {
      return protection(this);
    }
    return orElse();
  }
}

abstract class ProtectionTemplate implements ComponentTemplate {
  const factory ProtectionTemplate(
      {required final String id,
      required final String name,
      final String? manufacturer,
      final String? series,
      final bool isFavorite,
      required final double ratedCurrent,
      required final String curveType,
      required final double breakingCapacity,
      required final int poles,
      final ProtectionDeviceType deviceType,
      final double? sensitivity,
      final double? price}) = _$ProtectionTemplateImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get manufacturer;
  @override
  String? get series;
  @override
  bool get isFavorite; // Protection-specific attributes
  double get ratedCurrent; // In (A)
  String get curveType; // B, C, D, K, Z
  double get breakingCapacity; // kA (PDC)
  int get poles; // 1, 2, 3, 4
  ProtectionDeviceType get deviceType;
  double? get sensitivity;
  @override // For differential (mA)
  double? get price;
  @override
  @JsonKey(ignore: true)
  _$$ProtectionTemplateImplCopyWith<_$ProtectionTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CableTemplateImplCopyWith<$Res>
    implements $ComponentTemplateCopyWith<$Res> {
  factory _$$CableTemplateImplCopyWith(
          _$CableTemplateImpl value, $Res Function(_$CableTemplateImpl) then) =
      __$$CableTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? manufacturer,
      String? series,
      bool isFavorite,
      double section,
      CableMaterial material,
      String insulationType,
      double maxOperatingTemp,
      String? installationMethod,
      double? price});
}

/// @nodoc
class __$$CableTemplateImplCopyWithImpl<$Res>
    extends _$ComponentTemplateCopyWithImpl<$Res, _$CableTemplateImpl>
    implements _$$CableTemplateImplCopyWith<$Res> {
  __$$CableTemplateImplCopyWithImpl(
      _$CableTemplateImpl _value, $Res Function(_$CableTemplateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? manufacturer = freezed,
    Object? series = freezed,
    Object? isFavorite = null,
    Object? section = null,
    Object? material = null,
    Object? insulationType = null,
    Object? maxOperatingTemp = null,
    Object? installationMethod = freezed,
    Object? price = freezed,
  }) {
    return _then(_$CableTemplateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      manufacturer: freezed == manufacturer
          ? _value.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String?,
      series: freezed == series
          ? _value.series
          : series // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as double,
      material: null == material
          ? _value.material
          : material // ignore: cast_nullable_to_non_nullable
              as CableMaterial,
      insulationType: null == insulationType
          ? _value.insulationType
          : insulationType // ignore: cast_nullable_to_non_nullable
              as String,
      maxOperatingTemp: null == maxOperatingTemp
          ? _value.maxOperatingTemp
          : maxOperatingTemp // ignore: cast_nullable_to_non_nullable
              as double,
      installationMethod: freezed == installationMethod
          ? _value.installationMethod
          : installationMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$CableTemplateImpl implements CableTemplate {
  const _$CableTemplateImpl(
      {required this.id,
      required this.name,
      this.manufacturer,
      this.series,
      this.isFavorite = false,
      required this.section,
      required this.material,
      required this.insulationType,
      required this.maxOperatingTemp,
      this.installationMethod,
      this.price});

  @override
  final String id;
  @override
  final String name;
  @override
  final String? manufacturer;
  @override
  final String? series;
  @override
  @JsonKey()
  final bool isFavorite;
// Cable-specific attributes
  @override
  final double section;
// mm²
  @override
  final CableMaterial material;
// Copper or Aluminum
  @override
  final String insulationType;
// PVC, XLPE, EPR
  @override
  final double maxOperatingTemp;
// °C
  @override
  final String? installationMethod;
// B1, B2, C, D, E, F, G
  @override
  final double? price;

  @override
  String toString() {
    return 'ComponentTemplate.cable(id: $id, name: $name, manufacturer: $manufacturer, series: $series, isFavorite: $isFavorite, section: $section, material: $material, insulationType: $insulationType, maxOperatingTemp: $maxOperatingTemp, installationMethod: $installationMethod, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CableTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.manufacturer, manufacturer) ||
                other.manufacturer == manufacturer) &&
            (identical(other.series, series) || other.series == series) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.material, material) ||
                other.material == material) &&
            (identical(other.insulationType, insulationType) ||
                other.insulationType == insulationType) &&
            (identical(other.maxOperatingTemp, maxOperatingTemp) ||
                other.maxOperatingTemp == maxOperatingTemp) &&
            (identical(other.installationMethod, installationMethod) ||
                other.installationMethod == installationMethod) &&
            (identical(other.price, price) || other.price == price));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      manufacturer,
      series,
      isFavorite,
      section,
      material,
      insulationType,
      maxOperatingTemp,
      installationMethod,
      price);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CableTemplateImplCopyWith<_$CableTemplateImpl> get copyWith =>
      __$$CableTemplateImplCopyWithImpl<_$CableTemplateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double ratedCurrent,
            String curveType,
            double breakingCapacity,
            int poles,
            ProtectionDeviceType deviceType,
            double? sensitivity,
            double? price)
        protection,
    required TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double section,
            CableMaterial material,
            String insulationType,
            double maxOperatingTemp,
            String? installationMethod,
            double? price)
        cable,
    required TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double voltage,
            double maxShortCircuitCurrent,
            double? ratedPower,
            SourceType sourceType,
            double? price)
        source,
  }) {
    return cable(id, name, manufacturer, series, isFavorite, section, material,
        insulationType, maxOperatingTemp, installationMethod, price);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double ratedCurrent,
            String curveType,
            double breakingCapacity,
            int poles,
            ProtectionDeviceType deviceType,
            double? sensitivity,
            double? price)?
        protection,
    TResult? Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double section,
            CableMaterial material,
            String insulationType,
            double maxOperatingTemp,
            String? installationMethod,
            double? price)?
        cable,
    TResult? Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double voltage,
            double maxShortCircuitCurrent,
            double? ratedPower,
            SourceType sourceType,
            double? price)?
        source,
  }) {
    return cable?.call(id, name, manufacturer, series, isFavorite, section,
        material, insulationType, maxOperatingTemp, installationMethod, price);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double ratedCurrent,
            String curveType,
            double breakingCapacity,
            int poles,
            ProtectionDeviceType deviceType,
            double? sensitivity,
            double? price)?
        protection,
    TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double section,
            CableMaterial material,
            String insulationType,
            double maxOperatingTemp,
            String? installationMethod,
            double? price)?
        cable,
    TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double voltage,
            double maxShortCircuitCurrent,
            double? ratedPower,
            SourceType sourceType,
            double? price)?
        source,
    required TResult orElse(),
  }) {
    if (cable != null) {
      return cable(
          id,
          name,
          manufacturer,
          series,
          isFavorite,
          section,
          material,
          insulationType,
          maxOperatingTemp,
          installationMethod,
          price);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProtectionTemplate value) protection,
    required TResult Function(CableTemplate value) cable,
    required TResult Function(SourceTemplate value) source,
  }) {
    return cable(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProtectionTemplate value)? protection,
    TResult? Function(CableTemplate value)? cable,
    TResult? Function(SourceTemplate value)? source,
  }) {
    return cable?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProtectionTemplate value)? protection,
    TResult Function(CableTemplate value)? cable,
    TResult Function(SourceTemplate value)? source,
    required TResult orElse(),
  }) {
    if (cable != null) {
      return cable(this);
    }
    return orElse();
  }
}

abstract class CableTemplate implements ComponentTemplate {
  const factory CableTemplate(
      {required final String id,
      required final String name,
      final String? manufacturer,
      final String? series,
      final bool isFavorite,
      required final double section,
      required final CableMaterial material,
      required final String insulationType,
      required final double maxOperatingTemp,
      final String? installationMethod,
      final double? price}) = _$CableTemplateImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get manufacturer;
  @override
  String? get series;
  @override
  bool get isFavorite; // Cable-specific attributes
  double get section; // mm²
  CableMaterial get material; // Copper or Aluminum
  String get insulationType; // PVC, XLPE, EPR
  double get maxOperatingTemp; // °C
  String? get installationMethod;
  @override // B1, B2, C, D, E, F, G
  double? get price;
  @override
  @JsonKey(ignore: true)
  _$$CableTemplateImplCopyWith<_$CableTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SourceTemplateImplCopyWith<$Res>
    implements $ComponentTemplateCopyWith<$Res> {
  factory _$$SourceTemplateImplCopyWith(_$SourceTemplateImpl value,
          $Res Function(_$SourceTemplateImpl) then) =
      __$$SourceTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? manufacturer,
      String? series,
      bool isFavorite,
      double voltage,
      double maxShortCircuitCurrent,
      double? ratedPower,
      SourceType sourceType,
      double? price});
}

/// @nodoc
class __$$SourceTemplateImplCopyWithImpl<$Res>
    extends _$ComponentTemplateCopyWithImpl<$Res, _$SourceTemplateImpl>
    implements _$$SourceTemplateImplCopyWith<$Res> {
  __$$SourceTemplateImplCopyWithImpl(
      _$SourceTemplateImpl _value, $Res Function(_$SourceTemplateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? manufacturer = freezed,
    Object? series = freezed,
    Object? isFavorite = null,
    Object? voltage = null,
    Object? maxShortCircuitCurrent = null,
    Object? ratedPower = freezed,
    Object? sourceType = null,
    Object? price = freezed,
  }) {
    return _then(_$SourceTemplateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      manufacturer: freezed == manufacturer
          ? _value.manufacturer
          : manufacturer // ignore: cast_nullable_to_non_nullable
              as String?,
      series: freezed == series
          ? _value.series
          : series // ignore: cast_nullable_to_non_nullable
              as String?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      voltage: null == voltage
          ? _value.voltage
          : voltage // ignore: cast_nullable_to_non_nullable
              as double,
      maxShortCircuitCurrent: null == maxShortCircuitCurrent
          ? _value.maxShortCircuitCurrent
          : maxShortCircuitCurrent // ignore: cast_nullable_to_non_nullable
              as double,
      ratedPower: freezed == ratedPower
          ? _value.ratedPower
          : ratedPower // ignore: cast_nullable_to_non_nullable
              as double?,
      sourceType: null == sourceType
          ? _value.sourceType
          : sourceType // ignore: cast_nullable_to_non_nullable
              as SourceType,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$SourceTemplateImpl implements SourceTemplate {
  const _$SourceTemplateImpl(
      {required this.id,
      required this.name,
      this.manufacturer,
      this.series,
      this.isFavorite = false,
      required this.voltage,
      required this.maxShortCircuitCurrent,
      this.ratedPower,
      this.sourceType = SourceType.grid,
      this.price});

  @override
  final String id;
  @override
  final String name;
  @override
  final String? manufacturer;
  @override
  final String? series;
  @override
  @JsonKey()
  final bool isFavorite;
// Source-specific attributes
  @override
  final double voltage;
// V
  @override
  final double maxShortCircuitCurrent;
// Icc in kA
  @override
  final double? ratedPower;
// kVA (for transformers)
  @override
  @JsonKey()
  final SourceType sourceType;
  @override
  final double? price;

  @override
  String toString() {
    return 'ComponentTemplate.source(id: $id, name: $name, manufacturer: $manufacturer, series: $series, isFavorite: $isFavorite, voltage: $voltage, maxShortCircuitCurrent: $maxShortCircuitCurrent, ratedPower: $ratedPower, sourceType: $sourceType, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SourceTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.manufacturer, manufacturer) ||
                other.manufacturer == manufacturer) &&
            (identical(other.series, series) || other.series == series) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.voltage, voltage) || other.voltage == voltage) &&
            (identical(other.maxShortCircuitCurrent, maxShortCircuitCurrent) ||
                other.maxShortCircuitCurrent == maxShortCircuitCurrent) &&
            (identical(other.ratedPower, ratedPower) ||
                other.ratedPower == ratedPower) &&
            (identical(other.sourceType, sourceType) ||
                other.sourceType == sourceType) &&
            (identical(other.price, price) || other.price == price));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      manufacturer,
      series,
      isFavorite,
      voltage,
      maxShortCircuitCurrent,
      ratedPower,
      sourceType,
      price);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SourceTemplateImplCopyWith<_$SourceTemplateImpl> get copyWith =>
      __$$SourceTemplateImplCopyWithImpl<_$SourceTemplateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double ratedCurrent,
            String curveType,
            double breakingCapacity,
            int poles,
            ProtectionDeviceType deviceType,
            double? sensitivity,
            double? price)
        protection,
    required TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double section,
            CableMaterial material,
            String insulationType,
            double maxOperatingTemp,
            String? installationMethod,
            double? price)
        cable,
    required TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double voltage,
            double maxShortCircuitCurrent,
            double? ratedPower,
            SourceType sourceType,
            double? price)
        source,
  }) {
    return source(id, name, manufacturer, series, isFavorite, voltage,
        maxShortCircuitCurrent, ratedPower, sourceType, price);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double ratedCurrent,
            String curveType,
            double breakingCapacity,
            int poles,
            ProtectionDeviceType deviceType,
            double? sensitivity,
            double? price)?
        protection,
    TResult? Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double section,
            CableMaterial material,
            String insulationType,
            double maxOperatingTemp,
            String? installationMethod,
            double? price)?
        cable,
    TResult? Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double voltage,
            double maxShortCircuitCurrent,
            double? ratedPower,
            SourceType sourceType,
            double? price)?
        source,
  }) {
    return source?.call(id, name, manufacturer, series, isFavorite, voltage,
        maxShortCircuitCurrent, ratedPower, sourceType, price);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double ratedCurrent,
            String curveType,
            double breakingCapacity,
            int poles,
            ProtectionDeviceType deviceType,
            double? sensitivity,
            double? price)?
        protection,
    TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double section,
            CableMaterial material,
            String insulationType,
            double maxOperatingTemp,
            String? installationMethod,
            double? price)?
        cable,
    TResult Function(
            String id,
            String name,
            String? manufacturer,
            String? series,
            bool isFavorite,
            double voltage,
            double maxShortCircuitCurrent,
            double? ratedPower,
            SourceType sourceType,
            double? price)?
        source,
    required TResult orElse(),
  }) {
    if (source != null) {
      return source(id, name, manufacturer, series, isFavorite, voltage,
          maxShortCircuitCurrent, ratedPower, sourceType, price);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProtectionTemplate value) protection,
    required TResult Function(CableTemplate value) cable,
    required TResult Function(SourceTemplate value) source,
  }) {
    return source(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProtectionTemplate value)? protection,
    TResult? Function(CableTemplate value)? cable,
    TResult? Function(SourceTemplate value)? source,
  }) {
    return source?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProtectionTemplate value)? protection,
    TResult Function(CableTemplate value)? cable,
    TResult Function(SourceTemplate value)? source,
    required TResult orElse(),
  }) {
    if (source != null) {
      return source(this);
    }
    return orElse();
  }
}

abstract class SourceTemplate implements ComponentTemplate {
  const factory SourceTemplate(
      {required final String id,
      required final String name,
      final String? manufacturer,
      final String? series,
      final bool isFavorite,
      required final double voltage,
      required final double maxShortCircuitCurrent,
      final double? ratedPower,
      final SourceType sourceType,
      final double? price}) = _$SourceTemplateImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get manufacturer;
  @override
  String? get series;
  @override
  bool get isFavorite; // Source-specific attributes
  double get voltage; // V
  double get maxShortCircuitCurrent; // Icc in kA
  double? get ratedPower; // kVA (for transformers)
  SourceType get sourceType;
  @override
  double? get price;
  @override
  @JsonKey(ignore: true)
  _$$SourceTemplateImplCopyWith<_$SourceTemplateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
