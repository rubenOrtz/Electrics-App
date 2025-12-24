// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'electrical_node.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ElectricalNode {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  ElectricalState get state =>
      throw _privateConstructorUsedError; // Calculation result
  CalculationResult? get result =>
      throw _privateConstructorUsedError; // Real measurements
  MeasurementState? get lastMeasurement =>
      throw _privateConstructorUsedError; // Asset Management
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
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)
        source,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)
        panel,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)
        protection,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            double powerWatts,
            double cosPhi,
            LoadType type,
            bool isThreePhase,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
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
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)?
        source,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)?
        panel,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)?
        protection,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            double powerWatts,
            double cosPhi,
            LoadType type,
            bool isThreePhase,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
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
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)?
        source,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)?
        panel,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)?
        protection,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            double powerWatts,
            double cosPhi,
            LoadType type,
            bool isThreePhase,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? cableCatalogData)?
        load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SourceNode value) source,
    required TResult Function(PanelNode value) panel,
    required TResult Function(ProtectionNode value) protection,
    required TResult Function(LoadNode value) load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SourceNode value)? source,
    TResult? Function(PanelNode value)? panel,
    TResult? Function(ProtectionNode value)? protection,
    TResult? Function(LoadNode value)? load,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SourceNode value)? source,
    TResult Function(PanelNode value)? panel,
    TResult Function(ProtectionNode value)? protection,
    TResult Function(LoadNode value)? load,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ElectricalNodeCopyWith<ElectricalNode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ElectricalNodeCopyWith<$Res> {
  factory $ElectricalNodeCopyWith(
          ElectricalNode value, $Res Function(ElectricalNode) then) =
      _$ElectricalNodeCopyWithImpl<$Res, ElectricalNode>;
  @useResult
  $Res call(
      {String id,
      String name,
      ElectricalState state,
      CalculationResult? result,
      MeasurementState? lastMeasurement,
      AssetMetadata assetMetadata});

  $ElectricalStateCopyWith<$Res> get state;
  $CalculationResultCopyWith<$Res>? get result;
  $MeasurementStateCopyWith<$Res>? get lastMeasurement;
}

/// @nodoc
class _$ElectricalNodeCopyWithImpl<$Res, $Val extends ElectricalNode>
    implements $ElectricalNodeCopyWith<$Res> {
  _$ElectricalNodeCopyWithImpl(this._value, this._then);

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
    Object? result = freezed,
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
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as CalculationResult?,
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
  $CalculationResultCopyWith<$Res>? get result {
    if (_value.result == null) {
      return null;
    }

    return $CalculationResultCopyWith<$Res>(_value.result!, (value) {
      return _then(_value.copyWith(result: value) as $Val);
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
abstract class _$$SourceNodeImplCopyWith<$Res>
    implements $ElectricalNodeCopyWith<$Res> {
  factory _$$SourceNodeImplCopyWith(
          _$SourceNodeImpl value, $Res Function(_$SourceNodeImpl) then) =
      __$$SourceNodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      ElectricalState state,
      double nominalVoltage,
      double shortCircuitCapacity,
      ConductorAttributes? mainFeedCable,
      List<ElectricalNode> children,
      CalculationResult? result,
      MeasurementState? lastMeasurement,
      AssetMetadata assetMetadata});

  @override
  $ElectricalStateCopyWith<$Res> get state;
  $ConductorAttributesCopyWith<$Res>? get mainFeedCable;
  @override
  $CalculationResultCopyWith<$Res>? get result;
  @override
  $MeasurementStateCopyWith<$Res>? get lastMeasurement;
}

/// @nodoc
class __$$SourceNodeImplCopyWithImpl<$Res>
    extends _$ElectricalNodeCopyWithImpl<$Res, _$SourceNodeImpl>
    implements _$$SourceNodeImplCopyWith<$Res> {
  __$$SourceNodeImplCopyWithImpl(
      _$SourceNodeImpl _value, $Res Function(_$SourceNodeImpl) _then)
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
    Object? children = null,
    Object? result = freezed,
    Object? lastMeasurement = freezed,
    Object? assetMetadata = null,
  }) {
    return _then(_$SourceNodeImpl(
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
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<ElectricalNode>,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as CalculationResult?,
      lastMeasurement: freezed == lastMeasurement
          ? _value.lastMeasurement
          : lastMeasurement // ignore: cast_nullable_to_non_nullable
              as MeasurementState?,
      assetMetadata: null == assetMetadata
          ? _value.assetMetadata
          : assetMetadata // ignore: cast_nullable_to_non_nullable
              as AssetMetadata,
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

class _$SourceNodeImpl implements SourceNode {
  const _$SourceNodeImpl(
      {required this.id,
      required this.name,
      this.state = const ElectricalState(),
      this.nominalVoltage = 230,
      this.shortCircuitCapacity = 10000,
      this.mainFeedCable,
      final List<ElectricalNode> children = const [],
      this.result,
      this.lastMeasurement,
      this.assetMetadata = const AssetMetadata()})
      : _children = children;

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
// Icc at source
// Main feed cable (Acometida → Cuadro Principal)
// Default: null (simulates starting directly at panel)
  @override
  final ConductorAttributes? mainFeedCable;
  final List<ElectricalNode> _children;
  @override
  @JsonKey()
  List<ElectricalNode> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

// Calculation result
  @override
  final CalculationResult? result;
// Real measurements
  @override
  final MeasurementState? lastMeasurement;
// Asset Management
  @override
  @JsonKey()
  final AssetMetadata assetMetadata;

  @override
  String toString() {
    return 'ElectricalNode.source(id: $id, name: $name, state: $state, nominalVoltage: $nominalVoltage, shortCircuitCapacity: $shortCircuitCapacity, mainFeedCable: $mainFeedCable, children: $children, result: $result, lastMeasurement: $lastMeasurement, assetMetadata: $assetMetadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SourceNodeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.nominalVoltage, nominalVoltage) ||
                other.nominalVoltage == nominalVoltage) &&
            (identical(other.shortCircuitCapacity, shortCircuitCapacity) ||
                other.shortCircuitCapacity == shortCircuitCapacity) &&
            (identical(other.mainFeedCable, mainFeedCable) ||
                other.mainFeedCable == mainFeedCable) &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.lastMeasurement, lastMeasurement) ||
                other.lastMeasurement == lastMeasurement) &&
            (identical(other.assetMetadata, assetMetadata) ||
                other.assetMetadata == assetMetadata));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      state,
      nominalVoltage,
      shortCircuitCapacity,
      mainFeedCable,
      const DeepCollectionEquality().hash(_children),
      result,
      lastMeasurement,
      assetMetadata);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SourceNodeImplCopyWith<_$SourceNodeImpl> get copyWith =>
      __$$SourceNodeImplCopyWithImpl<_$SourceNodeImpl>(this, _$identity);

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
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)
        source,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)
        panel,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)
        protection,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            double powerWatts,
            double cosPhi,
            LoadType type,
            bool isThreePhase,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? cableCatalogData)
        load,
  }) {
    return source(id, name, state, nominalVoltage, shortCircuitCapacity,
        mainFeedCable, children, result, lastMeasurement, assetMetadata);
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
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)?
        source,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)?
        panel,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)?
        protection,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            double powerWatts,
            double cosPhi,
            LoadType type,
            bool isThreePhase,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? cableCatalogData)?
        load,
  }) {
    return source?.call(id, name, state, nominalVoltage, shortCircuitCapacity,
        mainFeedCable, children, result, lastMeasurement, assetMetadata);
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
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)?
        source,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)?
        panel,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)?
        protection,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            double powerWatts,
            double cosPhi,
            LoadType type,
            bool isThreePhase,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? cableCatalogData)?
        load,
    required TResult orElse(),
  }) {
    if (source != null) {
      return source(id, name, state, nominalVoltage, shortCircuitCapacity,
          mainFeedCable, children, result, lastMeasurement, assetMetadata);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SourceNode value) source,
    required TResult Function(PanelNode value) panel,
    required TResult Function(ProtectionNode value) protection,
    required TResult Function(LoadNode value) load,
  }) {
    return source(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SourceNode value)? source,
    TResult? Function(PanelNode value)? panel,
    TResult? Function(ProtectionNode value)? protection,
    TResult? Function(LoadNode value)? load,
  }) {
    return source?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SourceNode value)? source,
    TResult Function(PanelNode value)? panel,
    TResult Function(ProtectionNode value)? protection,
    TResult Function(LoadNode value)? load,
    required TResult orElse(),
  }) {
    if (source != null) {
      return source(this);
    }
    return orElse();
  }
}

abstract class SourceNode implements ElectricalNode {
  const factory SourceNode(
      {required final String id,
      required final String name,
      final ElectricalState state,
      final double nominalVoltage,
      final double shortCircuitCapacity,
      final ConductorAttributes? mainFeedCable,
      final List<ElectricalNode> children,
      final CalculationResult? result,
      final MeasurementState? lastMeasurement,
      final AssetMetadata assetMetadata}) = _$SourceNodeImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  ElectricalState get state;
  double get nominalVoltage;
  double get shortCircuitCapacity; // Icc at source
// Main feed cable (Acometida → Cuadro Principal)
// Default: null (simulates starting directly at panel)
  ConductorAttributes? get mainFeedCable;
  List<ElectricalNode> get children;
  @override // Calculation result
  CalculationResult? get result;
  @override // Real measurements
  MeasurementState? get lastMeasurement;
  @override // Asset Management
  AssetMetadata get assetMetadata;
  @override
  @JsonKey(ignore: true)
  _$$SourceNodeImplCopyWith<_$SourceNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PanelNodeImplCopyWith<$Res>
    implements $ElectricalNodeCopyWith<$Res> {
  factory _$$PanelNodeImplCopyWith(
          _$PanelNodeImpl value, $Res Function(_$PanelNodeImpl) then) =
      __$$PanelNodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      ElectricalState state,
      double nominalVoltage,
      ConductorAttributes? inputCable,
      List<ElectricalNode> children,
      CalculationResult? result,
      MeasurementState? lastMeasurement,
      AssetMetadata assetMetadata});

  @override
  $ElectricalStateCopyWith<$Res> get state;
  $ConductorAttributesCopyWith<$Res>? get inputCable;
  @override
  $CalculationResultCopyWith<$Res>? get result;
  @override
  $MeasurementStateCopyWith<$Res>? get lastMeasurement;
}

/// @nodoc
class __$$PanelNodeImplCopyWithImpl<$Res>
    extends _$ElectricalNodeCopyWithImpl<$Res, _$PanelNodeImpl>
    implements _$$PanelNodeImplCopyWith<$Res> {
  __$$PanelNodeImplCopyWithImpl(
      _$PanelNodeImpl _value, $Res Function(_$PanelNodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? state = null,
    Object? nominalVoltage = null,
    Object? inputCable = freezed,
    Object? children = null,
    Object? result = freezed,
    Object? lastMeasurement = freezed,
    Object? assetMetadata = null,
  }) {
    return _then(_$PanelNodeImpl(
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
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<ElectricalNode>,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as CalculationResult?,
      lastMeasurement: freezed == lastMeasurement
          ? _value.lastMeasurement
          : lastMeasurement // ignore: cast_nullable_to_non_nullable
              as MeasurementState?,
      assetMetadata: null == assetMetadata
          ? _value.assetMetadata
          : assetMetadata // ignore: cast_nullable_to_non_nullable
              as AssetMetadata,
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

class _$PanelNodeImpl implements PanelNode {
  const _$PanelNodeImpl(
      {required this.id,
      required this.name,
      this.state = const ElectricalState(),
      this.nominalVoltage = 230,
      this.inputCable,
      final List<ElectricalNode> children = const [],
      this.result,
      this.lastMeasurement,
      this.assetMetadata = const AssetMetadata()})
      : _children = children;

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
// Connection from Parent
  @override
  final ConductorAttributes? inputCable;
  final List<ElectricalNode> _children;
  @override
  @JsonKey()
  List<ElectricalNode> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

// Calculation result
  @override
  final CalculationResult? result;
// Real measurements
  @override
  final MeasurementState? lastMeasurement;
// Asset Management
  @override
  @JsonKey()
  final AssetMetadata assetMetadata;

  @override
  String toString() {
    return 'ElectricalNode.panel(id: $id, name: $name, state: $state, nominalVoltage: $nominalVoltage, inputCable: $inputCable, children: $children, result: $result, lastMeasurement: $lastMeasurement, assetMetadata: $assetMetadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PanelNodeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.nominalVoltage, nominalVoltage) ||
                other.nominalVoltage == nominalVoltage) &&
            (identical(other.inputCable, inputCable) ||
                other.inputCable == inputCable) &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.lastMeasurement, lastMeasurement) ||
                other.lastMeasurement == lastMeasurement) &&
            (identical(other.assetMetadata, assetMetadata) ||
                other.assetMetadata == assetMetadata));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      state,
      nominalVoltage,
      inputCable,
      const DeepCollectionEquality().hash(_children),
      result,
      lastMeasurement,
      assetMetadata);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PanelNodeImplCopyWith<_$PanelNodeImpl> get copyWith =>
      __$$PanelNodeImplCopyWithImpl<_$PanelNodeImpl>(this, _$identity);

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
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)
        source,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)
        panel,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)
        protection,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            double powerWatts,
            double cosPhi,
            LoadType type,
            bool isThreePhase,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? cableCatalogData)
        load,
  }) {
    return panel(id, name, state, nominalVoltage, inputCable, children, result,
        lastMeasurement, assetMetadata);
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
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)?
        source,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)?
        panel,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)?
        protection,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            double powerWatts,
            double cosPhi,
            LoadType type,
            bool isThreePhase,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? cableCatalogData)?
        load,
  }) {
    return panel?.call(id, name, state, nominalVoltage, inputCable, children,
        result, lastMeasurement, assetMetadata);
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
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)?
        source,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)?
        panel,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)?
        protection,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            double powerWatts,
            double cosPhi,
            LoadType type,
            bool isThreePhase,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? cableCatalogData)?
        load,
    required TResult orElse(),
  }) {
    if (panel != null) {
      return panel(id, name, state, nominalVoltage, inputCable, children,
          result, lastMeasurement, assetMetadata);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SourceNode value) source,
    required TResult Function(PanelNode value) panel,
    required TResult Function(ProtectionNode value) protection,
    required TResult Function(LoadNode value) load,
  }) {
    return panel(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SourceNode value)? source,
    TResult? Function(PanelNode value)? panel,
    TResult? Function(ProtectionNode value)? protection,
    TResult? Function(LoadNode value)? load,
  }) {
    return panel?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SourceNode value)? source,
    TResult Function(PanelNode value)? panel,
    TResult Function(ProtectionNode value)? protection,
    TResult Function(LoadNode value)? load,
    required TResult orElse(),
  }) {
    if (panel != null) {
      return panel(this);
    }
    return orElse();
  }
}

abstract class PanelNode implements ElectricalNode {
  const factory PanelNode(
      {required final String id,
      required final String name,
      final ElectricalState state,
      final double nominalVoltage,
      final ConductorAttributes? inputCable,
      final List<ElectricalNode> children,
      final CalculationResult? result,
      final MeasurementState? lastMeasurement,
      final AssetMetadata assetMetadata}) = _$PanelNodeImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  ElectricalState get state;
  double get nominalVoltage; // Connection from Parent
  ConductorAttributes? get inputCable;
  List<ElectricalNode> get children;
  @override // Calculation result
  CalculationResult? get result;
  @override // Real measurements
  MeasurementState? get lastMeasurement;
  @override // Asset Management
  AssetMetadata get assetMetadata;
  @override
  @JsonKey(ignore: true)
  _$$PanelNodeImplCopyWith<_$PanelNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProtectionNodeImplCopyWith<$Res>
    implements $ElectricalNodeCopyWith<$Res> {
  factory _$$ProtectionNodeImplCopyWith(_$ProtectionNodeImpl value,
          $Res Function(_$ProtectionNodeImpl) then) =
      __$$ProtectionNodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      ElectricalState state,
      ProtectionType protectionType,
      double ratingAmps,
      double? pdc,
      String curve,
      double sensitivity,
      int poles,
      List<ElectricalNode> children,
      CalculationResult? result,
      MeasurementState? lastMeasurement,
      AssetMetadata assetMetadata,
      CatalogMetadata? catalogData,
      CatalogMetadata? cableCatalogData});

  @override
  $ElectricalStateCopyWith<$Res> get state;
  @override
  $CalculationResultCopyWith<$Res>? get result;
  @override
  $MeasurementStateCopyWith<$Res>? get lastMeasurement;
  $CatalogMetadataCopyWith<$Res>? get catalogData;
  $CatalogMetadataCopyWith<$Res>? get cableCatalogData;
}

/// @nodoc
class __$$ProtectionNodeImplCopyWithImpl<$Res>
    extends _$ElectricalNodeCopyWithImpl<$Res, _$ProtectionNodeImpl>
    implements _$$ProtectionNodeImplCopyWith<$Res> {
  __$$ProtectionNodeImplCopyWithImpl(
      _$ProtectionNodeImpl _value, $Res Function(_$ProtectionNodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? state = null,
    Object? protectionType = null,
    Object? ratingAmps = null,
    Object? pdc = freezed,
    Object? curve = null,
    Object? sensitivity = null,
    Object? poles = null,
    Object? children = null,
    Object? result = freezed,
    Object? lastMeasurement = freezed,
    Object? assetMetadata = null,
    Object? catalogData = freezed,
    Object? cableCatalogData = freezed,
  }) {
    return _then(_$ProtectionNodeImpl(
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
              as List<ElectricalNode>,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as CalculationResult?,
      lastMeasurement: freezed == lastMeasurement
          ? _value.lastMeasurement
          : lastMeasurement // ignore: cast_nullable_to_non_nullable
              as MeasurementState?,
      assetMetadata: null == assetMetadata
          ? _value.assetMetadata
          : assetMetadata // ignore: cast_nullable_to_non_nullable
              as AssetMetadata,
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

class _$ProtectionNodeImpl implements ProtectionNode {
  const _$ProtectionNodeImpl(
      {required this.id,
      required this.name,
      this.state = const ElectricalState(),
      this.protectionType = ProtectionType.circuitBreaker,
      this.ratingAmps = 16,
      this.pdc,
      this.curve = "C",
      this.sensitivity = 30.0,
      this.poles = 2,
      final List<ElectricalNode> children = const [],
      this.result,
      this.lastMeasurement,
      this.assetMetadata = const AssetMetadata(),
      this.catalogData,
      this.cableCatalogData})
      : _children = children;

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final ElectricalState state;
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
  final List<ElectricalNode> _children;
  @override
  @JsonKey()
  List<ElectricalNode> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

// Calculation result
  @override
  final CalculationResult? result;
// Real measurements
  @override
  final MeasurementState? lastMeasurement;
// Asset Management
  @override
  @JsonKey()
  final AssetMetadata assetMetadata;
// Catalog Metadata (Digital Twin)
  @override
  final CatalogMetadata? catalogData;
  @override
  final CatalogMetadata? cableCatalogData;

  @override
  String toString() {
    return 'ElectricalNode.protection(id: $id, name: $name, state: $state, protectionType: $protectionType, ratingAmps: $ratingAmps, pdc: $pdc, curve: $curve, sensitivity: $sensitivity, poles: $poles, children: $children, result: $result, lastMeasurement: $lastMeasurement, assetMetadata: $assetMetadata, catalogData: $catalogData, cableCatalogData: $cableCatalogData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProtectionNodeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.state, state) || other.state == state) &&
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
            (identical(other.result, result) || other.result == result) &&
            (identical(other.lastMeasurement, lastMeasurement) ||
                other.lastMeasurement == lastMeasurement) &&
            (identical(other.assetMetadata, assetMetadata) ||
                other.assetMetadata == assetMetadata) &&
            (identical(other.catalogData, catalogData) ||
                other.catalogData == catalogData) &&
            (identical(other.cableCatalogData, cableCatalogData) ||
                other.cableCatalogData == cableCatalogData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      state,
      protectionType,
      ratingAmps,
      pdc,
      curve,
      sensitivity,
      poles,
      const DeepCollectionEquality().hash(_children),
      result,
      lastMeasurement,
      assetMetadata,
      catalogData,
      cableCatalogData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProtectionNodeImplCopyWith<_$ProtectionNodeImpl> get copyWith =>
      __$$ProtectionNodeImplCopyWithImpl<_$ProtectionNodeImpl>(
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
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)
        source,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)
        panel,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)
        protection,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            double powerWatts,
            double cosPhi,
            LoadType type,
            bool isThreePhase,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? cableCatalogData)
        load,
  }) {
    return protection(
        id,
        name,
        state,
        protectionType,
        ratingAmps,
        pdc,
        curve,
        sensitivity,
        poles,
        children,
        result,
        lastMeasurement,
        assetMetadata,
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
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)?
        source,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)?
        panel,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)?
        protection,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            double powerWatts,
            double cosPhi,
            LoadType type,
            bool isThreePhase,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? cableCatalogData)?
        load,
  }) {
    return protection?.call(
        id,
        name,
        state,
        protectionType,
        ratingAmps,
        pdc,
        curve,
        sensitivity,
        poles,
        children,
        result,
        lastMeasurement,
        assetMetadata,
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
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)?
        source,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)?
        panel,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)?
        protection,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            double powerWatts,
            double cosPhi,
            LoadType type,
            bool isThreePhase,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? cableCatalogData)?
        load,
    required TResult orElse(),
  }) {
    if (protection != null) {
      return protection(
          id,
          name,
          state,
          protectionType,
          ratingAmps,
          pdc,
          curve,
          sensitivity,
          poles,
          children,
          result,
          lastMeasurement,
          assetMetadata,
          catalogData,
          cableCatalogData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SourceNode value) source,
    required TResult Function(PanelNode value) panel,
    required TResult Function(ProtectionNode value) protection,
    required TResult Function(LoadNode value) load,
  }) {
    return protection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SourceNode value)? source,
    TResult? Function(PanelNode value)? panel,
    TResult? Function(ProtectionNode value)? protection,
    TResult? Function(LoadNode value)? load,
  }) {
    return protection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SourceNode value)? source,
    TResult Function(PanelNode value)? panel,
    TResult Function(ProtectionNode value)? protection,
    TResult Function(LoadNode value)? load,
    required TResult orElse(),
  }) {
    if (protection != null) {
      return protection(this);
    }
    return orElse();
  }
}

abstract class ProtectionNode implements ElectricalNode {
  const factory ProtectionNode(
      {required final String id,
      required final String name,
      final ElectricalState state,
      final ProtectionType protectionType,
      final double ratingAmps,
      final double? pdc,
      final String curve,
      final double sensitivity,
      final int poles,
      final List<ElectricalNode> children,
      final CalculationResult? result,
      final MeasurementState? lastMeasurement,
      final AssetMetadata assetMetadata,
      final CatalogMetadata? catalogData,
      final CatalogMetadata? cableCatalogData}) = _$ProtectionNodeImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  ElectricalState get state;
  ProtectionType get protectionType;
  double get ratingAmps;
  double? get pdc;
  String get curve;
  double get sensitivity;
  int get poles;
  List<ElectricalNode> get children;
  @override // Calculation result
  CalculationResult? get result;
  @override // Real measurements
  MeasurementState? get lastMeasurement;
  @override // Asset Management
  AssetMetadata get assetMetadata; // Catalog Metadata (Digital Twin)
  CatalogMetadata? get catalogData;
  CatalogMetadata? get cableCatalogData;
  @override
  @JsonKey(ignore: true)
  _$$ProtectionNodeImplCopyWith<_$ProtectionNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadNodeImplCopyWith<$Res>
    implements $ElectricalNodeCopyWith<$Res> {
  factory _$$LoadNodeImplCopyWith(
          _$LoadNodeImpl value, $Res Function(_$LoadNodeImpl) then) =
      __$$LoadNodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      ElectricalState state,
      ConductorAttributes? inputCable,
      double powerWatts,
      double cosPhi,
      LoadType type,
      bool isThreePhase,
      CalculationResult? result,
      MeasurementState? lastMeasurement,
      AssetMetadata assetMetadata,
      CatalogMetadata? cableCatalogData});

  @override
  $ElectricalStateCopyWith<$Res> get state;
  $ConductorAttributesCopyWith<$Res>? get inputCable;
  @override
  $CalculationResultCopyWith<$Res>? get result;
  @override
  $MeasurementStateCopyWith<$Res>? get lastMeasurement;
  $CatalogMetadataCopyWith<$Res>? get cableCatalogData;
}

/// @nodoc
class __$$LoadNodeImplCopyWithImpl<$Res>
    extends _$ElectricalNodeCopyWithImpl<$Res, _$LoadNodeImpl>
    implements _$$LoadNodeImplCopyWith<$Res> {
  __$$LoadNodeImplCopyWithImpl(
      _$LoadNodeImpl _value, $Res Function(_$LoadNodeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? state = null,
    Object? inputCable = freezed,
    Object? powerWatts = null,
    Object? cosPhi = null,
    Object? type = null,
    Object? isThreePhase = null,
    Object? result = freezed,
    Object? lastMeasurement = freezed,
    Object? assetMetadata = null,
    Object? cableCatalogData = freezed,
  }) {
    return _then(_$LoadNodeImpl(
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
      powerWatts: null == powerWatts
          ? _value.powerWatts
          : powerWatts // ignore: cast_nullable_to_non_nullable
              as double,
      cosPhi: null == cosPhi
          ? _value.cosPhi
          : cosPhi // ignore: cast_nullable_to_non_nullable
              as double,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LoadType,
      isThreePhase: null == isThreePhase
          ? _value.isThreePhase
          : isThreePhase // ignore: cast_nullable_to_non_nullable
              as bool,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as CalculationResult?,
      lastMeasurement: freezed == lastMeasurement
          ? _value.lastMeasurement
          : lastMeasurement // ignore: cast_nullable_to_non_nullable
              as MeasurementState?,
      assetMetadata: null == assetMetadata
          ? _value.assetMetadata
          : assetMetadata // ignore: cast_nullable_to_non_nullable
              as AssetMetadata,
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

class _$LoadNodeImpl implements LoadNode {
  const _$LoadNodeImpl(
      {required this.id,
      required this.name,
      this.state = const ElectricalState(),
      this.inputCable,
      this.powerWatts = 3000,
      this.cosPhi = 0.9,
      this.type = LoadType.power,
      this.isThreePhase = false,
      this.result,
      this.lastMeasurement,
      this.assetMetadata = const AssetMetadata(),
      this.cableCatalogData});

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
  @JsonKey()
  final double powerWatts;
  @override
  @JsonKey()
  final double cosPhi;
  @override
  @JsonKey()
  final LoadType type;
  @override
  @JsonKey()
  final bool isThreePhase;
// Calculation result
  @override
  final CalculationResult? result;
// Real measurements
  @override
  final MeasurementState? lastMeasurement;
// Asset Management
  @override
  @JsonKey()
  final AssetMetadata assetMetadata;
// Catalog Metadata for load's input cable
  @override
  final CatalogMetadata? cableCatalogData;

  @override
  String toString() {
    return 'ElectricalNode.load(id: $id, name: $name, state: $state, inputCable: $inputCable, powerWatts: $powerWatts, cosPhi: $cosPhi, type: $type, isThreePhase: $isThreePhase, result: $result, lastMeasurement: $lastMeasurement, assetMetadata: $assetMetadata, cableCatalogData: $cableCatalogData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadNodeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.inputCable, inputCable) ||
                other.inputCable == inputCable) &&
            (identical(other.powerWatts, powerWatts) ||
                other.powerWatts == powerWatts) &&
            (identical(other.cosPhi, cosPhi) || other.cosPhi == cosPhi) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isThreePhase, isThreePhase) ||
                other.isThreePhase == isThreePhase) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.lastMeasurement, lastMeasurement) ||
                other.lastMeasurement == lastMeasurement) &&
            (identical(other.assetMetadata, assetMetadata) ||
                other.assetMetadata == assetMetadata) &&
            (identical(other.cableCatalogData, cableCatalogData) ||
                other.cableCatalogData == cableCatalogData));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      state,
      inputCable,
      powerWatts,
      cosPhi,
      type,
      isThreePhase,
      result,
      lastMeasurement,
      assetMetadata,
      cableCatalogData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadNodeImplCopyWith<_$LoadNodeImpl> get copyWith =>
      __$$LoadNodeImplCopyWithImpl<_$LoadNodeImpl>(this, _$identity);

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
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)
        source,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)
        panel,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)
        protection,
    required TResult Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            double powerWatts,
            double cosPhi,
            LoadType type,
            bool isThreePhase,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? cableCatalogData)
        load,
  }) {
    return load(id, name, state, inputCable, powerWatts, cosPhi, type,
        isThreePhase, result, lastMeasurement, assetMetadata, cableCatalogData);
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
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)?
        source,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)?
        panel,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)?
        protection,
    TResult? Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            double powerWatts,
            double cosPhi,
            LoadType type,
            bool isThreePhase,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? cableCatalogData)?
        load,
  }) {
    return load?.call(id, name, state, inputCable, powerWatts, cosPhi, type,
        isThreePhase, result, lastMeasurement, assetMetadata, cableCatalogData);
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
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)?
        source,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            double nominalVoltage,
            ConductorAttributes? inputCable,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata)?
        panel,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            ProtectionType protectionType,
            double ratingAmps,
            double? pdc,
            String curve,
            double sensitivity,
            int poles,
            List<ElectricalNode> children,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? catalogData,
            CatalogMetadata? cableCatalogData)?
        protection,
    TResult Function(
            String id,
            String name,
            ElectricalState state,
            ConductorAttributes? inputCable,
            double powerWatts,
            double cosPhi,
            LoadType type,
            bool isThreePhase,
            CalculationResult? result,
            MeasurementState? lastMeasurement,
            AssetMetadata assetMetadata,
            CatalogMetadata? cableCatalogData)?
        load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(
          id,
          name,
          state,
          inputCable,
          powerWatts,
          cosPhi,
          type,
          isThreePhase,
          result,
          lastMeasurement,
          assetMetadata,
          cableCatalogData);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SourceNode value) source,
    required TResult Function(PanelNode value) panel,
    required TResult Function(ProtectionNode value) protection,
    required TResult Function(LoadNode value) load,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SourceNode value)? source,
    TResult? Function(PanelNode value)? panel,
    TResult? Function(ProtectionNode value)? protection,
    TResult? Function(LoadNode value)? load,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SourceNode value)? source,
    TResult Function(PanelNode value)? panel,
    TResult Function(ProtectionNode value)? protection,
    TResult Function(LoadNode value)? load,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class LoadNode implements ElectricalNode {
  const factory LoadNode(
      {required final String id,
      required final String name,
      final ElectricalState state,
      final ConductorAttributes? inputCable,
      final double powerWatts,
      final double cosPhi,
      final LoadType type,
      final bool isThreePhase,
      final CalculationResult? result,
      final MeasurementState? lastMeasurement,
      final AssetMetadata assetMetadata,
      final CatalogMetadata? cableCatalogData}) = _$LoadNodeImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  ElectricalState get state;
  ConductorAttributes? get inputCable;
  double get powerWatts;
  double get cosPhi;
  LoadType get type;
  bool get isThreePhase;
  @override // Calculation result
  CalculationResult? get result;
  @override // Real measurements
  MeasurementState? get lastMeasurement;
  @override // Asset Management
  AssetMetadata get assetMetadata; // Catalog Metadata for load's input cable
  CatalogMetadata? get cableCatalogData;
  @override
  @JsonKey(ignore: true)
  _$$LoadNodeImplCopyWith<_$LoadNodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
