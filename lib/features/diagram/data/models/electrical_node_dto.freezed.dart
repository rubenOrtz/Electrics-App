// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'electrical_node_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ElectricalNodeDto _$ElectricalNodeDtoFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'source':
      return SourceNodeDto.fromJson(json);
    case 'panel':
      return PanelNodeDto.fromJson(json);
    case 'protection':
      return ProtectionNodeDto.fromJson(json);
    case 'load':
      return LoadNodeDto.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'ElectricalNodeDto',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ElectricalNodeDto {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  ElectricalState get state =>
      throw _privateConstructorUsedError; // NEW: Acometida
  MeasurementState? get lastMeasurement =>
      throw _privateConstructorUsedError; // NEW: Forensic
  AssetMetadata get assetMetadata => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            double shortCircuitCapacity,
            ConductorAttributes? mainFeedCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)
        source,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)
        panel,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNodeDto> children,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)
        protection,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            double powerWatts,
            double cosPhi,
            bool isThreePhase,
            CatalogMetadata? cableCatalogData)
        load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            double shortCircuitCapacity,
            ConductorAttributes? mainFeedCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)?
        source,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)?
        panel,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNodeDto> children,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)?
        protection,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            double powerWatts,
            double cosPhi,
            bool isThreePhase,
            CatalogMetadata? cableCatalogData)?
        load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            double shortCircuitCapacity,
            ConductorAttributes? mainFeedCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)?
        source,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)?
        panel,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNodeDto> children,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)?
        protection,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            double powerWatts,
            double cosPhi,
            bool isThreePhase,
            CatalogMetadata? cableCatalogData)?
        load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SourceNodeDto value) source,
    required TResult Function(PanelNodeDto value) panel,
    required TResult Function(ProtectionNodeDto value) protection,
    required TResult Function(LoadNodeDto value) load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SourceNodeDto value)? source,
    TResult? Function(PanelNodeDto value)? panel,
    TResult? Function(ProtectionNodeDto value)? protection,
    TResult? Function(LoadNodeDto value)? load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SourceNodeDto value)? source,
    TResult Function(PanelNodeDto value)? panel,
    TResult Function(ProtectionNodeDto value)? protection,
    TResult Function(LoadNodeDto value)? load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ElectricalNodeDtoCopyWith<ElectricalNodeDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ElectricalNodeDtoCopyWith<$Res> {
  factory $ElectricalNodeDtoCopyWith(
          ElectricalNodeDto value, $Res Function(ElectricalNodeDto) then) =
      _$ElectricalNodeDtoCopyWithImpl<$Res, ElectricalNodeDto>;
  @useResult
  $Res call(
      {String id,
      String name,
      ElectricalState state,
      MeasurementState? lastMeasurement,
      AssetMetadata assetMetadata});

  $ElectricalStateCopyWith<$Res> get state;
  $MeasurementStateCopyWith<$Res>? get lastMeasurement;
}

/// @nodoc
class _$ElectricalNodeDtoCopyWithImpl<$Res, $Val extends ElectricalNodeDto>
    implements $ElectricalNodeDtoCopyWith<$Res> {
  _$ElectricalNodeDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? state = null,
    Object? lastMeasurement = freezed,
    Object? assetMetadata = null,
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
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ElectricalState,
      lastMeasurement: freezed == lastMeasurement
          ? _value.lastMeasurement
          : lastMeasurement // ignore: cast_nullable_to_non_nullable
              as MeasurementState?,
      assetMetadata: null == assetMetadata
          ? _value.assetMetadata
          : assetMetadata // ignore: cast_nullable_to_non_nullable
              as AssetMetadata,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ElectricalStateCopyWith<$Res> get state {
    return $ElectricalStateCopyWith<$Res>(_value.state, (value) {
      return _then(_value.copyWith(state: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MeasurementStateCopyWith<$Res>? get lastMeasurement {
    if (_value.lastMeasurement == null) {
      return null;
    }

    return $MeasurementStateCopyWith<$Res>(_value.lastMeasurement!, (value) {
      return _then(_value.copyWith(lastMeasurement: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SourceNodeDtoImplCopyWith<$Res>
    implements $ElectricalNodeDtoCopyWith<$Res> {
  factory _$$SourceNodeDtoImplCopyWith(
          _$SourceNodeDtoImpl value, $Res Function(_$SourceNodeDtoImpl) then) =
      __$$SourceNodeDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      ElectricalState state,
      double nominalVoltage,
      double shortCircuitCapacity,
      ConductorAttributes? mainFeedCable,
      MeasurementState? lastMeasurement,
      AssetMetadata assetMetadata,
      List<ElectricalNodeDto> children});

  @override
  $ElectricalStateCopyWith<$Res> get state;
  $ConductorAttributesCopyWith<$Res>? get mainFeedCable;
  @override
  $MeasurementStateCopyWith<$Res>? get lastMeasurement;
}

/// @nodoc
class __$$SourceNodeDtoImplCopyWithImpl<$Res>
    extends _$ElectricalNodeDtoCopyWithImpl<$Res, _$SourceNodeDtoImpl>
    implements _$$SourceNodeDtoImplCopyWith<$Res> {
  __$$SourceNodeDtoImplCopyWithImpl(
      _$SourceNodeDtoImpl _value, $Res Function(_$SourceNodeDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? state = null,
    Object? nominalVoltage = null,
    Object? shortCircuitCapacity = null,
    Object? mainFeedCable = freezed,
    Object? lastMeasurement = freezed,
    Object? assetMetadata = null,
    Object? children = null,
  }) {
    return _then(_$SourceNodeDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ElectricalState,
      nominalVoltage: null == nominalVoltage
          ? _value.nominalVoltage
          : nominalVoltage // ignore: cast_nullable_to_non_nullable
              as double,
      shortCircuitCapacity: null == shortCircuitCapacity
          ? _value.shortCircuitCapacity
          : shortCircuitCapacity // ignore: cast_nullable_to_non_nullable
              as double,
      mainFeedCable: freezed == mainFeedCable
          ? _value.mainFeedCable
          : mainFeedCable // ignore: cast_nullable_to_non_nullable
              as ConductorAttributes?,
      lastMeasurement: freezed == lastMeasurement
          ? _value.lastMeasurement
          : lastMeasurement // ignore: cast_nullable_to_non_nullable
              as MeasurementState?,
      assetMetadata: null == assetMetadata
          ? _value.assetMetadata
          : assetMetadata // ignore: cast_nullable_to_non_nullable
              as AssetMetadata,
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<ElectricalNodeDto>,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ConductorAttributesCopyWith<$Res>? get mainFeedCable {
    if (_value.mainFeedCable == null) {
      return null;
    }

    return $ConductorAttributesCopyWith<$Res>(_value.mainFeedCable!, (value) {
      return _then(_value.copyWith(mainFeedCable: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$SourceNodeDtoImpl implements SourceNodeDto {
  const _$SourceNodeDtoImpl(
      {required this.id,
      required this.name,
      this.state = const ElectricalState(),
      this.nominalVoltage = 230,
      this.shortCircuitCapacity = 10000,
      this.mainFeedCable,
      this.lastMeasurement,
      this.assetMetadata = const AssetMetadata(),
      final List<ElectricalNodeDto> children = const [],
      final String? $type})
      : _children = children,
        $type = $type ?? 'source';

  factory _$SourceNodeDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SourceNodeDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final ElectricalState state;
  @override
  @JsonKey()
  final double nominalVoltage;
  @override
  @JsonKey()
  final double shortCircuitCapacity;
  @override
  final ConductorAttributes? mainFeedCable;
// NEW: Acometida
  @override
  final MeasurementState? lastMeasurement;
// NEW: Forensic
  @override
  @JsonKey()
  final AssetMetadata assetMetadata;
  final List<ElectricalNodeDto> _children;
  @override
  @JsonKey()
  List<ElectricalNodeDto> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ElectricalNodeDto.source(id: $id, name: $name, state: $state, nominalVoltage: $nominalVoltage, shortCircuitCapacity: $shortCircuitCapacity, mainFeedCable: $mainFeedCable, lastMeasurement: $lastMeasurement, assetMetadata: $assetMetadata, children: $children)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SourceNodeDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.nominalVoltage, nominalVoltage) ||
                other.nominalVoltage == nominalVoltage) &&
            (identical(other.shortCircuitCapacity, shortCircuitCapacity) ||
                other.shortCircuitCapacity == shortCircuitCapacity) &&
            (identical(other.mainFeedCable, mainFeedCable) ||
                other.mainFeedCable == mainFeedCable) &&
            (identical(other.lastMeasurement, lastMeasurement) ||
                other.lastMeasurement == lastMeasurement) &&
            (identical(other.assetMetadata, assetMetadata) ||
                other.assetMetadata == assetMetadata) &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      state,
      nominalVoltage,
      shortCircuitCapacity,
      mainFeedCable,
      lastMeasurement,
      assetMetadata,
      const DeepCollectionEquality().hash(_children));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SourceNodeDtoImplCopyWith<_$SourceNodeDtoImpl> get copyWith =>
      __$$SourceNodeDtoImplCopyWithImpl<_$SourceNodeDtoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            double shortCircuitCapacity,
            ConductorAttributes? mainFeedCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)
        source,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)
        panel,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNodeDto> children,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)
        protection,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            double powerWatts,
            double cosPhi,
            bool isThreePhase,
            CatalogMetadata? cableCatalogData)
        load,
  }) {
    return source(id, name, state, nominalVoltage, shortCircuitCapacity,
        mainFeedCable, lastMeasurement, assetMetadata, children);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            double shortCircuitCapacity,
            ConductorAttributes? mainFeedCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)?
        source,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)?
        panel,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNodeDto> children,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)?
        protection,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            double powerWatts,
            double cosPhi,
            bool isThreePhase,
            CatalogMetadata? cableCatalogData)?
        load,
  }) {
    return source?.call(id, name, state, nominalVoltage, shortCircuitCapacity,
        mainFeedCable, lastMeasurement, assetMetadata, children);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            double shortCircuitCapacity,
            ConductorAttributes? mainFeedCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)?
        source,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)?
        panel,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNodeDto> children,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)?
        protection,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            double powerWatts,
            double cosPhi,
            bool isThreePhase,
            CatalogMetadata? cableCatalogData)?
        load,
    required TResult orElse(),
  }) {
    if (source != null) {
      return source(id, name, state, nominalVoltage, shortCircuitCapacity,
          mainFeedCable, lastMeasurement, assetMetadata, children);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SourceNodeDto value) source,
    required TResult Function(PanelNodeDto value) panel,
    required TResult Function(ProtectionNodeDto value) protection,
    required TResult Function(LoadNodeDto value) load,
  }) {
    return source(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SourceNodeDto value)? source,
    TResult? Function(PanelNodeDto value)? panel,
    TResult? Function(ProtectionNodeDto value)? protection,
    TResult? Function(LoadNodeDto value)? load,
  }) {
    return source?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SourceNodeDto value)? source,
    TResult Function(PanelNodeDto value)? panel,
    TResult Function(ProtectionNodeDto value)? protection,
    TResult Function(LoadNodeDto value)? load,
    required TResult orElse(),
  }) {
    if (source != null) {
      return source(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SourceNodeDtoImplToJson(
      this,
    );
  }
}

abstract class SourceNodeDto implements ElectricalNodeDto {
  const factory SourceNodeDto(
      {required final String id,
      required final String name,
      final ElectricalState state,
      final double nominalVoltage,
      final double shortCircuitCapacity,
      final ConductorAttributes? mainFeedCable,
      final MeasurementState? lastMeasurement,
      final AssetMetadata assetMetadata,
      final List<ElectricalNodeDto> children}) = _$SourceNodeDtoImpl;

  factory SourceNodeDto.fromJson(Map<String, dynamic> json) =
      _$SourceNodeDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  ElectricalState get state;
  double get nominalVoltage;
  double get shortCircuitCapacity;
  ConductorAttributes? get mainFeedCable;
  @override // NEW: Acometida
  MeasurementState? get lastMeasurement;
  @override // NEW: Forensic
  AssetMetadata get assetMetadata;
  List<ElectricalNodeDto> get children;
  @override
  @JsonKey(ignore: true)
  _$$SourceNodeDtoImplCopyWith<_$SourceNodeDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PanelNodeDtoImplCopyWith<$Res>
    implements $ElectricalNodeDtoCopyWith<$Res> {
  factory _$$PanelNodeDtoImplCopyWith(
          _$PanelNodeDtoImpl value, $Res Function(_$PanelNodeDtoImpl) then) =
      __$$PanelNodeDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      ElectricalState state,
      double nominalVoltage,
      ConductorAttributes? inputCable,
      MeasurementState? lastMeasurement,
      AssetMetadata assetMetadata,
      List<ElectricalNodeDto> children});

  @override
  $ElectricalStateCopyWith<$Res> get state;
  $ConductorAttributesCopyWith<$Res>? get inputCable;
  @override
  $MeasurementStateCopyWith<$Res>? get lastMeasurement;
}

/// @nodoc
class __$$PanelNodeDtoImplCopyWithImpl<$Res>
    extends _$ElectricalNodeDtoCopyWithImpl<$Res, _$PanelNodeDtoImpl>
    implements _$$PanelNodeDtoImplCopyWith<$Res> {
  __$$PanelNodeDtoImplCopyWithImpl(
      _$PanelNodeDtoImpl _value, $Res Function(_$PanelNodeDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? state = null,
    Object? nominalVoltage = null,
    Object? inputCable = freezed,
    Object? lastMeasurement = freezed,
    Object? assetMetadata = null,
    Object? children = null,
  }) {
    return _then(_$PanelNodeDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ElectricalState,
      nominalVoltage: null == nominalVoltage
          ? _value.nominalVoltage
          : nominalVoltage // ignore: cast_nullable_to_non_nullable
              as double,
      inputCable: freezed == inputCable
          ? _value.inputCable
          : inputCable // ignore: cast_nullable_to_non_nullable
              as ConductorAttributes?,
      lastMeasurement: freezed == lastMeasurement
          ? _value.lastMeasurement
          : lastMeasurement // ignore: cast_nullable_to_non_nullable
              as MeasurementState?,
      assetMetadata: null == assetMetadata
          ? _value.assetMetadata
          : assetMetadata // ignore: cast_nullable_to_non_nullable
              as AssetMetadata,
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<ElectricalNodeDto>,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ConductorAttributesCopyWith<$Res>? get inputCable {
    if (_value.inputCable == null) {
      return null;
    }

    return $ConductorAttributesCopyWith<$Res>(_value.inputCable!, (value) {
      return _then(_value.copyWith(inputCable: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$PanelNodeDtoImpl implements PanelNodeDto {
  const _$PanelNodeDtoImpl(
      {required this.id,
      required this.name,
      this.state = const ElectricalState(),
      this.nominalVoltage = 230,
      this.inputCable,
      this.lastMeasurement,
      this.assetMetadata = const AssetMetadata(),
      final List<ElectricalNodeDto> children = const [],
      final String? $type})
      : _children = children,
        $type = $type ?? 'panel';

  factory _$PanelNodeDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PanelNodeDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final ElectricalState state;
  @override
  @JsonKey()
  final double nominalVoltage;
  @override
  final ConductorAttributes? inputCable;
  @override
  final MeasurementState? lastMeasurement;
// NEW: Forensic
  @override
  @JsonKey()
  final AssetMetadata assetMetadata;
  final List<ElectricalNodeDto> _children;
  @override
  @JsonKey()
  List<ElectricalNodeDto> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ElectricalNodeDto.panel(id: $id, name: $name, state: $state, nominalVoltage: $nominalVoltage, inputCable: $inputCable, lastMeasurement: $lastMeasurement, assetMetadata: $assetMetadata, children: $children)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PanelNodeDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.nominalVoltage, nominalVoltage) ||
                other.nominalVoltage == nominalVoltage) &&
            (identical(other.inputCable, inputCable) ||
                other.inputCable == inputCable) &&
            (identical(other.lastMeasurement, lastMeasurement) ||
                other.lastMeasurement == lastMeasurement) &&
            (identical(other.assetMetadata, assetMetadata) ||
                other.assetMetadata == assetMetadata) &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      state,
      nominalVoltage,
      inputCable,
      lastMeasurement,
      assetMetadata,
      const DeepCollectionEquality().hash(_children));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PanelNodeDtoImplCopyWith<_$PanelNodeDtoImpl> get copyWith =>
      __$$PanelNodeDtoImplCopyWithImpl<_$PanelNodeDtoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            double shortCircuitCapacity,
            ConductorAttributes? mainFeedCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)
        source,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)
        panel,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNodeDto> children,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)
        protection,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            double powerWatts,
            double cosPhi,
            bool isThreePhase,
            CatalogMetadata? cableCatalogData)
        load,
  }) {
    return panel(id, name, state, nominalVoltage, inputCable, lastMeasurement,
        assetMetadata, children);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            double shortCircuitCapacity,
            ConductorAttributes? mainFeedCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)?
        source,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)?
        panel,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNodeDto> children,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)?
        protection,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            double powerWatts,
            double cosPhi,
            bool isThreePhase,
            CatalogMetadata? cableCatalogData)?
        load,
  }) {
    return panel?.call(id, name, state, nominalVoltage, inputCable,
        lastMeasurement, assetMetadata, children);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            double shortCircuitCapacity,
            ConductorAttributes? mainFeedCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)?
        source,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)?
        panel,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNodeDto> children,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)?
        protection,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            double powerWatts,
            double cosPhi,
            bool isThreePhase,
            CatalogMetadata? cableCatalogData)?
        load,
    required TResult orElse(),
  }) {
    if (panel != null) {
      return panel(id, name, state, nominalVoltage, inputCable, lastMeasurement,
          assetMetadata, children);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SourceNodeDto value) source,
    required TResult Function(PanelNodeDto value) panel,
    required TResult Function(ProtectionNodeDto value) protection,
    required TResult Function(LoadNodeDto value) load,
  }) {
    return panel(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SourceNodeDto value)? source,
    TResult? Function(PanelNodeDto value)? panel,
    TResult? Function(ProtectionNodeDto value)? protection,
    TResult? Function(LoadNodeDto value)? load,
  }) {
    return panel?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SourceNodeDto value)? source,
    TResult Function(PanelNodeDto value)? panel,
    TResult Function(ProtectionNodeDto value)? protection,
    TResult Function(LoadNodeDto value)? load,
    required TResult orElse(),
  }) {
    if (panel != null) {
      return panel(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PanelNodeDtoImplToJson(
      this,
    );
  }
}

abstract class PanelNodeDto implements ElectricalNodeDto {
  const factory PanelNodeDto(
      {required final String id,
      required final String name,
      final ElectricalState state,
      final double nominalVoltage,
      final ConductorAttributes? inputCable,
      final MeasurementState? lastMeasurement,
      final AssetMetadata assetMetadata,
      final List<ElectricalNodeDto> children}) = _$PanelNodeDtoImpl;

  factory PanelNodeDto.fromJson(Map<String, dynamic> json) =
      _$PanelNodeDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  ElectricalState get state;
  double get nominalVoltage;
  ConductorAttributes? get inputCable;
  @override
  MeasurementState? get lastMeasurement;
  @override // NEW: Forensic
  AssetMetadata get assetMetadata;
  List<ElectricalNodeDto> get children;
  @override
  @JsonKey(ignore: true)
  _$$PanelNodeDtoImplCopyWith<_$PanelNodeDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProtectionNodeDtoImplCopyWith<$Res>
    implements $ElectricalNodeDtoCopyWith<$Res> {
  factory _$$ProtectionNodeDtoImplCopyWith(_$ProtectionNodeDtoImpl value,
          $Res Function(_$ProtectionNodeDtoImpl) then) =
      __$$ProtectionNodeDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      ElectricalState state,
      MeasurementState? lastMeasurement,
      AssetMetadata assetMetadata,
      ProtectionType protectionType,
      double ratingAmps,
      double? pdc,
      String curve,
      double sensitivity,
      int poles,
      List<ElectricalNodeDto> children,
      CatalogMetadata? catalogData,
      CatalogMetadata? cableCatalogData});

  @override
  $ElectricalStateCopyWith<$Res> get state;
  @override
  $MeasurementStateCopyWith<$Res>? get lastMeasurement;
  $CatalogMetadataCopyWith<$Res>? get catalogData;
  $CatalogMetadataCopyWith<$Res>? get cableCatalogData;
}

/// @nodoc
class __$$ProtectionNodeDtoImplCopyWithImpl<$Res>
    extends _$ElectricalNodeDtoCopyWithImpl<$Res, _$ProtectionNodeDtoImpl>
    implements _$$ProtectionNodeDtoImplCopyWith<$Res> {
  __$$ProtectionNodeDtoImplCopyWithImpl(_$ProtectionNodeDtoImpl _value,
      $Res Function(_$ProtectionNodeDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? state = null,
    Object? lastMeasurement = freezed,
    Object? assetMetadata = null,
    Object? protectionType = null,
    Object? ratingAmps = null,
    Object? pdc = freezed,
    Object? curve = null,
    Object? sensitivity = null,
    Object? poles = null,
    Object? children = null,
    Object? catalogData = freezed,
    Object? cableCatalogData = freezed,
  }) {
    return _then(_$ProtectionNodeDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ElectricalState,
      lastMeasurement: freezed == lastMeasurement
          ? _value.lastMeasurement
          : lastMeasurement // ignore: cast_nullable_to_non_nullable
              as MeasurementState?,
      assetMetadata: null == assetMetadata
          ? _value.assetMetadata
          : assetMetadata // ignore: cast_nullable_to_non_nullable
              as AssetMetadata,
      protectionType: null == protectionType
          ? _value.protectionType
          : protectionType // ignore: cast_nullable_to_non_nullable
              as ProtectionType,
      ratingAmps: null == ratingAmps
          ? _value.ratingAmps
          : ratingAmps // ignore: cast_nullable_to_non_nullable
              as double,
      pdc: freezed == pdc
          ? _value.pdc
          : pdc // ignore: cast_nullable_to_non_nullable
              as double?,
      curve: null == curve
          ? _value.curve
          : curve // ignore: cast_nullable_to_non_nullable
              as String,
      sensitivity: null == sensitivity
          ? _value.sensitivity
          : sensitivity // ignore: cast_nullable_to_non_nullable
              as double,
      poles: null == poles
          ? _value.poles
          : poles // ignore: cast_nullable_to_non_nullable
              as int,
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<ElectricalNodeDto>,
      catalogData: freezed == catalogData
          ? _value.catalogData
          : catalogData // ignore: cast_nullable_to_non_nullable
              as CatalogMetadata?,
      cableCatalogData: freezed == cableCatalogData
          ? _value.cableCatalogData
          : cableCatalogData // ignore: cast_nullable_to_non_nullable
              as CatalogMetadata?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $CatalogMetadataCopyWith<$Res>? get catalogData {
    if (_value.catalogData == null) {
      return null;
    }

    return $CatalogMetadataCopyWith<$Res>(_value.catalogData!, (value) {
      return _then(_value.copyWith(catalogData: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CatalogMetadataCopyWith<$Res>? get cableCatalogData {
    if (_value.cableCatalogData == null) {
      return null;
    }

    return $CatalogMetadataCopyWith<$Res>(_value.cableCatalogData!, (value) {
      return _then(_value.copyWith(cableCatalogData: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$ProtectionNodeDtoImpl implements ProtectionNodeDto {
  const _$ProtectionNodeDtoImpl(
      {required this.id,
      required this.name,
      this.state = const ElectricalState(),
      this.lastMeasurement,
      this.assetMetadata = const AssetMetadata(),
      this.protectionType = ProtectionType.circuitBreaker,
      this.ratingAmps = 16,
      this.pdc,
      this.curve = "C",
      this.sensitivity = 30.0,
      this.poles = 2,
      final List<ElectricalNodeDto> children = const [],
      this.catalogData,
      this.cableCatalogData,
      final String? $type})
      : _children = children,
        $type = $type ?? 'protection';

  factory _$ProtectionNodeDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProtectionNodeDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final ElectricalState state;
// REMOVED: ConductorAttributes? inputCable,
  @override
  final MeasurementState? lastMeasurement;
// NEW: Forensic
  @override
  @JsonKey()
  final AssetMetadata assetMetadata;
  @override
  @JsonKey()
  final ProtectionType protectionType;
  @override
  @JsonKey()
  final double ratingAmps;
  @override
  final double? pdc;
  @override
  @JsonKey()
  final String curve;
  @override
  @JsonKey()
  final double sensitivity;
  @override
  @JsonKey()
  final int poles;
  final List<ElectricalNodeDto> _children;
  @override
  @JsonKey()
  List<ElectricalNodeDto> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @override
  final CatalogMetadata? catalogData;
  @override
  final CatalogMetadata? cableCatalogData;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ElectricalNodeDto.protection(id: $id, name: $name, state: $state, lastMeasurement: $lastMeasurement, assetMetadata: $assetMetadata, protectionType: $protectionType, ratingAmps: $ratingAmps, pdc: $pdc, curve: $curve, sensitivity: $sensitivity, poles: $poles, children: $children, catalogData: $catalogData, cableCatalogData: $cableCatalogData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProtectionNodeDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.lastMeasurement, lastMeasurement) ||
                other.lastMeasurement == lastMeasurement) &&
            (identical(other.assetMetadata, assetMetadata) ||
                other.assetMetadata == assetMetadata) &&
            (identical(other.protectionType, protectionType) ||
                other.protectionType == protectionType) &&
            (identical(other.ratingAmps, ratingAmps) ||
                other.ratingAmps == ratingAmps) &&
            (identical(other.pdc, pdc) || other.pdc == pdc) &&
            (identical(other.curve, curve) || other.curve == curve) &&
            (identical(other.sensitivity, sensitivity) ||
                other.sensitivity == sensitivity) &&
            (identical(other.poles, poles) || other.poles == poles) &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.catalogData, catalogData) ||
                other.catalogData == catalogData) &&
            (identical(other.cableCatalogData, cableCatalogData) ||
                other.cableCatalogData == cableCatalogData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      state,
      lastMeasurement,
      assetMetadata,
      protectionType,
      ratingAmps,
      pdc,
      curve,
      sensitivity,
      poles,
      const DeepCollectionEquality().hash(_children),
      catalogData,
      cableCatalogData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProtectionNodeDtoImplCopyWith<_$ProtectionNodeDtoImpl> get copyWith =>
      __$$ProtectionNodeDtoImplCopyWithImpl<_$ProtectionNodeDtoImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            double shortCircuitCapacity,
            ConductorAttributes? mainFeedCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)
        source,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)
        panel,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNodeDto> children,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)
        protection,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            double powerWatts,
            double cosPhi,
            bool isThreePhase,
            CatalogMetadata? cableCatalogData)
        load,
  }) {
    return protection(
        id,
        name,
        state,
        lastMeasurement,
        assetMetadata,
        protectionType,
        ratingAmps,
        pdc,
        curve,
        sensitivity,
        poles,
        children,
        catalogData,
        cableCatalogData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            double shortCircuitCapacity,
            ConductorAttributes? mainFeedCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)?
        source,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)?
        panel,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNodeDto> children,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)?
        protection,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            double powerWatts,
            double cosPhi,
            bool isThreePhase,
            CatalogMetadata? cableCatalogData)?
        load,
  }) {
    return protection?.call(
        id,
        name,
        state,
        lastMeasurement,
        assetMetadata,
        protectionType,
        ratingAmps,
        pdc,
        curve,
        sensitivity,
        poles,
        children,
        catalogData,
        cableCatalogData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            double shortCircuitCapacity,
            ConductorAttributes? mainFeedCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)?
        source,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)?
        panel,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNodeDto> children,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)?
        protection,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            double powerWatts,
            double cosPhi,
            bool isThreePhase,
            CatalogMetadata? cableCatalogData)?
        load,
    required TResult orElse(),
  }) {
    if (protection != null) {
      return protection(
          id,
          name,
          state,
          lastMeasurement,
          assetMetadata,
          protectionType,
          ratingAmps,
          pdc,
          curve,
          sensitivity,
          poles,
          children,
          catalogData,
          cableCatalogData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SourceNodeDto value) source,
    required TResult Function(PanelNodeDto value) panel,
    required TResult Function(ProtectionNodeDto value) protection,
    required TResult Function(LoadNodeDto value) load,
  }) {
    return protection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SourceNodeDto value)? source,
    TResult? Function(PanelNodeDto value)? panel,
    TResult? Function(ProtectionNodeDto value)? protection,
    TResult? Function(LoadNodeDto value)? load,
  }) {
    return protection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SourceNodeDto value)? source,
    TResult Function(PanelNodeDto value)? panel,
    TResult Function(ProtectionNodeDto value)? protection,
    TResult Function(LoadNodeDto value)? load,
    required TResult orElse(),
  }) {
    if (protection != null) {
      return protection(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ProtectionNodeDtoImplToJson(
      this,
    );
  }
}

abstract class ProtectionNodeDto implements ElectricalNodeDto {
  const factory ProtectionNodeDto(
      {required final String id,
      required final String name,
      final ElectricalState state,
      final MeasurementState? lastMeasurement,
      final AssetMetadata assetMetadata,
      final ProtectionType protectionType,
      final double ratingAmps,
      final double? pdc,
      final String curve,
      final double sensitivity,
      final int poles,
      final List<ElectricalNodeDto> children,
      final CatalogMetadata? catalogData,
      final CatalogMetadata? cableCatalogData}) = _$ProtectionNodeDtoImpl;

  factory ProtectionNodeDto.fromJson(Map<String, dynamic> json) =
      _$ProtectionNodeDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  ElectricalState get state;
  @override // REMOVED: ConductorAttributes? inputCable,
  MeasurementState? get lastMeasurement;
  @override // NEW: Forensic
  AssetMetadata get assetMetadata;
  ProtectionType get protectionType;
  double get ratingAmps;
  double? get pdc;
  String get curve;
  double get sensitivity;
  int get poles;
  List<ElectricalNodeDto> get children;
  CatalogMetadata? get catalogData;
  CatalogMetadata? get cableCatalogData;
  @override
  @JsonKey(ignore: true)
  _$$ProtectionNodeDtoImplCopyWith<_$ProtectionNodeDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadNodeDtoImplCopyWith<$Res>
    implements $ElectricalNodeDtoCopyWith<$Res> {
  factory _$$LoadNodeDtoImplCopyWith(
          _$LoadNodeDtoImpl value, $Res Function(_$LoadNodeDtoImpl) then) =
      __$$LoadNodeDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      ElectricalState state,
      ConductorAttributes? inputCable,
      MeasurementState? lastMeasurement,
      AssetMetadata assetMetadata,
      double powerWatts,
      double cosPhi,
      bool isThreePhase,
      CatalogMetadata? cableCatalogData});

  @override
  $ElectricalStateCopyWith<$Res> get state;
  $ConductorAttributesCopyWith<$Res>? get inputCable;
  @override
  $MeasurementStateCopyWith<$Res>? get lastMeasurement;
  $CatalogMetadataCopyWith<$Res>? get cableCatalogData;
}

/// @nodoc
class __$$LoadNodeDtoImplCopyWithImpl<$Res>
    extends _$ElectricalNodeDtoCopyWithImpl<$Res, _$LoadNodeDtoImpl>
    implements _$$LoadNodeDtoImplCopyWith<$Res> {
  __$$LoadNodeDtoImplCopyWithImpl(
      _$LoadNodeDtoImpl _value, $Res Function(_$LoadNodeDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? state = null,
    Object? inputCable = freezed,
    Object? lastMeasurement = freezed,
    Object? assetMetadata = null,
    Object? powerWatts = null,
    Object? cosPhi = null,
    Object? isThreePhase = null,
    Object? cableCatalogData = freezed,
  }) {
    return _then(_$LoadNodeDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ElectricalState,
      inputCable: freezed == inputCable
          ? _value.inputCable
          : inputCable // ignore: cast_nullable_to_non_nullable
              as ConductorAttributes?,
      lastMeasurement: freezed == lastMeasurement
          ? _value.lastMeasurement
          : lastMeasurement // ignore: cast_nullable_to_non_nullable
              as MeasurementState?,
      assetMetadata: null == assetMetadata
          ? _value.assetMetadata
          : assetMetadata // ignore: cast_nullable_to_non_nullable
              as AssetMetadata,
      powerWatts: null == powerWatts
          ? _value.powerWatts
          : powerWatts // ignore: cast_nullable_to_non_nullable
              as double,
      cosPhi: null == cosPhi
          ? _value.cosPhi
          : cosPhi // ignore: cast_nullable_to_non_nullable
              as double,
      isThreePhase: null == isThreePhase
          ? _value.isThreePhase
          : isThreePhase // ignore: cast_nullable_to_non_nullable
              as bool,
      cableCatalogData: freezed == cableCatalogData
          ? _value.cableCatalogData
          : cableCatalogData // ignore: cast_nullable_to_non_nullable
              as CatalogMetadata?,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ConductorAttributesCopyWith<$Res>? get inputCable {
    if (_value.inputCable == null) {
      return null;
    }

    return $ConductorAttributesCopyWith<$Res>(_value.inputCable!, (value) {
      return _then(_value.copyWith(inputCable: value));
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CatalogMetadataCopyWith<$Res>? get cableCatalogData {
    if (_value.cableCatalogData == null) {
      return null;
    }

    return $CatalogMetadataCopyWith<$Res>(_value.cableCatalogData!, (value) {
      return _then(_value.copyWith(cableCatalogData: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$LoadNodeDtoImpl implements LoadNodeDto {
  const _$LoadNodeDtoImpl(
      {required this.id,
      required this.name,
      this.state = const ElectricalState(),
      this.inputCable,
      this.lastMeasurement,
      this.assetMetadata = const AssetMetadata(),
      this.powerWatts = 3000,
      this.cosPhi = 0.9,
      this.isThreePhase = false,
      this.cableCatalogData,
      final String? $type})
      : $type = $type ?? 'load';

  factory _$LoadNodeDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoadNodeDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final ElectricalState state;
  @override
  final ConductorAttributes? inputCable;
  @override
  final MeasurementState? lastMeasurement;
// NEW: Forensic
  @override
  @JsonKey()
  final AssetMetadata assetMetadata;
  @override
  @JsonKey()
  final double powerWatts;
  @override
  @JsonKey()
  final double cosPhi;
  @override
  @JsonKey()
  final bool isThreePhase;
  @override
  final CatalogMetadata? cableCatalogData;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ElectricalNodeDto.load(id: $id, name: $name, state: $state, inputCable: $inputCable, lastMeasurement: $lastMeasurement, assetMetadata: $assetMetadata, powerWatts: $powerWatts, cosPhi: $cosPhi, isThreePhase: $isThreePhase, cableCatalogData: $cableCatalogData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadNodeDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.inputCable, inputCable) ||
                other.inputCable == inputCable) &&
            (identical(other.lastMeasurement, lastMeasurement) ||
                other.lastMeasurement == lastMeasurement) &&
            (identical(other.assetMetadata, assetMetadata) ||
                other.assetMetadata == assetMetadata) &&
            (identical(other.powerWatts, powerWatts) ||
                other.powerWatts == powerWatts) &&
            (identical(other.cosPhi, cosPhi) || other.cosPhi == cosPhi) &&
            (identical(other.isThreePhase, isThreePhase) ||
                other.isThreePhase == isThreePhase) &&
            (identical(other.cableCatalogData, cableCatalogData) ||
                other.cableCatalogData == cableCatalogData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      state,
      inputCable,
      lastMeasurement,
      assetMetadata,
      powerWatts,
      cosPhi,
      isThreePhase,
      cableCatalogData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadNodeDtoImplCopyWith<_$LoadNodeDtoImpl> get copyWith =>
      __$$LoadNodeDtoImplCopyWithImpl<_$LoadNodeDtoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            double shortCircuitCapacity,
            ConductorAttributes? mainFeedCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)
        source,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)
        panel,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNodeDto> children,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)
        protection,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            double powerWatts,
            double cosPhi,
            bool isThreePhase,
            CatalogMetadata? cableCatalogData)
        load,
  }) {
    return load(id, name, state, inputCable, lastMeasurement, assetMetadata,
        powerWatts, cosPhi, isThreePhase, cableCatalogData);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            double shortCircuitCapacity,
            ConductorAttributes? mainFeedCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)?
        source,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)?
        panel,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNodeDto> children,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)?
        protection,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            double powerWatts,
            double cosPhi,
            bool isThreePhase,
            CatalogMetadata? cableCatalogData)?
        load,
  }) {
    return load?.call(id, name, state, inputCable, lastMeasurement,
        assetMetadata, powerWatts, cosPhi, isThreePhase, cableCatalogData);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            double shortCircuitCapacity,
            ConductorAttributes? mainFeedCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)?
        source,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            List<ElectricalNodeDto> children)?
        panel,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNodeDto> children,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)?
        protection,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            double powerWatts,
            double cosPhi,
            bool isThreePhase,
            CatalogMetadata? cableCatalogData)?
        load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(id, name, state, inputCable, lastMeasurement, assetMetadata,
          powerWatts, cosPhi, isThreePhase, cableCatalogData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SourceNodeDto value) source,
    required TResult Function(PanelNodeDto value) panel,
    required TResult Function(ProtectionNodeDto value) protection,
    required TResult Function(LoadNodeDto value) load,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SourceNodeDto value)? source,
    TResult? Function(PanelNodeDto value)? panel,
    TResult? Function(ProtectionNodeDto value)? protection,
    TResult? Function(LoadNodeDto value)? load,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SourceNodeDto value)? source,
    TResult Function(PanelNodeDto value)? panel,
    TResult Function(ProtectionNodeDto value)? protection,
    TResult Function(LoadNodeDto value)? load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LoadNodeDtoImplToJson(
      this,
    );
  }
}

abstract class LoadNodeDto implements ElectricalNodeDto {
  const factory LoadNodeDto(
      {required final String id,
      required final String name,
      final ElectricalState state,
      final ConductorAttributes? inputCable,
      final MeasurementState? lastMeasurement,
      final AssetMetadata assetMetadata,
      final double powerWatts,
      final double cosPhi,
      final bool isThreePhase,
      final CatalogMetadata? cableCatalogData}) = _$LoadNodeDtoImpl;

  factory LoadNodeDto.fromJson(Map<String, dynamic> json) =
      _$LoadNodeDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  ElectricalState get state;
  ConductorAttributes? get inputCable;
  @override
  MeasurementState? get lastMeasurement;
  @override // NEW: Forensic
  AssetMetadata get assetMetadata;
  double get powerWatts;
  double get cosPhi;
  bool get isThreePhase;
  CatalogMetadata? get cableCatalogData;
  @override
  @JsonKey(ignore: true)
  _$$LoadNodeDtoImplCopyWith<_$LoadNodeDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
