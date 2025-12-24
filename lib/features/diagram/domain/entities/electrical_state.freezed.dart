// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'electrical_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ElectricalState _$ElectricalStateFromJson(Map<String, dynamic> json) {
  return _ElectricalState.fromJson(json);
}

/// @nodoc
mixin _$ElectricalState {
  /// Voltage drop in percentage relative to the source voltage.
  double get voltageDropPercent => throw _privateConstructorUsedError;

  /// Short circuit current at this point in Amperes (kA typically, but storing as double for precision).
  double get shortCircuitCurrentAmps => throw _privateConstructorUsedError;

  /// Active power flowing through this node in Watts (W).
  double get activePowerWatts => throw _privateConstructorUsedError;

  /// Reactive power flowing through this node in VARs.
  double get reactivePowerVars => throw _privateConstructorUsedError;

  /// Current flowing through this node in Amperes (A).
  double get currentAmps => throw _privateConstructorUsedError;

  /// Voltage level at this node in Volts (V).
  double get voltageVolts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ElectricalStateCopyWith<ElectricalState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ElectricalStateCopyWith<$Res> {
  factory $ElectricalStateCopyWith(
          ElectricalState value, $Res Function(ElectricalState) then) =
      _$ElectricalStateCopyWithImpl<$Res, ElectricalState>;
  @useResult
  $Res call(
      {double voltageDropPercent,
      double shortCircuitCurrentAmps,
      double activePowerWatts,
      double reactivePowerVars,
      double currentAmps,
      double voltageVolts});
}

/// @nodoc
class _$ElectricalStateCopyWithImpl<$Res, $Val extends ElectricalState>
    implements $ElectricalStateCopyWith<$Res> {
  _$ElectricalStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? voltageDropPercent = null,
    Object? shortCircuitCurrentAmps = null,
    Object? activePowerWatts = null,
    Object? reactivePowerVars = null,
    Object? currentAmps = null,
    Object? voltageVolts = null,
  }) {
    return _then(_value.copyWith(
      voltageDropPercent: null == voltageDropPercent
          ? _value.voltageDropPercent
          : voltageDropPercent // ignore: cast_nullable_to_non_nullable
              as double,
      shortCircuitCurrentAmps: null == shortCircuitCurrentAmps
          ? _value.shortCircuitCurrentAmps
          : shortCircuitCurrentAmps // ignore: cast_nullable_to_non_nullable
              as double,
      activePowerWatts: null == activePowerWatts
          ? _value.activePowerWatts
          : activePowerWatts // ignore: cast_nullable_to_non_nullable
              as double,
      reactivePowerVars: null == reactivePowerVars
          ? _value.reactivePowerVars
          : reactivePowerVars // ignore: cast_nullable_to_non_nullable
              as double,
      currentAmps: null == currentAmps
          ? _value.currentAmps
          : currentAmps // ignore: cast_nullable_to_non_nullable
              as double,
      voltageVolts: null == voltageVolts
          ? _value.voltageVolts
          : voltageVolts // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ElectricalStateImplCopyWith<$Res>
    implements $ElectricalStateCopyWith<$Res> {
  factory _$$ElectricalStateImplCopyWith(_$ElectricalStateImpl value,
          $Res Function(_$ElectricalStateImpl) then) =
      __$$ElectricalStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double voltageDropPercent,
      double shortCircuitCurrentAmps,
      double activePowerWatts,
      double reactivePowerVars,
      double currentAmps,
      double voltageVolts});
}

/// @nodoc
class __$$ElectricalStateImplCopyWithImpl<$Res>
    extends _$ElectricalStateCopyWithImpl<$Res, _$ElectricalStateImpl>
    implements _$$ElectricalStateImplCopyWith<$Res> {
  __$$ElectricalStateImplCopyWithImpl(
      _$ElectricalStateImpl _value, $Res Function(_$ElectricalStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? voltageDropPercent = null,
    Object? shortCircuitCurrentAmps = null,
    Object? activePowerWatts = null,
    Object? reactivePowerVars = null,
    Object? currentAmps = null,
    Object? voltageVolts = null,
  }) {
    return _then(_$ElectricalStateImpl(
      voltageDropPercent: null == voltageDropPercent
          ? _value.voltageDropPercent
          : voltageDropPercent // ignore: cast_nullable_to_non_nullable
              as double,
      shortCircuitCurrentAmps: null == shortCircuitCurrentAmps
          ? _value.shortCircuitCurrentAmps
          : shortCircuitCurrentAmps // ignore: cast_nullable_to_non_nullable
              as double,
      activePowerWatts: null == activePowerWatts
          ? _value.activePowerWatts
          : activePowerWatts // ignore: cast_nullable_to_non_nullable
              as double,
      reactivePowerVars: null == reactivePowerVars
          ? _value.reactivePowerVars
          : reactivePowerVars // ignore: cast_nullable_to_non_nullable
              as double,
      currentAmps: null == currentAmps
          ? _value.currentAmps
          : currentAmps // ignore: cast_nullable_to_non_nullable
              as double,
      voltageVolts: null == voltageVolts
          ? _value.voltageVolts
          : voltageVolts // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ElectricalStateImpl implements _ElectricalState {
  const _$ElectricalStateImpl(
      {this.voltageDropPercent = 0.0,
      this.shortCircuitCurrentAmps = 0.0,
      this.activePowerWatts = 0.0,
      this.reactivePowerVars = 0.0,
      this.currentAmps = 0.0,
      this.voltageVolts = 0.0});

  factory _$ElectricalStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ElectricalStateImplFromJson(json);

  /// Voltage drop in percentage relative to the source voltage.
  @override
  @JsonKey()
  final double voltageDropPercent;

  /// Short circuit current at this point in Amperes (kA typically, but storing as double for precision).
  @override
  @JsonKey()
  final double shortCircuitCurrentAmps;

  /// Active power flowing through this node in Watts (W).
  @override
  @JsonKey()
  final double activePowerWatts;

  /// Reactive power flowing through this node in VARs.
  @override
  @JsonKey()
  final double reactivePowerVars;

  /// Current flowing through this node in Amperes (A).
  @override
  @JsonKey()
  final double currentAmps;

  /// Voltage level at this node in Volts (V).
  @override
  @JsonKey()
  final double voltageVolts;

  @override
  String toString() {
    return 'ElectricalState(voltageDropPercent: $voltageDropPercent, shortCircuitCurrentAmps: $shortCircuitCurrentAmps, activePowerWatts: $activePowerWatts, reactivePowerVars: $reactivePowerVars, currentAmps: $currentAmps, voltageVolts: $voltageVolts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ElectricalStateImpl &&
            (identical(other.voltageDropPercent, voltageDropPercent) ||
                other.voltageDropPercent == voltageDropPercent) &&
            (identical(
                    other.shortCircuitCurrentAmps, shortCircuitCurrentAmps) ||
                other.shortCircuitCurrentAmps == shortCircuitCurrentAmps) &&
            (identical(other.activePowerWatts, activePowerWatts) ||
                other.activePowerWatts == activePowerWatts) &&
            (identical(other.reactivePowerVars, reactivePowerVars) ||
                other.reactivePowerVars == reactivePowerVars) &&
            (identical(other.currentAmps, currentAmps) ||
                other.currentAmps == currentAmps) &&
            (identical(other.voltageVolts, voltageVolts) ||
                other.voltageVolts == voltageVolts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      voltageDropPercent,
      shortCircuitCurrentAmps,
      activePowerWatts,
      reactivePowerVars,
      currentAmps,
      voltageVolts);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ElectricalStateImplCopyWith<_$ElectricalStateImpl> get copyWith =>
      __$$ElectricalStateImplCopyWithImpl<_$ElectricalStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ElectricalStateImplToJson(
      this,
    );
  }
}

abstract class _ElectricalState implements ElectricalState {
  const factory _ElectricalState(
      {final double voltageDropPercent,
      final double shortCircuitCurrentAmps,
      final double activePowerWatts,
      final double reactivePowerVars,
      final double currentAmps,
      final double voltageVolts}) = _$ElectricalStateImpl;

  factory _ElectricalState.fromJson(Map<String, dynamic> json) =
      _$ElectricalStateImpl.fromJson;

  @override

  /// Voltage drop in percentage relative to the source voltage.
  double get voltageDropPercent;
  @override

  /// Short circuit current at this point in Amperes (kA typically, but storing as double for precision).
  double get shortCircuitCurrentAmps;
  @override

  /// Active power flowing through this node in Watts (W).
  double get activePowerWatts;
  @override

  /// Reactive power flowing through this node in VARs.
  double get reactivePowerVars;
  @override

  /// Current flowing through this node in Amperes (A).
  double get currentAmps;
  @override

  /// Voltage level at this node in Volts (V).
  double get voltageVolts;
  @override
  @JsonKey(ignore: true)
  _$$ElectricalStateImplCopyWith<_$ElectricalStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
