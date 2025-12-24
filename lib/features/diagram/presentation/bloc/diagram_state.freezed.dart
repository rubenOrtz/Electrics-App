// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagram_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DiagramState {
// Root of the Single Tree (e.g. Acometida or Main Panel)
  ElectricalNode? get root => throw _privateConstructorUsedError;
  DiagramStatus get status => throw _privateConstructorUsedError;
  List<CalculationError> get validationErrors =>
      throw _privateConstructorUsedError;
  String? get errorMessage =>
      throw _privateConstructorUsedError; // Visual Position Map (ID -> Offset)
// Kept separate from Entity for pure layout logic
// Visual Position Map (ID -> Offset)
// Kept separate from Entity for pure layout logic
  Map<String, Offset> get nodePositions =>
      throw _privateConstructorUsedError; // Undo/Redo State
  bool get canUndo => throw _privateConstructorUsedError;
  bool get canRedo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DiagramStateCopyWith<DiagramState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiagramStateCopyWith<$Res> {
  factory $DiagramStateCopyWith(
          DiagramState value, $Res Function(DiagramState) then) =
      _$DiagramStateCopyWithImpl<$Res, DiagramState>;
  @useResult
  $Res call(
      {ElectricalNode? root,
      DiagramStatus status,
      List<CalculationError> validationErrors,
      String? errorMessage,
      Map<String, Offset> nodePositions,
      bool canUndo,
      bool canRedo});

  $ElectricalNodeCopyWith<$Res>? get root;
}

/// @nodoc
class _$DiagramStateCopyWithImpl<$Res, $Val extends DiagramState>
    implements $DiagramStateCopyWith<$Res> {
  _$DiagramStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? root = freezed,
    Object? status = null,
    Object? validationErrors = null,
    Object? errorMessage = freezed,
    Object? nodePositions = null,
    Object? canUndo = null,
    Object? canRedo = null,
  }) {
    return _then(_value.copyWith(
      root: freezed == root
          ? _value.root
          : root // ignore: cast_nullable_to_non_nullable
              as ElectricalNode?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DiagramStatus,
      validationErrors: null == validationErrors
          ? _value.validationErrors
          : validationErrors // ignore: cast_nullable_to_non_nullable
              as List<CalculationError>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      nodePositions: null == nodePositions
          ? _value.nodePositions
          : nodePositions // ignore: cast_nullable_to_non_nullable
              as Map<String, Offset>,
      canUndo: null == canUndo
          ? _value.canUndo
          : canUndo // ignore: cast_nullable_to_non_nullable
              as bool,
      canRedo: null == canRedo
          ? _value.canRedo
          : canRedo // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ElectricalNodeCopyWith<$Res>? get root {
    if (_value.root == null) {
      return null;
    }

    return $ElectricalNodeCopyWith<$Res>(_value.root!, (value) {
      return _then(_value.copyWith(root: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DiagramStateImplCopyWith<$Res>
    implements $DiagramStateCopyWith<$Res> {
  factory _$$DiagramStateImplCopyWith(
          _$DiagramStateImpl value, $Res Function(_$DiagramStateImpl) then) =
      __$$DiagramStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ElectricalNode? root,
      DiagramStatus status,
      List<CalculationError> validationErrors,
      String? errorMessage,
      Map<String, Offset> nodePositions,
      bool canUndo,
      bool canRedo});

  @override
  $ElectricalNodeCopyWith<$Res>? get root;
}

/// @nodoc
class __$$DiagramStateImplCopyWithImpl<$Res>
    extends _$DiagramStateCopyWithImpl<$Res, _$DiagramStateImpl>
    implements _$$DiagramStateImplCopyWith<$Res> {
  __$$DiagramStateImplCopyWithImpl(
      _$DiagramStateImpl _value, $Res Function(_$DiagramStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? root = freezed,
    Object? status = null,
    Object? validationErrors = null,
    Object? errorMessage = freezed,
    Object? nodePositions = null,
    Object? canUndo = null,
    Object? canRedo = null,
  }) {
    return _then(_$DiagramStateImpl(
      root: freezed == root
          ? _value.root
          : root // ignore: cast_nullable_to_non_nullable
              as ElectricalNode?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as DiagramStatus,
      validationErrors: null == validationErrors
          ? _value._validationErrors
          : validationErrors // ignore: cast_nullable_to_non_nullable
              as List<CalculationError>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      nodePositions: null == nodePositions
          ? _value._nodePositions
          : nodePositions // ignore: cast_nullable_to_non_nullable
              as Map<String, Offset>,
      canUndo: null == canUndo
          ? _value.canUndo
          : canUndo // ignore: cast_nullable_to_non_nullable
              as bool,
      canRedo: null == canRedo
          ? _value.canRedo
          : canRedo // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$DiagramStateImpl implements _DiagramState {
  const _$DiagramStateImpl(
      {this.root,
      this.status = DiagramStatus.initial,
      final List<CalculationError> validationErrors = const [],
      this.errorMessage,
      final Map<String, Offset> nodePositions = const {},
      this.canUndo = false,
      this.canRedo = false})
      : _validationErrors = validationErrors,
        _nodePositions = nodePositions;

// Root of the Single Tree (e.g. Acometida or Main Panel)
  @override
  final ElectricalNode? root;
  @override
  @JsonKey()
  final DiagramStatus status;
  final List<CalculationError> _validationErrors;
  @override
  @JsonKey()
  List<CalculationError> get validationErrors {
    if (_validationErrors is EqualUnmodifiableListView)
      return _validationErrors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_validationErrors);
  }

  @override
  final String? errorMessage;
// Visual Position Map (ID -> Offset)
// Kept separate from Entity for pure layout logic
// Visual Position Map (ID -> Offset)
// Kept separate from Entity for pure layout logic
  final Map<String, Offset> _nodePositions;
// Visual Position Map (ID -> Offset)
// Kept separate from Entity for pure layout logic
// Visual Position Map (ID -> Offset)
// Kept separate from Entity for pure layout logic
  @override
  @JsonKey()
  Map<String, Offset> get nodePositions {
    if (_nodePositions is EqualUnmodifiableMapView) return _nodePositions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_nodePositions);
  }

// Undo/Redo State
  @override
  @JsonKey()
  final bool canUndo;
  @override
  @JsonKey()
  final bool canRedo;

  @override
  String toString() {
    return 'DiagramState(root: $root, status: $status, validationErrors: $validationErrors, errorMessage: $errorMessage, nodePositions: $nodePositions, canUndo: $canUndo, canRedo: $canRedo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiagramStateImpl &&
            (identical(other.root, root) || other.root == root) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._validationErrors, _validationErrors) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality()
                .equals(other._nodePositions, _nodePositions) &&
            (identical(other.canUndo, canUndo) || other.canUndo == canUndo) &&
            (identical(other.canRedo, canRedo) || other.canRedo == canRedo));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      root,
      status,
      const DeepCollectionEquality().hash(_validationErrors),
      errorMessage,
      const DeepCollectionEquality().hash(_nodePositions),
      canUndo,
      canRedo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiagramStateImplCopyWith<_$DiagramStateImpl> get copyWith =>
      __$$DiagramStateImplCopyWithImpl<_$DiagramStateImpl>(this, _$identity);
}

abstract class _DiagramState implements DiagramState {
  const factory _DiagramState(
      {final ElectricalNode? root,
      final DiagramStatus status,
      final List<CalculationError> validationErrors,
      final String? errorMessage,
      final Map<String, Offset> nodePositions,
      final bool canUndo,
      final bool canRedo}) = _$DiagramStateImpl;

  @override // Root of the Single Tree (e.g. Acometida or Main Panel)
  ElectricalNode? get root;
  @override
  DiagramStatus get status;
  @override
  List<CalculationError> get validationErrors;
  @override
  String? get errorMessage;
  @override // Visual Position Map (ID -> Offset)
// Kept separate from Entity for pure layout logic
// Visual Position Map (ID -> Offset)
// Kept separate from Entity for pure layout logic
  Map<String, Offset> get nodePositions;
  @override // Undo/Redo State
  bool get canUndo;
  @override
  bool get canRedo;
  @override
  @JsonKey(ignore: true)
  _$$DiagramStateImplCopyWith<_$DiagramStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
