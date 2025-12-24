// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calculation_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CalculationResult {
// === PASADA 1: Bottom-Up (Suma de Cargas) ===
  /// Intensidad de diseño (Ib) en Amperios
  double get designCurrent => throw _privateConstructorUsedError;

  /// Intensidad admisible (Iz) del cable en Amperios
  double get admissibleCurrent => throw _privateConstructorUsedError;

  /// Potencia activa (P) en Watts
  double get activePower => throw _privateConstructorUsedError;

  /// Potencia reactiva (Q) en VAR
  double get reactivePower => throw _privateConstructorUsedError;

  /// Potencia aparente (S) en VA
  double get apparentPower => throw _privateConstructorUsedError;

  /// Factor de potencia (cos φ)
  double get powerFactor =>
      throw _privateConstructorUsedError; // === PASADA 2: Top-Down (Caída de Tensión) ===
  /// Tensión real en este nodo (V)
  double get voltageAtNode => throw _privateConstructorUsedError;

  /// Caída de tensión acumulada (%)
  double get voltageDrop => throw _privateConstructorUsedError;

  /// Caída de tensión acumulada (V)
  double get voltageDropVolts => throw _privateConstructorUsedError;

  /// Corriente de cortocircuito máxima (kA)
  double get maxShortCircuitCurrent => throw _privateConstructorUsedError;

  /// Corriente de cortocircuito mínima (kA)
  double get minShortCircuitCurrent => throw _privateConstructorUsedError;

  /// Impedancia del bucle (Ω)
  double get loopImpedance =>
      throw _privateConstructorUsedError; // === VALIDACIÓN ===
  /// Estado de validación del nodo
  ValidationStatus get status => throw _privateConstructorUsedError;

  /// Lista de errores críticos
  List<ValidationError> get errors => throw _privateConstructorUsedError;

  /// Lista de advertencias
  List<ValidationWarning> get warnings => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CalculationResultCopyWith<CalculationResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalculationResultCopyWith<$Res> {
  factory $CalculationResultCopyWith(
          CalculationResult value, $Res Function(CalculationResult) then) =
      _$CalculationResultCopyWithImpl<$Res, CalculationResult>;
  @useResult
  $Res call(
      {double designCurrent,
      double admissibleCurrent,
      double activePower,
      double reactivePower,
      double apparentPower,
      double powerFactor,
      double voltageAtNode,
      double voltageDrop,
      double voltageDropVolts,
      double maxShortCircuitCurrent,
      double minShortCircuitCurrent,
      double loopImpedance,
      ValidationStatus status,
      List<ValidationError> errors,
      List<ValidationWarning> warnings});
}

/// @nodoc
class _$CalculationResultCopyWithImpl<$Res, $Val extends CalculationResult>
    implements $CalculationResultCopyWith<$Res> {
  _$CalculationResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? designCurrent = null,
    Object? admissibleCurrent = null,
    Object? activePower = null,
    Object? reactivePower = null,
    Object? apparentPower = null,
    Object? powerFactor = null,
    Object? voltageAtNode = null,
    Object? voltageDrop = null,
    Object? voltageDropVolts = null,
    Object? maxShortCircuitCurrent = null,
    Object? minShortCircuitCurrent = null,
    Object? loopImpedance = null,
    Object? status = null,
    Object? errors = null,
    Object? warnings = null,
  }) {
    return _then(_value.copyWith(
      designCurrent: null == designCurrent
          ? _value.designCurrent
          : designCurrent // ignore: cast_nullable_to_non_nullable
              as double,
      admissibleCurrent: null == admissibleCurrent
          ? _value.admissibleCurrent
          : admissibleCurrent // ignore: cast_nullable_to_non_nullable
              as double,
      activePower: null == activePower
          ? _value.activePower
          : activePower // ignore: cast_nullable_to_non_nullable
              as double,
      reactivePower: null == reactivePower
          ? _value.reactivePower
          : reactivePower // ignore: cast_nullable_to_non_nullable
              as double,
      apparentPower: null == apparentPower
          ? _value.apparentPower
          : apparentPower // ignore: cast_nullable_to_non_nullable
              as double,
      powerFactor: null == powerFactor
          ? _value.powerFactor
          : powerFactor // ignore: cast_nullable_to_non_nullable
              as double,
      voltageAtNode: null == voltageAtNode
          ? _value.voltageAtNode
          : voltageAtNode // ignore: cast_nullable_to_non_nullable
              as double,
      voltageDrop: null == voltageDrop
          ? _value.voltageDrop
          : voltageDrop // ignore: cast_nullable_to_non_nullable
              as double,
      voltageDropVolts: null == voltageDropVolts
          ? _value.voltageDropVolts
          : voltageDropVolts // ignore: cast_nullable_to_non_nullable
              as double,
      maxShortCircuitCurrent: null == maxShortCircuitCurrent
          ? _value.maxShortCircuitCurrent
          : maxShortCircuitCurrent // ignore: cast_nullable_to_non_nullable
              as double,
      minShortCircuitCurrent: null == minShortCircuitCurrent
          ? _value.minShortCircuitCurrent
          : minShortCircuitCurrent // ignore: cast_nullable_to_non_nullable
              as double,
      loopImpedance: null == loopImpedance
          ? _value.loopImpedance
          : loopImpedance // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ValidationStatus,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<ValidationError>,
      warnings: null == warnings
          ? _value.warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<ValidationWarning>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalculationResultImplCopyWith<$Res>
    implements $CalculationResultCopyWith<$Res> {
  factory _$$CalculationResultImplCopyWith(_$CalculationResultImpl value,
          $Res Function(_$CalculationResultImpl) then) =
      __$$CalculationResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double designCurrent,
      double admissibleCurrent,
      double activePower,
      double reactivePower,
      double apparentPower,
      double powerFactor,
      double voltageAtNode,
      double voltageDrop,
      double voltageDropVolts,
      double maxShortCircuitCurrent,
      double minShortCircuitCurrent,
      double loopImpedance,
      ValidationStatus status,
      List<ValidationError> errors,
      List<ValidationWarning> warnings});
}

/// @nodoc
class __$$CalculationResultImplCopyWithImpl<$Res>
    extends _$CalculationResultCopyWithImpl<$Res, _$CalculationResultImpl>
    implements _$$CalculationResultImplCopyWith<$Res> {
  __$$CalculationResultImplCopyWithImpl(_$CalculationResultImpl _value,
      $Res Function(_$CalculationResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? designCurrent = null,
    Object? admissibleCurrent = null,
    Object? activePower = null,
    Object? reactivePower = null,
    Object? apparentPower = null,
    Object? powerFactor = null,
    Object? voltageAtNode = null,
    Object? voltageDrop = null,
    Object? voltageDropVolts = null,
    Object? maxShortCircuitCurrent = null,
    Object? minShortCircuitCurrent = null,
    Object? loopImpedance = null,
    Object? status = null,
    Object? errors = null,
    Object? warnings = null,
  }) {
    return _then(_$CalculationResultImpl(
      designCurrent: null == designCurrent
          ? _value.designCurrent
          : designCurrent // ignore: cast_nullable_to_non_nullable
              as double,
      admissibleCurrent: null == admissibleCurrent
          ? _value.admissibleCurrent
          : admissibleCurrent // ignore: cast_nullable_to_non_nullable
              as double,
      activePower: null == activePower
          ? _value.activePower
          : activePower // ignore: cast_nullable_to_non_nullable
              as double,
      reactivePower: null == reactivePower
          ? _value.reactivePower
          : reactivePower // ignore: cast_nullable_to_non_nullable
              as double,
      apparentPower: null == apparentPower
          ? _value.apparentPower
          : apparentPower // ignore: cast_nullable_to_non_nullable
              as double,
      powerFactor: null == powerFactor
          ? _value.powerFactor
          : powerFactor // ignore: cast_nullable_to_non_nullable
              as double,
      voltageAtNode: null == voltageAtNode
          ? _value.voltageAtNode
          : voltageAtNode // ignore: cast_nullable_to_non_nullable
              as double,
      voltageDrop: null == voltageDrop
          ? _value.voltageDrop
          : voltageDrop // ignore: cast_nullable_to_non_nullable
              as double,
      voltageDropVolts: null == voltageDropVolts
          ? _value.voltageDropVolts
          : voltageDropVolts // ignore: cast_nullable_to_non_nullable
              as double,
      maxShortCircuitCurrent: null == maxShortCircuitCurrent
          ? _value.maxShortCircuitCurrent
          : maxShortCircuitCurrent // ignore: cast_nullable_to_non_nullable
              as double,
      minShortCircuitCurrent: null == minShortCircuitCurrent
          ? _value.minShortCircuitCurrent
          : minShortCircuitCurrent // ignore: cast_nullable_to_non_nullable
              as double,
      loopImpedance: null == loopImpedance
          ? _value.loopImpedance
          : loopImpedance // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ValidationStatus,
      errors: null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<ValidationError>,
      warnings: null == warnings
          ? _value._warnings
          : warnings // ignore: cast_nullable_to_non_nullable
              as List<ValidationWarning>,
    ));
  }
}

/// @nodoc

class _$CalculationResultImpl extends _CalculationResult {
  const _$CalculationResultImpl(
      {this.designCurrent = 0.0,
      this.admissibleCurrent = 0.0,
      this.activePower = 0.0,
      this.reactivePower = 0.0,
      this.apparentPower = 0.0,
      this.powerFactor = 1.0,
      this.voltageAtNode = 230.0,
      this.voltageDrop = 0.0,
      this.voltageDropVolts = 0.0,
      this.maxShortCircuitCurrent = 0.0,
      this.minShortCircuitCurrent = 0.0,
      this.loopImpedance = 0.0,
      this.status = ValidationStatus.pending,
      final List<ValidationError> errors = const [],
      final List<ValidationWarning> warnings = const []})
      : _errors = errors,
        _warnings = warnings,
        super._();

// === PASADA 1: Bottom-Up (Suma de Cargas) ===
  /// Intensidad de diseño (Ib) en Amperios
  @override
  @JsonKey()
  final double designCurrent;

  /// Intensidad admisible (Iz) del cable en Amperios
  @override
  @JsonKey()
  final double admissibleCurrent;

  /// Potencia activa (P) en Watts
  @override
  @JsonKey()
  final double activePower;

  /// Potencia reactiva (Q) en VAR
  @override
  @JsonKey()
  final double reactivePower;

  /// Potencia aparente (S) en VA
  @override
  @JsonKey()
  final double apparentPower;

  /// Factor de potencia (cos φ)
  @override
  @JsonKey()
  final double powerFactor;
// === PASADA 2: Top-Down (Caída de Tensión) ===
  /// Tensión real en este nodo (V)
  @override
  @JsonKey()
  final double voltageAtNode;

  /// Caída de tensión acumulada (%)
  @override
  @JsonKey()
  final double voltageDrop;

  /// Caída de tensión acumulada (V)
  @override
  @JsonKey()
  final double voltageDropVolts;

  /// Corriente de cortocircuito máxima (kA)
  @override
  @JsonKey()
  final double maxShortCircuitCurrent;

  /// Corriente de cortocircuito mínima (kA)
  @override
  @JsonKey()
  final double minShortCircuitCurrent;

  /// Impedancia del bucle (Ω)
  @override
  @JsonKey()
  final double loopImpedance;
// === VALIDACIÓN ===
  /// Estado de validación del nodo
  @override
  @JsonKey()
  final ValidationStatus status;

  /// Lista de errores críticos
  final List<ValidationError> _errors;

  /// Lista de errores críticos
  @override
  @JsonKey()
  List<ValidationError> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  /// Lista de advertencias
  final List<ValidationWarning> _warnings;

  /// Lista de advertencias
  @override
  @JsonKey()
  List<ValidationWarning> get warnings {
    if (_warnings is EqualUnmodifiableListView) return _warnings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_warnings);
  }

  @override
  String toString() {
    return 'CalculationResult(designCurrent: $designCurrent, admissibleCurrent: $admissibleCurrent, activePower: $activePower, reactivePower: $reactivePower, apparentPower: $apparentPower, powerFactor: $powerFactor, voltageAtNode: $voltageAtNode, voltageDrop: $voltageDrop, voltageDropVolts: $voltageDropVolts, maxShortCircuitCurrent: $maxShortCircuitCurrent, minShortCircuitCurrent: $minShortCircuitCurrent, loopImpedance: $loopImpedance, status: $status, errors: $errors, warnings: $warnings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalculationResultImpl &&
            (identical(other.designCurrent, designCurrent) ||
                other.designCurrent == designCurrent) &&
            (identical(other.admissibleCurrent, admissibleCurrent) ||
                other.admissibleCurrent == admissibleCurrent) &&
            (identical(other.activePower, activePower) ||
                other.activePower == activePower) &&
            (identical(other.reactivePower, reactivePower) ||
                other.reactivePower == reactivePower) &&
            (identical(other.apparentPower, apparentPower) ||
                other.apparentPower == apparentPower) &&
            (identical(other.powerFactor, powerFactor) ||
                other.powerFactor == powerFactor) &&
            (identical(other.voltageAtNode, voltageAtNode) ||
                other.voltageAtNode == voltageAtNode) &&
            (identical(other.voltageDrop, voltageDrop) ||
                other.voltageDrop == voltageDrop) &&
            (identical(other.voltageDropVolts, voltageDropVolts) ||
                other.voltageDropVolts == voltageDropVolts) &&
            (identical(other.maxShortCircuitCurrent, maxShortCircuitCurrent) ||
                other.maxShortCircuitCurrent == maxShortCircuitCurrent) &&
            (identical(other.minShortCircuitCurrent, minShortCircuitCurrent) ||
                other.minShortCircuitCurrent == minShortCircuitCurrent) &&
            (identical(other.loopImpedance, loopImpedance) ||
                other.loopImpedance == loopImpedance) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            const DeepCollectionEquality().equals(other._warnings, _warnings));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      designCurrent,
      admissibleCurrent,
      activePower,
      reactivePower,
      apparentPower,
      powerFactor,
      voltageAtNode,
      voltageDrop,
      voltageDropVolts,
      maxShortCircuitCurrent,
      minShortCircuitCurrent,
      loopImpedance,
      status,
      const DeepCollectionEquality().hash(_errors),
      const DeepCollectionEquality().hash(_warnings));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CalculationResultImplCopyWith<_$CalculationResultImpl> get copyWith =>
      __$$CalculationResultImplCopyWithImpl<_$CalculationResultImpl>(
          this, _$identity);
}

abstract class _CalculationResult extends CalculationResult {
  const factory _CalculationResult(
      {final double designCurrent,
      final double admissibleCurrent,
      final double activePower,
      final double reactivePower,
      final double apparentPower,
      final double powerFactor,
      final double voltageAtNode,
      final double voltageDrop,
      final double voltageDropVolts,
      final double maxShortCircuitCurrent,
      final double minShortCircuitCurrent,
      final double loopImpedance,
      final ValidationStatus status,
      final List<ValidationError> errors,
      final List<ValidationWarning> warnings}) = _$CalculationResultImpl;
  const _CalculationResult._() : super._();

  @override // === PASADA 1: Bottom-Up (Suma de Cargas) ===
  /// Intensidad de diseño (Ib) en Amperios
  double get designCurrent;
  @override

  /// Intensidad admisible (Iz) del cable en Amperios
  double get admissibleCurrent;
  @override

  /// Potencia activa (P) en Watts
  double get activePower;
  @override

  /// Potencia reactiva (Q) en VAR
  double get reactivePower;
  @override

  /// Potencia aparente (S) en VA
  double get apparentPower;
  @override

  /// Factor de potencia (cos φ)
  double get powerFactor;
  @override // === PASADA 2: Top-Down (Caída de Tensión) ===
  /// Tensión real en este nodo (V)
  double get voltageAtNode;
  @override

  /// Caída de tensión acumulada (%)
  double get voltageDrop;
  @override

  /// Caída de tensión acumulada (V)
  double get voltageDropVolts;
  @override

  /// Corriente de cortocircuito máxima (kA)
  double get maxShortCircuitCurrent;
  @override

  /// Corriente de cortocircuito mínima (kA)
  double get minShortCircuitCurrent;
  @override

  /// Impedancia del bucle (Ω)
  double get loopImpedance;
  @override // === VALIDACIÓN ===
  /// Estado de validación del nodo
  ValidationStatus get status;
  @override

  /// Lista de errores críticos
  List<ValidationError> get errors;
  @override

  /// Lista de advertencias
  List<ValidationWarning> get warnings;
  @override
  @JsonKey(ignore: true)
  _$$CalculationResultImplCopyWith<_$CalculationResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
