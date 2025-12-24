// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forensic_finding.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ForensicFinding {
  String get code =>
      throw _privateConstructorUsedError; // Código único del error (e.g. 'LOOSE_CONNECTION')
  String get title => throw _privateConstructorUsedError; // Título corto
  String get description =>
      throw _privateConstructorUsedError; // Explicación detallada
  FindingSeverity get severity => throw _privateConstructorUsedError;
  double get measuredValue => throw _privateConstructorUsedError;
  double get theoreticalValue => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ForensicFindingCopyWith<ForensicFinding> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForensicFindingCopyWith<$Res> {
  factory $ForensicFindingCopyWith(
          ForensicFinding value, $Res Function(ForensicFinding) then) =
      _$ForensicFindingCopyWithImpl<$Res, ForensicFinding>;
  @useResult
  $Res call(
      {String code,
      String title,
      String description,
      FindingSeverity severity,
      double measuredValue,
      double theoreticalValue});
}

/// @nodoc
class _$ForensicFindingCopyWithImpl<$Res, $Val extends ForensicFinding>
    implements $ForensicFindingCopyWith<$Res> {
  _$ForensicFindingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? title = null,
    Object? description = null,
    Object? severity = null,
    Object? measuredValue = null,
    Object? theoreticalValue = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as FindingSeverity,
      measuredValue: null == measuredValue
          ? _value.measuredValue
          : measuredValue // ignore: cast_nullable_to_non_nullable
              as double,
      theoreticalValue: null == theoreticalValue
          ? _value.theoreticalValue
          : theoreticalValue // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ForensicFindingImplCopyWith<$Res>
    implements $ForensicFindingCopyWith<$Res> {
  factory _$$ForensicFindingImplCopyWith(_$ForensicFindingImpl value,
          $Res Function(_$ForensicFindingImpl) then) =
      __$$ForensicFindingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String code,
      String title,
      String description,
      FindingSeverity severity,
      double measuredValue,
      double theoreticalValue});
}

/// @nodoc
class __$$ForensicFindingImplCopyWithImpl<$Res>
    extends _$ForensicFindingCopyWithImpl<$Res, _$ForensicFindingImpl>
    implements _$$ForensicFindingImplCopyWith<$Res> {
  __$$ForensicFindingImplCopyWithImpl(
      _$ForensicFindingImpl _value, $Res Function(_$ForensicFindingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? title = null,
    Object? description = null,
    Object? severity = null,
    Object? measuredValue = null,
    Object? theoreticalValue = null,
  }) {
    return _then(_$ForensicFindingImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as FindingSeverity,
      measuredValue: null == measuredValue
          ? _value.measuredValue
          : measuredValue // ignore: cast_nullable_to_non_nullable
              as double,
      theoreticalValue: null == theoreticalValue
          ? _value.theoreticalValue
          : theoreticalValue // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$ForensicFindingImpl implements _ForensicFinding {
  const _$ForensicFindingImpl(
      {required this.code,
      required this.title,
      required this.description,
      required this.severity,
      required this.measuredValue,
      required this.theoreticalValue});

  @override
  final String code;
// Código único del error (e.g. 'LOOSE_CONNECTION')
  @override
  final String title;
// Título corto
  @override
  final String description;
// Explicación detallada
  @override
  final FindingSeverity severity;
  @override
  final double measuredValue;
  @override
  final double theoreticalValue;

  @override
  String toString() {
    return 'ForensicFinding(code: $code, title: $title, description: $description, severity: $severity, measuredValue: $measuredValue, theoreticalValue: $theoreticalValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForensicFindingImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.measuredValue, measuredValue) ||
                other.measuredValue == measuredValue) &&
            (identical(other.theoreticalValue, theoreticalValue) ||
                other.theoreticalValue == theoreticalValue));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, title, description,
      severity, measuredValue, theoreticalValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ForensicFindingImplCopyWith<_$ForensicFindingImpl> get copyWith =>
      __$$ForensicFindingImplCopyWithImpl<_$ForensicFindingImpl>(
          this, _$identity);
}

abstract class _ForensicFinding implements ForensicFinding {
  const factory _ForensicFinding(
      {required final String code,
      required final String title,
      required final String description,
      required final FindingSeverity severity,
      required final double measuredValue,
      required final double theoreticalValue}) = _$ForensicFindingImpl;

  @override
  String get code;
  @override // Código único del error (e.g. 'LOOSE_CONNECTION')
  String get title;
  @override // Título corto
  String get description;
  @override // Explicación detallada
  FindingSeverity get severity;
  @override
  double get measuredValue;
  @override
  double get theoreticalValue;
  @override
  @JsonKey(ignore: true)
  _$$ForensicFindingImplCopyWith<_$ForensicFindingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
