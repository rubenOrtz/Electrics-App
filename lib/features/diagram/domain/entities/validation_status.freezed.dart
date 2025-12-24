// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'validation_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ValidationError {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String message, double requiredSection, double currentSection)
        cableOverload,
    required TResult Function(String message, double actual, double limit)
        voltageDrop,
    required TResult Function(
            String message, double breakingCapacity, double shortCircuitCurrent)
        shortCircuit,
    required TResult Function(
            String message, double designCurrent, double protectionRating)
        underprotection,
    required TResult Function(String message, double ibAmps, double inAmps)
        overload,
    required TResult Function(String message, double inAmps, double izAmps)
        fireHazard,
    required TResult Function(String message) general,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String message, double requiredSection, double currentSection)?
        cableOverload,
    TResult? Function(String message, double actual, double limit)? voltageDrop,
    TResult? Function(String message, double breakingCapacity,
            double shortCircuitCurrent)?
        shortCircuit,
    TResult? Function(
            String message, double designCurrent, double protectionRating)?
        underprotection,
    TResult? Function(String message, double ibAmps, double inAmps)? overload,
    TResult? Function(String message, double inAmps, double izAmps)? fireHazard,
    TResult? Function(String message)? general,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String message, double requiredSection, double currentSection)?
        cableOverload,
    TResult Function(String message, double actual, double limit)? voltageDrop,
    TResult Function(String message, double breakingCapacity,
            double shortCircuitCurrent)?
        shortCircuit,
    TResult Function(
            String message, double designCurrent, double protectionRating)?
        underprotection,
    TResult Function(String message, double ibAmps, double inAmps)? overload,
    TResult Function(String message, double inAmps, double izAmps)? fireHazard,
    TResult Function(String message)? general,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CableOverloadError value) cableOverload,
    required TResult Function(VoltageDropError value) voltageDrop,
    required TResult Function(ShortCircuitError value) shortCircuit,
    required TResult Function(UnderprotectionError value) underprotection,
    required TResult Function(OverloadError value) overload,
    required TResult Function(FireHazardError value) fireHazard,
    required TResult Function(GeneralError value) general,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CableOverloadError value)? cableOverload,
    TResult? Function(VoltageDropError value)? voltageDrop,
    TResult? Function(ShortCircuitError value)? shortCircuit,
    TResult? Function(UnderprotectionError value)? underprotection,
    TResult? Function(OverloadError value)? overload,
    TResult? Function(FireHazardError value)? fireHazard,
    TResult? Function(GeneralError value)? general,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CableOverloadError value)? cableOverload,
    TResult Function(VoltageDropError value)? voltageDrop,
    TResult Function(ShortCircuitError value)? shortCircuit,
    TResult Function(UnderprotectionError value)? underprotection,
    TResult Function(OverloadError value)? overload,
    TResult Function(FireHazardError value)? fireHazard,
    TResult Function(GeneralError value)? general,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ValidationErrorCopyWith<ValidationError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValidationErrorCopyWith<$Res> {
  factory $ValidationErrorCopyWith(
          ValidationError value, $Res Function(ValidationError) then) =
      _$ValidationErrorCopyWithImpl<$Res, ValidationError>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$ValidationErrorCopyWithImpl<$Res, $Val extends ValidationError>
    implements $ValidationErrorCopyWith<$Res> {
  _$ValidationErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CableOverloadErrorImplCopyWith<$Res>
    implements $ValidationErrorCopyWith<$Res> {
  factory _$$CableOverloadErrorImplCopyWith(_$CableOverloadErrorImpl value,
          $Res Function(_$CableOverloadErrorImpl) then) =
      __$$CableOverloadErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, double requiredSection, double currentSection});
}

/// @nodoc
class __$$CableOverloadErrorImplCopyWithImpl<$Res>
    extends _$ValidationErrorCopyWithImpl<$Res, _$CableOverloadErrorImpl>
    implements _$$CableOverloadErrorImplCopyWith<$Res> {
  __$$CableOverloadErrorImplCopyWithImpl(_$CableOverloadErrorImpl _value,
      $Res Function(_$CableOverloadErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? requiredSection = null,
    Object? currentSection = null,
  }) {
    return _then(_$CableOverloadErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      requiredSection: null == requiredSection
          ? _value.requiredSection
          : requiredSection // ignore: cast_nullable_to_non_nullable
              as double,
      currentSection: null == currentSection
          ? _value.currentSection
          : currentSection // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$CableOverloadErrorImpl implements CableOverloadError {
  const _$CableOverloadErrorImpl(
      {required this.message,
      required this.requiredSection,
      required this.currentSection});

  @override
  final String message;
  @override
  final double requiredSection;
  @override
  final double currentSection;

  @override
  String toString() {
    return 'ValidationError.cableOverload(message: $message, requiredSection: $requiredSection, currentSection: $currentSection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CableOverloadErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.requiredSection, requiredSection) ||
                other.requiredSection == requiredSection) &&
            (identical(other.currentSection, currentSection) ||
                other.currentSection == currentSection));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, message, requiredSection, currentSection);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CableOverloadErrorImplCopyWith<_$CableOverloadErrorImpl> get copyWith =>
      __$$CableOverloadErrorImplCopyWithImpl<_$CableOverloadErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String message, double requiredSection, double currentSection)
        cableOverload,
    required TResult Function(String message, double actual, double limit)
        voltageDrop,
    required TResult Function(
            String message, double breakingCapacity, double shortCircuitCurrent)
        shortCircuit,
    required TResult Function(
            String message, double designCurrent, double protectionRating)
        underprotection,
    required TResult Function(String message, double ibAmps, double inAmps)
        overload,
    required TResult Function(String message, double inAmps, double izAmps)
        fireHazard,
    required TResult Function(String message) general,
  }) {
    return cableOverload(message, requiredSection, currentSection);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String message, double requiredSection, double currentSection)?
        cableOverload,
    TResult? Function(String message, double actual, double limit)? voltageDrop,
    TResult? Function(String message, double breakingCapacity,
            double shortCircuitCurrent)?
        shortCircuit,
    TResult? Function(
            String message, double designCurrent, double protectionRating)?
        underprotection,
    TResult? Function(String message, double ibAmps, double inAmps)? overload,
    TResult? Function(String message, double inAmps, double izAmps)? fireHazard,
    TResult? Function(String message)? general,
  }) {
    return cableOverload?.call(message, requiredSection, currentSection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String message, double requiredSection, double currentSection)?
        cableOverload,
    TResult Function(String message, double actual, double limit)? voltageDrop,
    TResult Function(String message, double breakingCapacity,
            double shortCircuitCurrent)?
        shortCircuit,
    TResult Function(
            String message, double designCurrent, double protectionRating)?
        underprotection,
    TResult Function(String message, double ibAmps, double inAmps)? overload,
    TResult Function(String message, double inAmps, double izAmps)? fireHazard,
    TResult Function(String message)? general,
    required TResult orElse(),
  }) {
    if (cableOverload != null) {
      return cableOverload(message, requiredSection, currentSection);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CableOverloadError value) cableOverload,
    required TResult Function(VoltageDropError value) voltageDrop,
    required TResult Function(ShortCircuitError value) shortCircuit,
    required TResult Function(UnderprotectionError value) underprotection,
    required TResult Function(OverloadError value) overload,
    required TResult Function(FireHazardError value) fireHazard,
    required TResult Function(GeneralError value) general,
  }) {
    return cableOverload(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CableOverloadError value)? cableOverload,
    TResult? Function(VoltageDropError value)? voltageDrop,
    TResult? Function(ShortCircuitError value)? shortCircuit,
    TResult? Function(UnderprotectionError value)? underprotection,
    TResult? Function(OverloadError value)? overload,
    TResult? Function(FireHazardError value)? fireHazard,
    TResult? Function(GeneralError value)? general,
  }) {
    return cableOverload?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CableOverloadError value)? cableOverload,
    TResult Function(VoltageDropError value)? voltageDrop,
    TResult Function(ShortCircuitError value)? shortCircuit,
    TResult Function(UnderprotectionError value)? underprotection,
    TResult Function(OverloadError value)? overload,
    TResult Function(FireHazardError value)? fireHazard,
    TResult Function(GeneralError value)? general,
    required TResult orElse(),
  }) {
    if (cableOverload != null) {
      return cableOverload(this);
    }
    return orElse();
  }
}

abstract class CableOverloadError implements ValidationError {
  const factory CableOverloadError(
      {required final String message,
      required final double requiredSection,
      required final double currentSection}) = _$CableOverloadErrorImpl;

  @override
  String get message;
  double get requiredSection;
  double get currentSection;
  @override
  @JsonKey(ignore: true)
  _$$CableOverloadErrorImplCopyWith<_$CableOverloadErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VoltageDropErrorImplCopyWith<$Res>
    implements $ValidationErrorCopyWith<$Res> {
  factory _$$VoltageDropErrorImplCopyWith(_$VoltageDropErrorImpl value,
          $Res Function(_$VoltageDropErrorImpl) then) =
      __$$VoltageDropErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, double actual, double limit});
}

/// @nodoc
class __$$VoltageDropErrorImplCopyWithImpl<$Res>
    extends _$ValidationErrorCopyWithImpl<$Res, _$VoltageDropErrorImpl>
    implements _$$VoltageDropErrorImplCopyWith<$Res> {
  __$$VoltageDropErrorImplCopyWithImpl(_$VoltageDropErrorImpl _value,
      $Res Function(_$VoltageDropErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? actual = null,
    Object? limit = null,
  }) {
    return _then(_$VoltageDropErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      actual: null == actual
          ? _value.actual
          : actual // ignore: cast_nullable_to_non_nullable
              as double,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$VoltageDropErrorImpl implements VoltageDropError {
  const _$VoltageDropErrorImpl(
      {required this.message, required this.actual, required this.limit});

  @override
  final String message;
  @override
  final double actual;
  @override
  final double limit;

  @override
  String toString() {
    return 'ValidationError.voltageDrop(message: $message, actual: $actual, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoltageDropErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.actual, actual) || other.actual == actual) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, actual, limit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VoltageDropErrorImplCopyWith<_$VoltageDropErrorImpl> get copyWith =>
      __$$VoltageDropErrorImplCopyWithImpl<_$VoltageDropErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String message, double requiredSection, double currentSection)
        cableOverload,
    required TResult Function(String message, double actual, double limit)
        voltageDrop,
    required TResult Function(
            String message, double breakingCapacity, double shortCircuitCurrent)
        shortCircuit,
    required TResult Function(
            String message, double designCurrent, double protectionRating)
        underprotection,
    required TResult Function(String message, double ibAmps, double inAmps)
        overload,
    required TResult Function(String message, double inAmps, double izAmps)
        fireHazard,
    required TResult Function(String message) general,
  }) {
    return voltageDrop(message, actual, limit);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String message, double requiredSection, double currentSection)?
        cableOverload,
    TResult? Function(String message, double actual, double limit)? voltageDrop,
    TResult? Function(String message, double breakingCapacity,
            double shortCircuitCurrent)?
        shortCircuit,
    TResult? Function(
            String message, double designCurrent, double protectionRating)?
        underprotection,
    TResult? Function(String message, double ibAmps, double inAmps)? overload,
    TResult? Function(String message, double inAmps, double izAmps)? fireHazard,
    TResult? Function(String message)? general,
  }) {
    return voltageDrop?.call(message, actual, limit);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String message, double requiredSection, double currentSection)?
        cableOverload,
    TResult Function(String message, double actual, double limit)? voltageDrop,
    TResult Function(String message, double breakingCapacity,
            double shortCircuitCurrent)?
        shortCircuit,
    TResult Function(
            String message, double designCurrent, double protectionRating)?
        underprotection,
    TResult Function(String message, double ibAmps, double inAmps)? overload,
    TResult Function(String message, double inAmps, double izAmps)? fireHazard,
    TResult Function(String message)? general,
    required TResult orElse(),
  }) {
    if (voltageDrop != null) {
      return voltageDrop(message, actual, limit);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CableOverloadError value) cableOverload,
    required TResult Function(VoltageDropError value) voltageDrop,
    required TResult Function(ShortCircuitError value) shortCircuit,
    required TResult Function(UnderprotectionError value) underprotection,
    required TResult Function(OverloadError value) overload,
    required TResult Function(FireHazardError value) fireHazard,
    required TResult Function(GeneralError value) general,
  }) {
    return voltageDrop(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CableOverloadError value)? cableOverload,
    TResult? Function(VoltageDropError value)? voltageDrop,
    TResult? Function(ShortCircuitError value)? shortCircuit,
    TResult? Function(UnderprotectionError value)? underprotection,
    TResult? Function(OverloadError value)? overload,
    TResult? Function(FireHazardError value)? fireHazard,
    TResult? Function(GeneralError value)? general,
  }) {
    return voltageDrop?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CableOverloadError value)? cableOverload,
    TResult Function(VoltageDropError value)? voltageDrop,
    TResult Function(ShortCircuitError value)? shortCircuit,
    TResult Function(UnderprotectionError value)? underprotection,
    TResult Function(OverloadError value)? overload,
    TResult Function(FireHazardError value)? fireHazard,
    TResult Function(GeneralError value)? general,
    required TResult orElse(),
  }) {
    if (voltageDrop != null) {
      return voltageDrop(this);
    }
    return orElse();
  }
}

abstract class VoltageDropError implements ValidationError {
  const factory VoltageDropError(
      {required final String message,
      required final double actual,
      required final double limit}) = _$VoltageDropErrorImpl;

  @override
  String get message;
  double get actual;
  double get limit;
  @override
  @JsonKey(ignore: true)
  _$$VoltageDropErrorImplCopyWith<_$VoltageDropErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ShortCircuitErrorImplCopyWith<$Res>
    implements $ValidationErrorCopyWith<$Res> {
  factory _$$ShortCircuitErrorImplCopyWith(_$ShortCircuitErrorImpl value,
          $Res Function(_$ShortCircuitErrorImpl) then) =
      __$$ShortCircuitErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String message, double breakingCapacity, double shortCircuitCurrent});
}

/// @nodoc
class __$$ShortCircuitErrorImplCopyWithImpl<$Res>
    extends _$ValidationErrorCopyWithImpl<$Res, _$ShortCircuitErrorImpl>
    implements _$$ShortCircuitErrorImplCopyWith<$Res> {
  __$$ShortCircuitErrorImplCopyWithImpl(_$ShortCircuitErrorImpl _value,
      $Res Function(_$ShortCircuitErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? breakingCapacity = null,
    Object? shortCircuitCurrent = null,
  }) {
    return _then(_$ShortCircuitErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      breakingCapacity: null == breakingCapacity
          ? _value.breakingCapacity
          : breakingCapacity // ignore: cast_nullable_to_non_nullable
              as double,
      shortCircuitCurrent: null == shortCircuitCurrent
          ? _value.shortCircuitCurrent
          : shortCircuitCurrent // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$ShortCircuitErrorImpl implements ShortCircuitError {
  const _$ShortCircuitErrorImpl(
      {required this.message,
      required this.breakingCapacity,
      required this.shortCircuitCurrent});

  @override
  final String message;
  @override
  final double breakingCapacity;
  @override
  final double shortCircuitCurrent;

  @override
  String toString() {
    return 'ValidationError.shortCircuit(message: $message, breakingCapacity: $breakingCapacity, shortCircuitCurrent: $shortCircuitCurrent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShortCircuitErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.breakingCapacity, breakingCapacity) ||
                other.breakingCapacity == breakingCapacity) &&
            (identical(other.shortCircuitCurrent, shortCircuitCurrent) ||
                other.shortCircuitCurrent == shortCircuitCurrent));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, message, breakingCapacity, shortCircuitCurrent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ShortCircuitErrorImplCopyWith<_$ShortCircuitErrorImpl> get copyWith =>
      __$$ShortCircuitErrorImplCopyWithImpl<_$ShortCircuitErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String message, double requiredSection, double currentSection)
        cableOverload,
    required TResult Function(String message, double actual, double limit)
        voltageDrop,
    required TResult Function(
            String message, double breakingCapacity, double shortCircuitCurrent)
        shortCircuit,
    required TResult Function(
            String message, double designCurrent, double protectionRating)
        underprotection,
    required TResult Function(String message, double ibAmps, double inAmps)
        overload,
    required TResult Function(String message, double inAmps, double izAmps)
        fireHazard,
    required TResult Function(String message) general,
  }) {
    return shortCircuit(message, breakingCapacity, shortCircuitCurrent);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String message, double requiredSection, double currentSection)?
        cableOverload,
    TResult? Function(String message, double actual, double limit)? voltageDrop,
    TResult? Function(String message, double breakingCapacity,
            double shortCircuitCurrent)?
        shortCircuit,
    TResult? Function(
            String message, double designCurrent, double protectionRating)?
        underprotection,
    TResult? Function(String message, double ibAmps, double inAmps)? overload,
    TResult? Function(String message, double inAmps, double izAmps)? fireHazard,
    TResult? Function(String message)? general,
  }) {
    return shortCircuit?.call(message, breakingCapacity, shortCircuitCurrent);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String message, double requiredSection, double currentSection)?
        cableOverload,
    TResult Function(String message, double actual, double limit)? voltageDrop,
    TResult Function(String message, double breakingCapacity,
            double shortCircuitCurrent)?
        shortCircuit,
    TResult Function(
            String message, double designCurrent, double protectionRating)?
        underprotection,
    TResult Function(String message, double ibAmps, double inAmps)? overload,
    TResult Function(String message, double inAmps, double izAmps)? fireHazard,
    TResult Function(String message)? general,
    required TResult orElse(),
  }) {
    if (shortCircuit != null) {
      return shortCircuit(message, breakingCapacity, shortCircuitCurrent);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CableOverloadError value) cableOverload,
    required TResult Function(VoltageDropError value) voltageDrop,
    required TResult Function(ShortCircuitError value) shortCircuit,
    required TResult Function(UnderprotectionError value) underprotection,
    required TResult Function(OverloadError value) overload,
    required TResult Function(FireHazardError value) fireHazard,
    required TResult Function(GeneralError value) general,
  }) {
    return shortCircuit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CableOverloadError value)? cableOverload,
    TResult? Function(VoltageDropError value)? voltageDrop,
    TResult? Function(ShortCircuitError value)? shortCircuit,
    TResult? Function(UnderprotectionError value)? underprotection,
    TResult? Function(OverloadError value)? overload,
    TResult? Function(FireHazardError value)? fireHazard,
    TResult? Function(GeneralError value)? general,
  }) {
    return shortCircuit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CableOverloadError value)? cableOverload,
    TResult Function(VoltageDropError value)? voltageDrop,
    TResult Function(ShortCircuitError value)? shortCircuit,
    TResult Function(UnderprotectionError value)? underprotection,
    TResult Function(OverloadError value)? overload,
    TResult Function(FireHazardError value)? fireHazard,
    TResult Function(GeneralError value)? general,
    required TResult orElse(),
  }) {
    if (shortCircuit != null) {
      return shortCircuit(this);
    }
    return orElse();
  }
}

abstract class ShortCircuitError implements ValidationError {
  const factory ShortCircuitError(
      {required final String message,
      required final double breakingCapacity,
      required final double shortCircuitCurrent}) = _$ShortCircuitErrorImpl;

  @override
  String get message;
  double get breakingCapacity;
  double get shortCircuitCurrent;
  @override
  @JsonKey(ignore: true)
  _$$ShortCircuitErrorImplCopyWith<_$ShortCircuitErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnderprotectionErrorImplCopyWith<$Res>
    implements $ValidationErrorCopyWith<$Res> {
  factory _$$UnderprotectionErrorImplCopyWith(_$UnderprotectionErrorImpl value,
          $Res Function(_$UnderprotectionErrorImpl) then) =
      __$$UnderprotectionErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, double designCurrent, double protectionRating});
}

/// @nodoc
class __$$UnderprotectionErrorImplCopyWithImpl<$Res>
    extends _$ValidationErrorCopyWithImpl<$Res, _$UnderprotectionErrorImpl>
    implements _$$UnderprotectionErrorImplCopyWith<$Res> {
  __$$UnderprotectionErrorImplCopyWithImpl(_$UnderprotectionErrorImpl _value,
      $Res Function(_$UnderprotectionErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? designCurrent = null,
    Object? protectionRating = null,
  }) {
    return _then(_$UnderprotectionErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      designCurrent: null == designCurrent
          ? _value.designCurrent
          : designCurrent // ignore: cast_nullable_to_non_nullable
              as double,
      protectionRating: null == protectionRating
          ? _value.protectionRating
          : protectionRating // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$UnderprotectionErrorImpl implements UnderprotectionError {
  const _$UnderprotectionErrorImpl(
      {required this.message,
      required this.designCurrent,
      required this.protectionRating});

  @override
  final String message;
  @override
  final double designCurrent;
  @override
  final double protectionRating;

  @override
  String toString() {
    return 'ValidationError.underprotection(message: $message, designCurrent: $designCurrent, protectionRating: $protectionRating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnderprotectionErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.designCurrent, designCurrent) ||
                other.designCurrent == designCurrent) &&
            (identical(other.protectionRating, protectionRating) ||
                other.protectionRating == protectionRating));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, message, designCurrent, protectionRating);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnderprotectionErrorImplCopyWith<_$UnderprotectionErrorImpl>
      get copyWith =>
          __$$UnderprotectionErrorImplCopyWithImpl<_$UnderprotectionErrorImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String message, double requiredSection, double currentSection)
        cableOverload,
    required TResult Function(String message, double actual, double limit)
        voltageDrop,
    required TResult Function(
            String message, double breakingCapacity, double shortCircuitCurrent)
        shortCircuit,
    required TResult Function(
            String message, double designCurrent, double protectionRating)
        underprotection,
    required TResult Function(String message, double ibAmps, double inAmps)
        overload,
    required TResult Function(String message, double inAmps, double izAmps)
        fireHazard,
    required TResult Function(String message) general,
  }) {
    return underprotection(message, designCurrent, protectionRating);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String message, double requiredSection, double currentSection)?
        cableOverload,
    TResult? Function(String message, double actual, double limit)? voltageDrop,
    TResult? Function(String message, double breakingCapacity,
            double shortCircuitCurrent)?
        shortCircuit,
    TResult? Function(
            String message, double designCurrent, double protectionRating)?
        underprotection,
    TResult? Function(String message, double ibAmps, double inAmps)? overload,
    TResult? Function(String message, double inAmps, double izAmps)? fireHazard,
    TResult? Function(String message)? general,
  }) {
    return underprotection?.call(message, designCurrent, protectionRating);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String message, double requiredSection, double currentSection)?
        cableOverload,
    TResult Function(String message, double actual, double limit)? voltageDrop,
    TResult Function(String message, double breakingCapacity,
            double shortCircuitCurrent)?
        shortCircuit,
    TResult Function(
            String message, double designCurrent, double protectionRating)?
        underprotection,
    TResult Function(String message, double ibAmps, double inAmps)? overload,
    TResult Function(String message, double inAmps, double izAmps)? fireHazard,
    TResult Function(String message)? general,
    required TResult orElse(),
  }) {
    if (underprotection != null) {
      return underprotection(message, designCurrent, protectionRating);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CableOverloadError value) cableOverload,
    required TResult Function(VoltageDropError value) voltageDrop,
    required TResult Function(ShortCircuitError value) shortCircuit,
    required TResult Function(UnderprotectionError value) underprotection,
    required TResult Function(OverloadError value) overload,
    required TResult Function(FireHazardError value) fireHazard,
    required TResult Function(GeneralError value) general,
  }) {
    return underprotection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CableOverloadError value)? cableOverload,
    TResult? Function(VoltageDropError value)? voltageDrop,
    TResult? Function(ShortCircuitError value)? shortCircuit,
    TResult? Function(UnderprotectionError value)? underprotection,
    TResult? Function(OverloadError value)? overload,
    TResult? Function(FireHazardError value)? fireHazard,
    TResult? Function(GeneralError value)? general,
  }) {
    return underprotection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CableOverloadError value)? cableOverload,
    TResult Function(VoltageDropError value)? voltageDrop,
    TResult Function(ShortCircuitError value)? shortCircuit,
    TResult Function(UnderprotectionError value)? underprotection,
    TResult Function(OverloadError value)? overload,
    TResult Function(FireHazardError value)? fireHazard,
    TResult Function(GeneralError value)? general,
    required TResult orElse(),
  }) {
    if (underprotection != null) {
      return underprotection(this);
    }
    return orElse();
  }
}

abstract class UnderprotectionError implements ValidationError {
  const factory UnderprotectionError(
      {required final String message,
      required final double designCurrent,
      required final double protectionRating}) = _$UnderprotectionErrorImpl;

  @override
  String get message;
  double get designCurrent;
  double get protectionRating;
  @override
  @JsonKey(ignore: true)
  _$$UnderprotectionErrorImplCopyWith<_$UnderprotectionErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OverloadErrorImplCopyWith<$Res>
    implements $ValidationErrorCopyWith<$Res> {
  factory _$$OverloadErrorImplCopyWith(
          _$OverloadErrorImpl value, $Res Function(_$OverloadErrorImpl) then) =
      __$$OverloadErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, double ibAmps, double inAmps});
}

/// @nodoc
class __$$OverloadErrorImplCopyWithImpl<$Res>
    extends _$ValidationErrorCopyWithImpl<$Res, _$OverloadErrorImpl>
    implements _$$OverloadErrorImplCopyWith<$Res> {
  __$$OverloadErrorImplCopyWithImpl(
      _$OverloadErrorImpl _value, $Res Function(_$OverloadErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? ibAmps = null,
    Object? inAmps = null,
  }) {
    return _then(_$OverloadErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      ibAmps: null == ibAmps
          ? _value.ibAmps
          : ibAmps // ignore: cast_nullable_to_non_nullable
              as double,
      inAmps: null == inAmps
          ? _value.inAmps
          : inAmps // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$OverloadErrorImpl implements OverloadError {
  const _$OverloadErrorImpl(
      {required this.message, required this.ibAmps, required this.inAmps});

  @override
  final String message;
  @override
  final double ibAmps;
  @override
  final double inAmps;

  @override
  String toString() {
    return 'ValidationError.overload(message: $message, ibAmps: $ibAmps, inAmps: $inAmps)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OverloadErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.ibAmps, ibAmps) || other.ibAmps == ibAmps) &&
            (identical(other.inAmps, inAmps) || other.inAmps == inAmps));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, ibAmps, inAmps);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OverloadErrorImplCopyWith<_$OverloadErrorImpl> get copyWith =>
      __$$OverloadErrorImplCopyWithImpl<_$OverloadErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String message, double requiredSection, double currentSection)
        cableOverload,
    required TResult Function(String message, double actual, double limit)
        voltageDrop,
    required TResult Function(
            String message, double breakingCapacity, double shortCircuitCurrent)
        shortCircuit,
    required TResult Function(
            String message, double designCurrent, double protectionRating)
        underprotection,
    required TResult Function(String message, double ibAmps, double inAmps)
        overload,
    required TResult Function(String message, double inAmps, double izAmps)
        fireHazard,
    required TResult Function(String message) general,
  }) {
    return overload(message, ibAmps, inAmps);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String message, double requiredSection, double currentSection)?
        cableOverload,
    TResult? Function(String message, double actual, double limit)? voltageDrop,
    TResult? Function(String message, double breakingCapacity,
            double shortCircuitCurrent)?
        shortCircuit,
    TResult? Function(
            String message, double designCurrent, double protectionRating)?
        underprotection,
    TResult? Function(String message, double ibAmps, double inAmps)? overload,
    TResult? Function(String message, double inAmps, double izAmps)? fireHazard,
    TResult? Function(String message)? general,
  }) {
    return overload?.call(message, ibAmps, inAmps);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String message, double requiredSection, double currentSection)?
        cableOverload,
    TResult Function(String message, double actual, double limit)? voltageDrop,
    TResult Function(String message, double breakingCapacity,
            double shortCircuitCurrent)?
        shortCircuit,
    TResult Function(
            String message, double designCurrent, double protectionRating)?
        underprotection,
    TResult Function(String message, double ibAmps, double inAmps)? overload,
    TResult Function(String message, double inAmps, double izAmps)? fireHazard,
    TResult Function(String message)? general,
    required TResult orElse(),
  }) {
    if (overload != null) {
      return overload(message, ibAmps, inAmps);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CableOverloadError value) cableOverload,
    required TResult Function(VoltageDropError value) voltageDrop,
    required TResult Function(ShortCircuitError value) shortCircuit,
    required TResult Function(UnderprotectionError value) underprotection,
    required TResult Function(OverloadError value) overload,
    required TResult Function(FireHazardError value) fireHazard,
    required TResult Function(GeneralError value) general,
  }) {
    return overload(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CableOverloadError value)? cableOverload,
    TResult? Function(VoltageDropError value)? voltageDrop,
    TResult? Function(ShortCircuitError value)? shortCircuit,
    TResult? Function(UnderprotectionError value)? underprotection,
    TResult? Function(OverloadError value)? overload,
    TResult? Function(FireHazardError value)? fireHazard,
    TResult? Function(GeneralError value)? general,
  }) {
    return overload?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CableOverloadError value)? cableOverload,
    TResult Function(VoltageDropError value)? voltageDrop,
    TResult Function(ShortCircuitError value)? shortCircuit,
    TResult Function(UnderprotectionError value)? underprotection,
    TResult Function(OverloadError value)? overload,
    TResult Function(FireHazardError value)? fireHazard,
    TResult Function(GeneralError value)? general,
    required TResult orElse(),
  }) {
    if (overload != null) {
      return overload(this);
    }
    return orElse();
  }
}

abstract class OverloadError implements ValidationError {
  const factory OverloadError(
      {required final String message,
      required final double ibAmps,
      required final double inAmps}) = _$OverloadErrorImpl;

  @override
  String get message;
  double get ibAmps;
  double get inAmps;
  @override
  @JsonKey(ignore: true)
  _$$OverloadErrorImplCopyWith<_$OverloadErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FireHazardErrorImplCopyWith<$Res>
    implements $ValidationErrorCopyWith<$Res> {
  factory _$$FireHazardErrorImplCopyWith(_$FireHazardErrorImpl value,
          $Res Function(_$FireHazardErrorImpl) then) =
      __$$FireHazardErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, double inAmps, double izAmps});
}

/// @nodoc
class __$$FireHazardErrorImplCopyWithImpl<$Res>
    extends _$ValidationErrorCopyWithImpl<$Res, _$FireHazardErrorImpl>
    implements _$$FireHazardErrorImplCopyWith<$Res> {
  __$$FireHazardErrorImplCopyWithImpl(
      _$FireHazardErrorImpl _value, $Res Function(_$FireHazardErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? inAmps = null,
    Object? izAmps = null,
  }) {
    return _then(_$FireHazardErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      inAmps: null == inAmps
          ? _value.inAmps
          : inAmps // ignore: cast_nullable_to_non_nullable
              as double,
      izAmps: null == izAmps
          ? _value.izAmps
          : izAmps // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$FireHazardErrorImpl implements FireHazardError {
  const _$FireHazardErrorImpl(
      {required this.message, required this.inAmps, required this.izAmps});

  @override
  final String message;
  @override
  final double inAmps;
  @override
  final double izAmps;

  @override
  String toString() {
    return 'ValidationError.fireHazard(message: $message, inAmps: $inAmps, izAmps: $izAmps)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FireHazardErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.inAmps, inAmps) || other.inAmps == inAmps) &&
            (identical(other.izAmps, izAmps) || other.izAmps == izAmps));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, inAmps, izAmps);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FireHazardErrorImplCopyWith<_$FireHazardErrorImpl> get copyWith =>
      __$$FireHazardErrorImplCopyWithImpl<_$FireHazardErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String message, double requiredSection, double currentSection)
        cableOverload,
    required TResult Function(String message, double actual, double limit)
        voltageDrop,
    required TResult Function(
            String message, double breakingCapacity, double shortCircuitCurrent)
        shortCircuit,
    required TResult Function(
            String message, double designCurrent, double protectionRating)
        underprotection,
    required TResult Function(String message, double ibAmps, double inAmps)
        overload,
    required TResult Function(String message, double inAmps, double izAmps)
        fireHazard,
    required TResult Function(String message) general,
  }) {
    return fireHazard(message, inAmps, izAmps);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String message, double requiredSection, double currentSection)?
        cableOverload,
    TResult? Function(String message, double actual, double limit)? voltageDrop,
    TResult? Function(String message, double breakingCapacity,
            double shortCircuitCurrent)?
        shortCircuit,
    TResult? Function(
            String message, double designCurrent, double protectionRating)?
        underprotection,
    TResult? Function(String message, double ibAmps, double inAmps)? overload,
    TResult? Function(String message, double inAmps, double izAmps)? fireHazard,
    TResult? Function(String message)? general,
  }) {
    return fireHazard?.call(message, inAmps, izAmps);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String message, double requiredSection, double currentSection)?
        cableOverload,
    TResult Function(String message, double actual, double limit)? voltageDrop,
    TResult Function(String message, double breakingCapacity,
            double shortCircuitCurrent)?
        shortCircuit,
    TResult Function(
            String message, double designCurrent, double protectionRating)?
        underprotection,
    TResult Function(String message, double ibAmps, double inAmps)? overload,
    TResult Function(String message, double inAmps, double izAmps)? fireHazard,
    TResult Function(String message)? general,
    required TResult orElse(),
  }) {
    if (fireHazard != null) {
      return fireHazard(message, inAmps, izAmps);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CableOverloadError value) cableOverload,
    required TResult Function(VoltageDropError value) voltageDrop,
    required TResult Function(ShortCircuitError value) shortCircuit,
    required TResult Function(UnderprotectionError value) underprotection,
    required TResult Function(OverloadError value) overload,
    required TResult Function(FireHazardError value) fireHazard,
    required TResult Function(GeneralError value) general,
  }) {
    return fireHazard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CableOverloadError value)? cableOverload,
    TResult? Function(VoltageDropError value)? voltageDrop,
    TResult? Function(ShortCircuitError value)? shortCircuit,
    TResult? Function(UnderprotectionError value)? underprotection,
    TResult? Function(OverloadError value)? overload,
    TResult? Function(FireHazardError value)? fireHazard,
    TResult? Function(GeneralError value)? general,
  }) {
    return fireHazard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CableOverloadError value)? cableOverload,
    TResult Function(VoltageDropError value)? voltageDrop,
    TResult Function(ShortCircuitError value)? shortCircuit,
    TResult Function(UnderprotectionError value)? underprotection,
    TResult Function(OverloadError value)? overload,
    TResult Function(FireHazardError value)? fireHazard,
    TResult Function(GeneralError value)? general,
    required TResult orElse(),
  }) {
    if (fireHazard != null) {
      return fireHazard(this);
    }
    return orElse();
  }
}

abstract class FireHazardError implements ValidationError {
  const factory FireHazardError(
      {required final String message,
      required final double inAmps,
      required final double izAmps}) = _$FireHazardErrorImpl;

  @override
  String get message;
  double get inAmps;
  double get izAmps;
  @override
  @JsonKey(ignore: true)
  _$$FireHazardErrorImplCopyWith<_$FireHazardErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GeneralErrorImplCopyWith<$Res>
    implements $ValidationErrorCopyWith<$Res> {
  factory _$$GeneralErrorImplCopyWith(
          _$GeneralErrorImpl value, $Res Function(_$GeneralErrorImpl) then) =
      __$$GeneralErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$GeneralErrorImplCopyWithImpl<$Res>
    extends _$ValidationErrorCopyWithImpl<$Res, _$GeneralErrorImpl>
    implements _$$GeneralErrorImplCopyWith<$Res> {
  __$$GeneralErrorImplCopyWithImpl(
      _$GeneralErrorImpl _value, $Res Function(_$GeneralErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$GeneralErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GeneralErrorImpl implements GeneralError {
  const _$GeneralErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'ValidationError.general(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeneralErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GeneralErrorImplCopyWith<_$GeneralErrorImpl> get copyWith =>
      __$$GeneralErrorImplCopyWithImpl<_$GeneralErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String message, double requiredSection, double currentSection)
        cableOverload,
    required TResult Function(String message, double actual, double limit)
        voltageDrop,
    required TResult Function(
            String message, double breakingCapacity, double shortCircuitCurrent)
        shortCircuit,
    required TResult Function(
            String message, double designCurrent, double protectionRating)
        underprotection,
    required TResult Function(String message, double ibAmps, double inAmps)
        overload,
    required TResult Function(String message, double inAmps, double izAmps)
        fireHazard,
    required TResult Function(String message) general,
  }) {
    return general(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String message, double requiredSection, double currentSection)?
        cableOverload,
    TResult? Function(String message, double actual, double limit)? voltageDrop,
    TResult? Function(String message, double breakingCapacity,
            double shortCircuitCurrent)?
        shortCircuit,
    TResult? Function(
            String message, double designCurrent, double protectionRating)?
        underprotection,
    TResult? Function(String message, double ibAmps, double inAmps)? overload,
    TResult? Function(String message, double inAmps, double izAmps)? fireHazard,
    TResult? Function(String message)? general,
  }) {
    return general?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String message, double requiredSection, double currentSection)?
        cableOverload,
    TResult Function(String message, double actual, double limit)? voltageDrop,
    TResult Function(String message, double breakingCapacity,
            double shortCircuitCurrent)?
        shortCircuit,
    TResult Function(
            String message, double designCurrent, double protectionRating)?
        underprotection,
    TResult Function(String message, double ibAmps, double inAmps)? overload,
    TResult Function(String message, double inAmps, double izAmps)? fireHazard,
    TResult Function(String message)? general,
    required TResult orElse(),
  }) {
    if (general != null) {
      return general(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CableOverloadError value) cableOverload,
    required TResult Function(VoltageDropError value) voltageDrop,
    required TResult Function(ShortCircuitError value) shortCircuit,
    required TResult Function(UnderprotectionError value) underprotection,
    required TResult Function(OverloadError value) overload,
    required TResult Function(FireHazardError value) fireHazard,
    required TResult Function(GeneralError value) general,
  }) {
    return general(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CableOverloadError value)? cableOverload,
    TResult? Function(VoltageDropError value)? voltageDrop,
    TResult? Function(ShortCircuitError value)? shortCircuit,
    TResult? Function(UnderprotectionError value)? underprotection,
    TResult? Function(OverloadError value)? overload,
    TResult? Function(FireHazardError value)? fireHazard,
    TResult? Function(GeneralError value)? general,
  }) {
    return general?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CableOverloadError value)? cableOverload,
    TResult Function(VoltageDropError value)? voltageDrop,
    TResult Function(ShortCircuitError value)? shortCircuit,
    TResult Function(UnderprotectionError value)? underprotection,
    TResult Function(OverloadError value)? overload,
    TResult Function(FireHazardError value)? fireHazard,
    TResult Function(GeneralError value)? general,
    required TResult orElse(),
  }) {
    if (general != null) {
      return general(this);
    }
    return orElse();
  }
}

abstract class GeneralError implements ValidationError {
  const factory GeneralError({required final String message}) =
      _$GeneralErrorImpl;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$GeneralErrorImplCopyWith<_$GeneralErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ValidationWarning {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String message, double currentSection, double recommendedSection)
        oversizedCable,
    required TResult Function(String message, double powerFactor)
        lowPowerFactor,
    required TResult Function(String message) general,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String message, double currentSection, double recommendedSection)?
        oversizedCable,
    TResult? Function(String message, double powerFactor)? lowPowerFactor,
    TResult? Function(String message)? general,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String message, double currentSection, double recommendedSection)?
        oversizedCable,
    TResult Function(String message, double powerFactor)? lowPowerFactor,
    TResult Function(String message)? general,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OversizedCableWarning value) oversizedCable,
    required TResult Function(LowPowerFactorWarning value) lowPowerFactor,
    required TResult Function(GeneralWarning value) general,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OversizedCableWarning value)? oversizedCable,
    TResult? Function(LowPowerFactorWarning value)? lowPowerFactor,
    TResult? Function(GeneralWarning value)? general,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OversizedCableWarning value)? oversizedCable,
    TResult Function(LowPowerFactorWarning value)? lowPowerFactor,
    TResult Function(GeneralWarning value)? general,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ValidationWarningCopyWith<ValidationWarning> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ValidationWarningCopyWith<$Res> {
  factory $ValidationWarningCopyWith(
          ValidationWarning value, $Res Function(ValidationWarning) then) =
      _$ValidationWarningCopyWithImpl<$Res, ValidationWarning>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$ValidationWarningCopyWithImpl<$Res, $Val extends ValidationWarning>
    implements $ValidationWarningCopyWith<$Res> {
  _$ValidationWarningCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OversizedCableWarningImplCopyWith<$Res>
    implements $ValidationWarningCopyWith<$Res> {
  factory _$$OversizedCableWarningImplCopyWith(
          _$OversizedCableWarningImpl value,
          $Res Function(_$OversizedCableWarningImpl) then) =
      __$$OversizedCableWarningImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, double currentSection, double recommendedSection});
}

/// @nodoc
class __$$OversizedCableWarningImplCopyWithImpl<$Res>
    extends _$ValidationWarningCopyWithImpl<$Res, _$OversizedCableWarningImpl>
    implements _$$OversizedCableWarningImplCopyWith<$Res> {
  __$$OversizedCableWarningImplCopyWithImpl(_$OversizedCableWarningImpl _value,
      $Res Function(_$OversizedCableWarningImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? currentSection = null,
    Object? recommendedSection = null,
  }) {
    return _then(_$OversizedCableWarningImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      currentSection: null == currentSection
          ? _value.currentSection
          : currentSection // ignore: cast_nullable_to_non_nullable
              as double,
      recommendedSection: null == recommendedSection
          ? _value.recommendedSection
          : recommendedSection // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$OversizedCableWarningImpl implements OversizedCableWarning {
  const _$OversizedCableWarningImpl(
      {required this.message,
      required this.currentSection,
      required this.recommendedSection});

  @override
  final String message;
  @override
  final double currentSection;
  @override
  final double recommendedSection;

  @override
  String toString() {
    return 'ValidationWarning.oversizedCable(message: $message, currentSection: $currentSection, recommendedSection: $recommendedSection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OversizedCableWarningImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.currentSection, currentSection) ||
                other.currentSection == currentSection) &&
            (identical(other.recommendedSection, recommendedSection) ||
                other.recommendedSection == recommendedSection));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, message, currentSection, recommendedSection);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OversizedCableWarningImplCopyWith<_$OversizedCableWarningImpl>
      get copyWith => __$$OversizedCableWarningImplCopyWithImpl<
          _$OversizedCableWarningImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String message, double currentSection, double recommendedSection)
        oversizedCable,
    required TResult Function(String message, double powerFactor)
        lowPowerFactor,
    required TResult Function(String message) general,
  }) {
    return oversizedCable(message, currentSection, recommendedSection);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String message, double currentSection, double recommendedSection)?
        oversizedCable,
    TResult? Function(String message, double powerFactor)? lowPowerFactor,
    TResult? Function(String message)? general,
  }) {
    return oversizedCable?.call(message, currentSection, recommendedSection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String message, double currentSection, double recommendedSection)?
        oversizedCable,
    TResult Function(String message, double powerFactor)? lowPowerFactor,
    TResult Function(String message)? general,
    required TResult orElse(),
  }) {
    if (oversizedCable != null) {
      return oversizedCable(message, currentSection, recommendedSection);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OversizedCableWarning value) oversizedCable,
    required TResult Function(LowPowerFactorWarning value) lowPowerFactor,
    required TResult Function(GeneralWarning value) general,
  }) {
    return oversizedCable(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OversizedCableWarning value)? oversizedCable,
    TResult? Function(LowPowerFactorWarning value)? lowPowerFactor,
    TResult? Function(GeneralWarning value)? general,
  }) {
    return oversizedCable?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OversizedCableWarning value)? oversizedCable,
    TResult Function(LowPowerFactorWarning value)? lowPowerFactor,
    TResult Function(GeneralWarning value)? general,
    required TResult orElse(),
  }) {
    if (oversizedCable != null) {
      return oversizedCable(this);
    }
    return orElse();
  }
}

abstract class OversizedCableWarning implements ValidationWarning {
  const factory OversizedCableWarning(
      {required final String message,
      required final double currentSection,
      required final double recommendedSection}) = _$OversizedCableWarningImpl;

  @override
  String get message;
  double get currentSection;
  double get recommendedSection;
  @override
  @JsonKey(ignore: true)
  _$$OversizedCableWarningImplCopyWith<_$OversizedCableWarningImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LowPowerFactorWarningImplCopyWith<$Res>
    implements $ValidationWarningCopyWith<$Res> {
  factory _$$LowPowerFactorWarningImplCopyWith(
          _$LowPowerFactorWarningImpl value,
          $Res Function(_$LowPowerFactorWarningImpl) then) =
      __$$LowPowerFactorWarningImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, double powerFactor});
}

/// @nodoc
class __$$LowPowerFactorWarningImplCopyWithImpl<$Res>
    extends _$ValidationWarningCopyWithImpl<$Res, _$LowPowerFactorWarningImpl>
    implements _$$LowPowerFactorWarningImplCopyWith<$Res> {
  __$$LowPowerFactorWarningImplCopyWithImpl(_$LowPowerFactorWarningImpl _value,
      $Res Function(_$LowPowerFactorWarningImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? powerFactor = null,
  }) {
    return _then(_$LowPowerFactorWarningImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      powerFactor: null == powerFactor
          ? _value.powerFactor
          : powerFactor // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$LowPowerFactorWarningImpl implements LowPowerFactorWarning {
  const _$LowPowerFactorWarningImpl(
      {required this.message, required this.powerFactor});

  @override
  final String message;
  @override
  final double powerFactor;

  @override
  String toString() {
    return 'ValidationWarning.lowPowerFactor(message: $message, powerFactor: $powerFactor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LowPowerFactorWarningImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.powerFactor, powerFactor) ||
                other.powerFactor == powerFactor));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, powerFactor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LowPowerFactorWarningImplCopyWith<_$LowPowerFactorWarningImpl>
      get copyWith => __$$LowPowerFactorWarningImplCopyWithImpl<
          _$LowPowerFactorWarningImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String message, double currentSection, double recommendedSection)
        oversizedCable,
    required TResult Function(String message, double powerFactor)
        lowPowerFactor,
    required TResult Function(String message) general,
  }) {
    return lowPowerFactor(message, powerFactor);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String message, double currentSection, double recommendedSection)?
        oversizedCable,
    TResult? Function(String message, double powerFactor)? lowPowerFactor,
    TResult? Function(String message)? general,
  }) {
    return lowPowerFactor?.call(message, powerFactor);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String message, double currentSection, double recommendedSection)?
        oversizedCable,
    TResult Function(String message, double powerFactor)? lowPowerFactor,
    TResult Function(String message)? general,
    required TResult orElse(),
  }) {
    if (lowPowerFactor != null) {
      return lowPowerFactor(message, powerFactor);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OversizedCableWarning value) oversizedCable,
    required TResult Function(LowPowerFactorWarning value) lowPowerFactor,
    required TResult Function(GeneralWarning value) general,
  }) {
    return lowPowerFactor(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OversizedCableWarning value)? oversizedCable,
    TResult? Function(LowPowerFactorWarning value)? lowPowerFactor,
    TResult? Function(GeneralWarning value)? general,
  }) {
    return lowPowerFactor?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OversizedCableWarning value)? oversizedCable,
    TResult Function(LowPowerFactorWarning value)? lowPowerFactor,
    TResult Function(GeneralWarning value)? general,
    required TResult orElse(),
  }) {
    if (lowPowerFactor != null) {
      return lowPowerFactor(this);
    }
    return orElse();
  }
}

abstract class LowPowerFactorWarning implements ValidationWarning {
  const factory LowPowerFactorWarning(
      {required final String message,
      required final double powerFactor}) = _$LowPowerFactorWarningImpl;

  @override
  String get message;
  double get powerFactor;
  @override
  @JsonKey(ignore: true)
  _$$LowPowerFactorWarningImplCopyWith<_$LowPowerFactorWarningImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GeneralWarningImplCopyWith<$Res>
    implements $ValidationWarningCopyWith<$Res> {
  factory _$$GeneralWarningImplCopyWith(_$GeneralWarningImpl value,
          $Res Function(_$GeneralWarningImpl) then) =
      __$$GeneralWarningImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$GeneralWarningImplCopyWithImpl<$Res>
    extends _$ValidationWarningCopyWithImpl<$Res, _$GeneralWarningImpl>
    implements _$$GeneralWarningImplCopyWith<$Res> {
  __$$GeneralWarningImplCopyWithImpl(
      _$GeneralWarningImpl _value, $Res Function(_$GeneralWarningImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$GeneralWarningImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GeneralWarningImpl implements GeneralWarning {
  const _$GeneralWarningImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'ValidationWarning.general(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeneralWarningImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GeneralWarningImplCopyWith<_$GeneralWarningImpl> get copyWith =>
      __$$GeneralWarningImplCopyWithImpl<_$GeneralWarningImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String message, double currentSection, double recommendedSection)
        oversizedCable,
    required TResult Function(String message, double powerFactor)
        lowPowerFactor,
    required TResult Function(String message) general,
  }) {
    return general(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String message, double currentSection, double recommendedSection)?
        oversizedCable,
    TResult? Function(String message, double powerFactor)? lowPowerFactor,
    TResult? Function(String message)? general,
  }) {
    return general?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String message, double currentSection, double recommendedSection)?
        oversizedCable,
    TResult Function(String message, double powerFactor)? lowPowerFactor,
    TResult Function(String message)? general,
    required TResult orElse(),
  }) {
    if (general != null) {
      return general(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OversizedCableWarning value) oversizedCable,
    required TResult Function(LowPowerFactorWarning value) lowPowerFactor,
    required TResult Function(GeneralWarning value) general,
  }) {
    return general(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OversizedCableWarning value)? oversizedCable,
    TResult? Function(LowPowerFactorWarning value)? lowPowerFactor,
    TResult? Function(GeneralWarning value)? general,
  }) {
    return general?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OversizedCableWarning value)? oversizedCable,
    TResult Function(LowPowerFactorWarning value)? lowPowerFactor,
    TResult Function(GeneralWarning value)? general,
    required TResult orElse(),
  }) {
    if (general != null) {
      return general(this);
    }
    return orElse();
  }
}

abstract class GeneralWarning implements ValidationWarning {
  const factory GeneralWarning({required final String message}) =
      _$GeneralWarningImpl;

  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$GeneralWarningImplCopyWith<_$GeneralWarningImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
