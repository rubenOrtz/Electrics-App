// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'measurement_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MeasurementState _$MeasurementStateFromJson(Map<String, dynamic> json) {
  return _MeasurementState.fromJson(json);
}

/// @nodoc
mixin _$MeasurementState {
  DateTime get timestamp =>
      throw _privateConstructorUsedError; // Medidas Eléctricas Básicas
  double? get voltageLN =>
      throw _privateConstructorUsedError; // Tensión Fase-Neutro (V)
  double? get current => throw _privateConstructorUsedError; // Intensidad (A)
// Medidas de Seguridad/Impedancia
  double? get loopImpedance =>
      throw _privateConstructorUsedError; // Zs Impedancia de Bucle (Ω)
  double? get insulationResistance =>
      throw _privateConstructorUsedError; // R_iso Resistencia de Aislamiento (MΩ)
  double? get rcdTripTime =>
      throw _privateConstructorUsedError; // Tiempo de disparo diferencial (ms)
  double? get earthResistance =>
      throw _privateConstructorUsedError; // Resistencia de Tierra (Ω)
// Medidas Físicas
  double? get temperature => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MeasurementStateCopyWith<MeasurementState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeasurementStateCopyWith<$Res> {
  factory $MeasurementStateCopyWith(
          MeasurementState value, $Res Function(MeasurementState) then) =
      _$MeasurementStateCopyWithImpl<$Res, MeasurementState>;
  @useResult
  $Res call(
      {DateTime timestamp,
      double? voltageLN,
      double? current,
      double? loopImpedance,
      double? insulationResistance,
      double? rcdTripTime,
      double? earthResistance,
      double? temperature});
}

/// @nodoc
class _$MeasurementStateCopyWithImpl<$Res, $Val extends MeasurementState>
    implements $MeasurementStateCopyWith<$Res> {
  _$MeasurementStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? voltageLN = freezed,
    Object? current = freezed,
    Object? loopImpedance = freezed,
    Object? insulationResistance = freezed,
    Object? rcdTripTime = freezed,
    Object? earthResistance = freezed,
    Object? temperature = freezed,
  }) {
    return _then(_value.copyWith(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      voltageLN: freezed == voltageLN
          ? _value.voltageLN
          : voltageLN // ignore: cast_nullable_to_non_nullable
              as double?,
      current: freezed == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as double?,
      loopImpedance: freezed == loopImpedance
          ? _value.loopImpedance
          : loopImpedance // ignore: cast_nullable_to_non_nullable
              as double?,
      insulationResistance: freezed == insulationResistance
          ? _value.insulationResistance
          : insulationResistance // ignore: cast_nullable_to_non_nullable
              as double?,
      rcdTripTime: freezed == rcdTripTime
          ? _value.rcdTripTime
          : rcdTripTime // ignore: cast_nullable_to_non_nullable
              as double?,
      earthResistance: freezed == earthResistance
          ? _value.earthResistance
          : earthResistance // ignore: cast_nullable_to_non_nullable
              as double?,
      temperature: freezed == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MeasurementStateImplCopyWith<$Res>
    implements $MeasurementStateCopyWith<$Res> {
  factory _$$MeasurementStateImplCopyWith(_$MeasurementStateImpl value,
          $Res Function(_$MeasurementStateImpl) then) =
      __$$MeasurementStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime timestamp,
      double? voltageLN,
      double? current,
      double? loopImpedance,
      double? insulationResistance,
      double? rcdTripTime,
      double? earthResistance,
      double? temperature});
}

/// @nodoc
class __$$MeasurementStateImplCopyWithImpl<$Res>
    extends _$MeasurementStateCopyWithImpl<$Res, _$MeasurementStateImpl>
    implements _$$MeasurementStateImplCopyWith<$Res> {
  __$$MeasurementStateImplCopyWithImpl(_$MeasurementStateImpl _value,
      $Res Function(_$MeasurementStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestamp = null,
    Object? voltageLN = freezed,
    Object? current = freezed,
    Object? loopImpedance = freezed,
    Object? insulationResistance = freezed,
    Object? rcdTripTime = freezed,
    Object? earthResistance = freezed,
    Object? temperature = freezed,
  }) {
    return _then(_$MeasurementStateImpl(
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      voltageLN: freezed == voltageLN
          ? _value.voltageLN
          : voltageLN // ignore: cast_nullable_to_non_nullable
              as double?,
      current: freezed == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as double?,
      loopImpedance: freezed == loopImpedance
          ? _value.loopImpedance
          : loopImpedance // ignore: cast_nullable_to_non_nullable
              as double?,
      insulationResistance: freezed == insulationResistance
          ? _value.insulationResistance
          : insulationResistance // ignore: cast_nullable_to_non_nullable
              as double?,
      rcdTripTime: freezed == rcdTripTime
          ? _value.rcdTripTime
          : rcdTripTime // ignore: cast_nullable_to_non_nullable
              as double?,
      earthResistance: freezed == earthResistance
          ? _value.earthResistance
          : earthResistance // ignore: cast_nullable_to_non_nullable
              as double?,
      temperature: freezed == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MeasurementStateImpl implements _MeasurementState {
  const _$MeasurementStateImpl(
      {required this.timestamp,
      this.voltageLN,
      this.current,
      this.loopImpedance,
      this.insulationResistance,
      this.rcdTripTime,
      this.earthResistance,
      this.temperature});

  factory _$MeasurementStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeasurementStateImplFromJson(json);

  @override
  final DateTime timestamp;
// Medidas Eléctricas Básicas
  @override
  final double? voltageLN;
// Tensión Fase-Neutro (V)
  @override
  final double? current;
// Intensidad (A)
// Medidas de Seguridad/Impedancia
  @override
  final double? loopImpedance;
// Zs Impedancia de Bucle (Ω)
  @override
  final double? insulationResistance;
// R_iso Resistencia de Aislamiento (MΩ)
  @override
  final double? rcdTripTime;
// Tiempo de disparo diferencial (ms)
  @override
  final double? earthResistance;
// Resistencia de Tierra (Ω)
// Medidas Físicas
  @override
  final double? temperature;

  @override
  String toString() {
    return 'MeasurementState(timestamp: $timestamp, voltageLN: $voltageLN, current: $current, loopImpedance: $loopImpedance, insulationResistance: $insulationResistance, rcdTripTime: $rcdTripTime, earthResistance: $earthResistance, temperature: $temperature)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeasurementStateImpl &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.voltageLN, voltageLN) ||
                other.voltageLN == voltageLN) &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.loopImpedance, loopImpedance) ||
                other.loopImpedance == loopImpedance) &&
            (identical(other.insulationResistance, insulationResistance) ||
                other.insulationResistance == insulationResistance) &&
            (identical(other.rcdTripTime, rcdTripTime) ||
                other.rcdTripTime == rcdTripTime) &&
            (identical(other.earthResistance, earthResistance) ||
                other.earthResistance == earthResistance) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      timestamp,
      voltageLN,
      current,
      loopImpedance,
      insulationResistance,
      rcdTripTime,
      earthResistance,
      temperature);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MeasurementStateImplCopyWith<_$MeasurementStateImpl> get copyWith =>
      __$$MeasurementStateImplCopyWithImpl<_$MeasurementStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeasurementStateImplToJson(
      this,
    );
  }
}

abstract class _MeasurementState implements MeasurementState {
  const factory _MeasurementState(
      {required final DateTime timestamp,
      final double? voltageLN,
      final double? current,
      final double? loopImpedance,
      final double? insulationResistance,
      final double? rcdTripTime,
      final double? earthResistance,
      final double? temperature}) = _$MeasurementStateImpl;

  factory _MeasurementState.fromJson(Map<String, dynamic> json) =
      _$MeasurementStateImpl.fromJson;

  @override
  DateTime get timestamp;
  @override // Medidas Eléctricas Básicas
  double? get voltageLN;
  @override // Tensión Fase-Neutro (V)
  double? get current;
  @override // Intensidad (A)
// Medidas de Seguridad/Impedancia
  double? get loopImpedance;
  @override // Zs Impedancia de Bucle (Ω)
  double? get insulationResistance;
  @override // R_iso Resistencia de Aislamiento (MΩ)
  double? get rcdTripTime;
  @override // Tiempo de disparo diferencial (ms)
  double? get earthResistance;
  @override // Resistencia de Tierra (Ω)
// Medidas Físicas
  double? get temperature;
  @override
  @JsonKey(ignore: true)
  _$$MeasurementStateImplCopyWith<_$MeasurementStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
