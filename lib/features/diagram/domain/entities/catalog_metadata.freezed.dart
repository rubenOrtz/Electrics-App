// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CatalogMetadata _$CatalogMetadataFromJson(Map<String, dynamic> json) {
  return _CatalogMetadata.fromJson(json);
}

/// @nodoc
mixin _$CatalogMetadata {
  String get componentId => throw _privateConstructorUsedError;
  String get brand => throw _privateConstructorUsedError;
  String? get series => throw _privateConstructorUsedError;
  String? get reference => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CatalogMetadataCopyWith<CatalogMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatalogMetadataCopyWith<$Res> {
  factory $CatalogMetadataCopyWith(
          CatalogMetadata value, $Res Function(CatalogMetadata) then) =
      _$CatalogMetadataCopyWithImpl<$Res, CatalogMetadata>;
  @useResult
  $Res call(
      {String componentId,
      String brand,
      String? series,
      String? reference,
      String displayName});
}

/// @nodoc
class _$CatalogMetadataCopyWithImpl<$Res, $Val extends CatalogMetadata>
    implements $CatalogMetadataCopyWith<$Res> {
  _$CatalogMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? componentId = null,
    Object? brand = null,
    Object? series = freezed,
    Object? reference = freezed,
    Object? displayName = null,
  }) {
    return _then(_value.copyWith(
      componentId: null == componentId
          ? _value.componentId
          : componentId // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      series: freezed == series
          ? _value.series
          : series // ignore: cast_nullable_to_non_nullable
              as String?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CatalogMetadataImplCopyWith<$Res>
    implements $CatalogMetadataCopyWith<$Res> {
  factory _$$CatalogMetadataImplCopyWith(_$CatalogMetadataImpl value,
          $Res Function(_$CatalogMetadataImpl) then) =
      __$$CatalogMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String componentId,
      String brand,
      String? series,
      String? reference,
      String displayName});
}

/// @nodoc
class __$$CatalogMetadataImplCopyWithImpl<$Res>
    extends _$CatalogMetadataCopyWithImpl<$Res, _$CatalogMetadataImpl>
    implements _$$CatalogMetadataImplCopyWith<$Res> {
  __$$CatalogMetadataImplCopyWithImpl(
      _$CatalogMetadataImpl _value, $Res Function(_$CatalogMetadataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? componentId = null,
    Object? brand = null,
    Object? series = freezed,
    Object? reference = freezed,
    Object? displayName = null,
  }) {
    return _then(_$CatalogMetadataImpl(
      componentId: null == componentId
          ? _value.componentId
          : componentId // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      series: freezed == series
          ? _value.series
          : series // ignore: cast_nullable_to_non_nullable
              as String?,
      reference: freezed == reference
          ? _value.reference
          : reference // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CatalogMetadataImpl implements _CatalogMetadata {
  const _$CatalogMetadataImpl(
      {required this.componentId,
      required this.brand,
      this.series,
      this.reference,
      required this.displayName});

  factory _$CatalogMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$CatalogMetadataImplFromJson(json);

  @override
  final String componentId;
  @override
  final String brand;
  @override
  final String? series;
  @override
  final String? reference;
  @override
  final String displayName;

  @override
  String toString() {
    return 'CatalogMetadata(componentId: $componentId, brand: $brand, series: $series, reference: $reference, displayName: $displayName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatalogMetadataImpl &&
            (identical(other.componentId, componentId) ||
                other.componentId == componentId) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.series, series) || other.series == series) &&
            (identical(other.reference, reference) ||
                other.reference == reference) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, componentId, brand, series, reference, displayName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CatalogMetadataImplCopyWith<_$CatalogMetadataImpl> get copyWith =>
      __$$CatalogMetadataImplCopyWithImpl<_$CatalogMetadataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CatalogMetadataImplToJson(
      this,
    );
  }
}

abstract class _CatalogMetadata implements CatalogMetadata {
  const factory _CatalogMetadata(
      {required final String componentId,
      required final String brand,
      final String? series,
      final String? reference,
      required final String displayName}) = _$CatalogMetadataImpl;

  factory _CatalogMetadata.fromJson(Map<String, dynamic> json) =
      _$CatalogMetadataImpl.fromJson;

  @override
  String get componentId;
  @override
  String get brand;
  @override
  String? get series;
  @override
  String? get reference;
  @override
  String get displayName;
  @override
  @JsonKey(ignore: true)
  _$$CatalogMetadataImplCopyWith<_$CatalogMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
