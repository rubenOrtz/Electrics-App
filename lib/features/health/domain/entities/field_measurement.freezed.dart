// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'field_measurement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FieldMeasurement _$FieldMeasurementFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'source':
      return SourceMeasurement.fromJson(json);
    case 'rcd':
      return RcdMeasurement.fromJson(json);
    case 'insulation':
      return InsulationMeasurement.fromJson(json);
    case 'load':
      return LoadMeasurement.fromJson(json);
    case 'panel':
      return PanelMeasurement.fromJson(json);
    case 'generic':
      return GenericMeasurement.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'FieldMeasurement',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$FieldMeasurement {
  String get id => throw _privateConstructorUsedError;
  String get nodeId => throw _privateConstructorUsedError;
  DateTime get measuredAt => throw _privateConstructorUsedError;
  String get measuredBy => throw _privateConstructorUsedError;
  String? get instrument => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  List<String>? get photoUrls => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? voltageLN,
            double? voltageLL,
            double? frequency,
            double? externalZe)
        source,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? tripTimeMs,
            double? tripCurrentmA,
            double? contactVoltage,
            bool? mechanicalTestPassed)
        rcd,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? resistancePhaseEarth,
            double? resistancePhaseNeutral,
            bool? continuityPE)
        insulation,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? loopImpedanceZs,
            double? voltageAtLoad,
            bool? polarityOk)
        load,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? earthResistanceRa,
            double? phaseCurrentR,
            double? phaseCurrentS,
            double? phaseCurrentT)
        panel,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? measuredVoltageLN,
            double? measuredRcdTripTime,
            double? measuredEarthResistance)
        generic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? voltageLN,
            double? voltageLL,
            double? frequency,
            double? externalZe)?
        source,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? tripTimeMs,
            double? tripCurrentmA,
            double? contactVoltage,
            bool? mechanicalTestPassed)?
        rcd,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? resistancePhaseEarth,
            double? resistancePhaseNeutral,
            bool? continuityPE)?
        insulation,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? loopImpedanceZs,
            double? voltageAtLoad,
            bool? polarityOk)?
        load,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? earthResistanceRa,
            double? phaseCurrentR,
            double? phaseCurrentS,
            double? phaseCurrentT)?
        panel,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? measuredVoltageLN,
            double? measuredRcdTripTime,
            double? measuredEarthResistance)?
        generic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? voltageLN,
            double? voltageLL,
            double? frequency,
            double? externalZe)?
        source,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? tripTimeMs,
            double? tripCurrentmA,
            double? contactVoltage,
            bool? mechanicalTestPassed)?
        rcd,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? resistancePhaseEarth,
            double? resistancePhaseNeutral,
            bool? continuityPE)?
        insulation,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? loopImpedanceZs,
            double? voltageAtLoad,
            bool? polarityOk)?
        load,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? earthResistanceRa,
            double? phaseCurrentR,
            double? phaseCurrentS,
            double? phaseCurrentT)?
        panel,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? measuredVoltageLN,
            double? measuredRcdTripTime,
            double? measuredEarthResistance)?
        generic,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SourceMeasurement value) source,
    required TResult Function(RcdMeasurement value) rcd,
    required TResult Function(InsulationMeasurement value) insulation,
    required TResult Function(LoadMeasurement value) load,
    required TResult Function(PanelMeasurement value) panel,
    required TResult Function(GenericMeasurement value) generic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SourceMeasurement value)? source,
    TResult? Function(RcdMeasurement value)? rcd,
    TResult? Function(InsulationMeasurement value)? insulation,
    TResult? Function(LoadMeasurement value)? load,
    TResult? Function(PanelMeasurement value)? panel,
    TResult? Function(GenericMeasurement value)? generic,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SourceMeasurement value)? source,
    TResult Function(RcdMeasurement value)? rcd,
    TResult Function(InsulationMeasurement value)? insulation,
    TResult Function(LoadMeasurement value)? load,
    TResult Function(PanelMeasurement value)? panel,
    TResult Function(GenericMeasurement value)? generic,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FieldMeasurementCopyWith<FieldMeasurement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FieldMeasurementCopyWith<$Res> {
  factory $FieldMeasurementCopyWith(
          FieldMeasurement value, $Res Function(FieldMeasurement) then) =
      _$FieldMeasurementCopyWithImpl<$Res, FieldMeasurement>;
  @useResult
  $Res call(
      {String id,
      String nodeId,
      DateTime measuredAt,
      String measuredBy,
      String? instrument,
      String? notes,
      List<String>? photoUrls});
}

/// @nodoc
class _$FieldMeasurementCopyWithImpl<$Res, $Val extends FieldMeasurement>
    implements $FieldMeasurementCopyWith<$Res> {
  _$FieldMeasurementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nodeId = null,
    Object? measuredAt = null,
    Object? measuredBy = null,
    Object? instrument = freezed,
    Object? notes = freezed,
    Object? photoUrls = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
      measuredAt: null == measuredAt
          ? _value.measuredAt
          : measuredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      measuredBy: null == measuredBy
          ? _value.measuredBy
          : measuredBy // ignore: cast_nullable_to_non_nullable
              as String,
      instrument: freezed == instrument
          ? _value.instrument
          : instrument // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrls: freezed == photoUrls
          ? _value.photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SourceMeasurementImplCopyWith<$Res>
    implements $FieldMeasurementCopyWith<$Res> {
  factory _$$SourceMeasurementImplCopyWith(_$SourceMeasurementImpl value,
          $Res Function(_$SourceMeasurementImpl) then) =
      __$$SourceMeasurementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String nodeId,
      DateTime measuredAt,
      String measuredBy,
      String? instrument,
      String? notes,
      List<String>? photoUrls,
      double? voltageLN,
      double? voltageLL,
      double? frequency,
      double? externalZe});
}

/// @nodoc
class __$$SourceMeasurementImplCopyWithImpl<$Res>
    extends _$FieldMeasurementCopyWithImpl<$Res, _$SourceMeasurementImpl>
    implements _$$SourceMeasurementImplCopyWith<$Res> {
  __$$SourceMeasurementImplCopyWithImpl(_$SourceMeasurementImpl _value,
      $Res Function(_$SourceMeasurementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nodeId = null,
    Object? measuredAt = null,
    Object? measuredBy = null,
    Object? instrument = freezed,
    Object? notes = freezed,
    Object? photoUrls = freezed,
    Object? voltageLN = freezed,
    Object? voltageLL = freezed,
    Object? frequency = freezed,
    Object? externalZe = freezed,
  }) {
    return _then(_$SourceMeasurementImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
      measuredAt: null == measuredAt
          ? _value.measuredAt
          : measuredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      measuredBy: null == measuredBy
          ? _value.measuredBy
          : measuredBy // ignore: cast_nullable_to_non_nullable
              as String,
      instrument: freezed == instrument
          ? _value.instrument
          : instrument // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrls: freezed == photoUrls
          ? _value._photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      voltageLN: freezed == voltageLN
          ? _value.voltageLN
          : voltageLN // ignore: cast_nullable_to_non_nullable
              as double?,
      voltageLL: freezed == voltageLL
          ? _value.voltageLL
          : voltageLL // ignore: cast_nullable_to_non_nullable
              as double?,
      frequency: freezed == frequency
          ? _value.frequency
          : frequency // ignore: cast_nullable_to_non_nullable
              as double?,
      externalZe: freezed == externalZe
          ? _value.externalZe
          : externalZe // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SourceMeasurementImpl implements SourceMeasurement {
  const _$SourceMeasurementImpl(
      {required this.id,
      required this.nodeId,
      required this.measuredAt,
      required this.measuredBy,
      this.instrument,
      this.notes,
      final List<String>? photoUrls,
      this.voltageLN,
      this.voltageLL,
      this.frequency,
      this.externalZe,
      final String? $type})
      : _photoUrls = photoUrls,
        $type = $type ?? 'source';

  factory _$SourceMeasurementImpl.fromJson(Map<String, dynamic> json) =>
      _$$SourceMeasurementImplFromJson(json);

  @override
  final String id;
  @override
  final String nodeId;
  @override
  final DateTime measuredAt;
  @override
  final String measuredBy;
  @override
  final String? instrument;
  @override
  final String? notes;
  final List<String>? _photoUrls;
  @override
  List<String>? get photoUrls {
    final value = _photoUrls;
    if (value == null) return null;
    if (_photoUrls is EqualUnmodifiableListView) return _photoUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final double? voltageLN;
// Tensión L-N
  @override
  final double? voltageLL;
// Tensión L-L
  @override
  final double? frequency;
// Hz
  @override
  final double? externalZe;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FieldMeasurement.source(id: $id, nodeId: $nodeId, measuredAt: $measuredAt, measuredBy: $measuredBy, instrument: $instrument, notes: $notes, photoUrls: $photoUrls, voltageLN: $voltageLN, voltageLL: $voltageLL, frequency: $frequency, externalZe: $externalZe)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SourceMeasurementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nodeId, nodeId) || other.nodeId == nodeId) &&
            (identical(other.measuredAt, measuredAt) ||
                other.measuredAt == measuredAt) &&
            (identical(other.measuredBy, measuredBy) ||
                other.measuredBy == measuredBy) &&
            (identical(other.instrument, instrument) ||
                other.instrument == instrument) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other._photoUrls, _photoUrls) &&
            (identical(other.voltageLN, voltageLN) ||
                other.voltageLN == voltageLN) &&
            (identical(other.voltageLL, voltageLL) ||
                other.voltageLL == voltageLL) &&
            (identical(other.frequency, frequency) ||
                other.frequency == frequency) &&
            (identical(other.externalZe, externalZe) ||
                other.externalZe == externalZe));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      nodeId,
      measuredAt,
      measuredBy,
      instrument,
      notes,
      const DeepCollectionEquality().hash(_photoUrls),
      voltageLN,
      voltageLL,
      frequency,
      externalZe);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SourceMeasurementImplCopyWith<_$SourceMeasurementImpl> get copyWith =>
      __$$SourceMeasurementImplCopyWithImpl<_$SourceMeasurementImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? voltageLN,
            double? voltageLL,
            double? frequency,
            double? externalZe)
        source,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? tripTimeMs,
            double? tripCurrentmA,
            double? contactVoltage,
            bool? mechanicalTestPassed)
        rcd,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? resistancePhaseEarth,
            double? resistancePhaseNeutral,
            bool? continuityPE)
        insulation,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? loopImpedanceZs,
            double? voltageAtLoad,
            bool? polarityOk)
        load,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? earthResistanceRa,
            double? phaseCurrentR,
            double? phaseCurrentS,
            double? phaseCurrentT)
        panel,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? measuredVoltageLN,
            double? measuredRcdTripTime,
            double? measuredEarthResistance)
        generic,
  }) {
    return source(id, nodeId, measuredAt, measuredBy, instrument, notes,
        photoUrls, voltageLN, voltageLL, frequency, externalZe);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? voltageLN,
            double? voltageLL,
            double? frequency,
            double? externalZe)?
        source,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? tripTimeMs,
            double? tripCurrentmA,
            double? contactVoltage,
            bool? mechanicalTestPassed)?
        rcd,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? resistancePhaseEarth,
            double? resistancePhaseNeutral,
            bool? continuityPE)?
        insulation,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? loopImpedanceZs,
            double? voltageAtLoad,
            bool? polarityOk)?
        load,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? earthResistanceRa,
            double? phaseCurrentR,
            double? phaseCurrentS,
            double? phaseCurrentT)?
        panel,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? measuredVoltageLN,
            double? measuredRcdTripTime,
            double? measuredEarthResistance)?
        generic,
  }) {
    return source?.call(id, nodeId, measuredAt, measuredBy, instrument, notes,
        photoUrls, voltageLN, voltageLL, frequency, externalZe);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? voltageLN,
            double? voltageLL,
            double? frequency,
            double? externalZe)?
        source,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? tripTimeMs,
            double? tripCurrentmA,
            double? contactVoltage,
            bool? mechanicalTestPassed)?
        rcd,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? resistancePhaseEarth,
            double? resistancePhaseNeutral,
            bool? continuityPE)?
        insulation,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? loopImpedanceZs,
            double? voltageAtLoad,
            bool? polarityOk)?
        load,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? earthResistanceRa,
            double? phaseCurrentR,
            double? phaseCurrentS,
            double? phaseCurrentT)?
        panel,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? measuredVoltageLN,
            double? measuredRcdTripTime,
            double? measuredEarthResistance)?
        generic,
    required TResult orElse(),
  }) {
    if (source != null) {
      return source(id, nodeId, measuredAt, measuredBy, instrument, notes,
          photoUrls, voltageLN, voltageLL, frequency, externalZe);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SourceMeasurement value) source,
    required TResult Function(RcdMeasurement value) rcd,
    required TResult Function(InsulationMeasurement value) insulation,
    required TResult Function(LoadMeasurement value) load,
    required TResult Function(PanelMeasurement value) panel,
    required TResult Function(GenericMeasurement value) generic,
  }) {
    return source(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SourceMeasurement value)? source,
    TResult? Function(RcdMeasurement value)? rcd,
    TResult? Function(InsulationMeasurement value)? insulation,
    TResult? Function(LoadMeasurement value)? load,
    TResult? Function(PanelMeasurement value)? panel,
    TResult? Function(GenericMeasurement value)? generic,
  }) {
    return source?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SourceMeasurement value)? source,
    TResult Function(RcdMeasurement value)? rcd,
    TResult Function(InsulationMeasurement value)? insulation,
    TResult Function(LoadMeasurement value)? load,
    TResult Function(PanelMeasurement value)? panel,
    TResult Function(GenericMeasurement value)? generic,
    required TResult orElse(),
  }) {
    if (source != null) {
      return source(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SourceMeasurementImplToJson(
      this,
    );
  }
}

abstract class SourceMeasurement implements FieldMeasurement {
  const factory SourceMeasurement(
      {required final String id,
      required final String nodeId,
      required final DateTime measuredAt,
      required final String measuredBy,
      final String? instrument,
      final String? notes,
      final List<String>? photoUrls,
      final double? voltageLN,
      final double? voltageLL,
      final double? frequency,
      final double? externalZe}) = _$SourceMeasurementImpl;

  factory SourceMeasurement.fromJson(Map<String, dynamic> json) =
      _$SourceMeasurementImpl.fromJson;

  @override
  String get id;
  @override
  String get nodeId;
  @override
  DateTime get measuredAt;
  @override
  String get measuredBy;
  @override
  String? get instrument;
  @override
  String? get notes;
  @override
  List<String>? get photoUrls;
  double? get voltageLN; // Tensión L-N
  double? get voltageLL; // Tensión L-L
  double? get frequency; // Hz
  double? get externalZe;
  @override
  @JsonKey(ignore: true)
  _$$SourceMeasurementImplCopyWith<_$SourceMeasurementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RcdMeasurementImplCopyWith<$Res>
    implements $FieldMeasurementCopyWith<$Res> {
  factory _$$RcdMeasurementImplCopyWith(_$RcdMeasurementImpl value,
          $Res Function(_$RcdMeasurementImpl) then) =
      __$$RcdMeasurementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String nodeId,
      DateTime measuredAt,
      String measuredBy,
      String? instrument,
      String? notes,
      List<String>? photoUrls,
      double? tripTimeMs,
      double? tripCurrentmA,
      double? contactVoltage,
      bool? mechanicalTestPassed});
}

/// @nodoc
class __$$RcdMeasurementImplCopyWithImpl<$Res>
    extends _$FieldMeasurementCopyWithImpl<$Res, _$RcdMeasurementImpl>
    implements _$$RcdMeasurementImplCopyWith<$Res> {
  __$$RcdMeasurementImplCopyWithImpl(
      _$RcdMeasurementImpl _value, $Res Function(_$RcdMeasurementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nodeId = null,
    Object? measuredAt = null,
    Object? measuredBy = null,
    Object? instrument = freezed,
    Object? notes = freezed,
    Object? photoUrls = freezed,
    Object? tripTimeMs = freezed,
    Object? tripCurrentmA = freezed,
    Object? contactVoltage = freezed,
    Object? mechanicalTestPassed = freezed,
  }) {
    return _then(_$RcdMeasurementImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
      measuredAt: null == measuredAt
          ? _value.measuredAt
          : measuredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      measuredBy: null == measuredBy
          ? _value.measuredBy
          : measuredBy // ignore: cast_nullable_to_non_nullable
              as String,
      instrument: freezed == instrument
          ? _value.instrument
          : instrument // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrls: freezed == photoUrls
          ? _value._photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      tripTimeMs: freezed == tripTimeMs
          ? _value.tripTimeMs
          : tripTimeMs // ignore: cast_nullable_to_non_nullable
              as double?,
      tripCurrentmA: freezed == tripCurrentmA
          ? _value.tripCurrentmA
          : tripCurrentmA // ignore: cast_nullable_to_non_nullable
              as double?,
      contactVoltage: freezed == contactVoltage
          ? _value.contactVoltage
          : contactVoltage // ignore: cast_nullable_to_non_nullable
              as double?,
      mechanicalTestPassed: freezed == mechanicalTestPassed
          ? _value.mechanicalTestPassed
          : mechanicalTestPassed // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RcdMeasurementImpl implements RcdMeasurement {
  const _$RcdMeasurementImpl(
      {required this.id,
      required this.nodeId,
      required this.measuredAt,
      required this.measuredBy,
      this.instrument,
      this.notes,
      final List<String>? photoUrls,
      this.tripTimeMs,
      this.tripCurrentmA,
      this.contactVoltage,
      this.mechanicalTestPassed,
      final String? $type})
      : _photoUrls = photoUrls,
        $type = $type ?? 'rcd';

  factory _$RcdMeasurementImpl.fromJson(Map<String, dynamic> json) =>
      _$$RcdMeasurementImplFromJson(json);

  @override
  final String id;
  @override
  final String nodeId;
  @override
  final DateTime measuredAt;
  @override
  final String measuredBy;
  @override
  final String? instrument;
  @override
  final String? notes;
  final List<String>? _photoUrls;
  @override
  List<String>? get photoUrls {
    final value = _photoUrls;
    if (value == null) return null;
    if (_photoUrls is EqualUnmodifiableListView) return _photoUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final double? tripTimeMs;
// Tiempo disparo (ms)
  @override
  final double? tripCurrentmA;
// Corriente disparo (mA)
  @override
  final double? contactVoltage;
// Tensión de contacto (V)
  @override
  final bool? mechanicalTestPassed;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FieldMeasurement.rcd(id: $id, nodeId: $nodeId, measuredAt: $measuredAt, measuredBy: $measuredBy, instrument: $instrument, notes: $notes, photoUrls: $photoUrls, tripTimeMs: $tripTimeMs, tripCurrentmA: $tripCurrentmA, contactVoltage: $contactVoltage, mechanicalTestPassed: $mechanicalTestPassed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RcdMeasurementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nodeId, nodeId) || other.nodeId == nodeId) &&
            (identical(other.measuredAt, measuredAt) ||
                other.measuredAt == measuredAt) &&
            (identical(other.measuredBy, measuredBy) ||
                other.measuredBy == measuredBy) &&
            (identical(other.instrument, instrument) ||
                other.instrument == instrument) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other._photoUrls, _photoUrls) &&
            (identical(other.tripTimeMs, tripTimeMs) ||
                other.tripTimeMs == tripTimeMs) &&
            (identical(other.tripCurrentmA, tripCurrentmA) ||
                other.tripCurrentmA == tripCurrentmA) &&
            (identical(other.contactVoltage, contactVoltage) ||
                other.contactVoltage == contactVoltage) &&
            (identical(other.mechanicalTestPassed, mechanicalTestPassed) ||
                other.mechanicalTestPassed == mechanicalTestPassed));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      nodeId,
      measuredAt,
      measuredBy,
      instrument,
      notes,
      const DeepCollectionEquality().hash(_photoUrls),
      tripTimeMs,
      tripCurrentmA,
      contactVoltage,
      mechanicalTestPassed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RcdMeasurementImplCopyWith<_$RcdMeasurementImpl> get copyWith =>
      __$$RcdMeasurementImplCopyWithImpl<_$RcdMeasurementImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? voltageLN,
            double? voltageLL,
            double? frequency,
            double? externalZe)
        source,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? tripTimeMs,
            double? tripCurrentmA,
            double? contactVoltage,
            bool? mechanicalTestPassed)
        rcd,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? resistancePhaseEarth,
            double? resistancePhaseNeutral,
            bool? continuityPE)
        insulation,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? loopImpedanceZs,
            double? voltageAtLoad,
            bool? polarityOk)
        load,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? earthResistanceRa,
            double? phaseCurrentR,
            double? phaseCurrentS,
            double? phaseCurrentT)
        panel,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? measuredVoltageLN,
            double? measuredRcdTripTime,
            double? measuredEarthResistance)
        generic,
  }) {
    return rcd(id, nodeId, measuredAt, measuredBy, instrument, notes, photoUrls,
        tripTimeMs, tripCurrentmA, contactVoltage, mechanicalTestPassed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? voltageLN,
            double? voltageLL,
            double? frequency,
            double? externalZe)?
        source,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? tripTimeMs,
            double? tripCurrentmA,
            double? contactVoltage,
            bool? mechanicalTestPassed)?
        rcd,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? resistancePhaseEarth,
            double? resistancePhaseNeutral,
            bool? continuityPE)?
        insulation,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? loopImpedanceZs,
            double? voltageAtLoad,
            bool? polarityOk)?
        load,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? earthResistanceRa,
            double? phaseCurrentR,
            double? phaseCurrentS,
            double? phaseCurrentT)?
        panel,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? measuredVoltageLN,
            double? measuredRcdTripTime,
            double? measuredEarthResistance)?
        generic,
  }) {
    return rcd?.call(
        id,
        nodeId,
        measuredAt,
        measuredBy,
        instrument,
        notes,
        photoUrls,
        tripTimeMs,
        tripCurrentmA,
        contactVoltage,
        mechanicalTestPassed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? voltageLN,
            double? voltageLL,
            double? frequency,
            double? externalZe)?
        source,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? tripTimeMs,
            double? tripCurrentmA,
            double? contactVoltage,
            bool? mechanicalTestPassed)?
        rcd,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? resistancePhaseEarth,
            double? resistancePhaseNeutral,
            bool? continuityPE)?
        insulation,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? loopImpedanceZs,
            double? voltageAtLoad,
            bool? polarityOk)?
        load,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? earthResistanceRa,
            double? phaseCurrentR,
            double? phaseCurrentS,
            double? phaseCurrentT)?
        panel,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? measuredVoltageLN,
            double? measuredRcdTripTime,
            double? measuredEarthResistance)?
        generic,
    required TResult orElse(),
  }) {
    if (rcd != null) {
      return rcd(
          id,
          nodeId,
          measuredAt,
          measuredBy,
          instrument,
          notes,
          photoUrls,
          tripTimeMs,
          tripCurrentmA,
          contactVoltage,
          mechanicalTestPassed);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SourceMeasurement value) source,
    required TResult Function(RcdMeasurement value) rcd,
    required TResult Function(InsulationMeasurement value) insulation,
    required TResult Function(LoadMeasurement value) load,
    required TResult Function(PanelMeasurement value) panel,
    required TResult Function(GenericMeasurement value) generic,
  }) {
    return rcd(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SourceMeasurement value)? source,
    TResult? Function(RcdMeasurement value)? rcd,
    TResult? Function(InsulationMeasurement value)? insulation,
    TResult? Function(LoadMeasurement value)? load,
    TResult? Function(PanelMeasurement value)? panel,
    TResult? Function(GenericMeasurement value)? generic,
  }) {
    return rcd?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SourceMeasurement value)? source,
    TResult Function(RcdMeasurement value)? rcd,
    TResult Function(InsulationMeasurement value)? insulation,
    TResult Function(LoadMeasurement value)? load,
    TResult Function(PanelMeasurement value)? panel,
    TResult Function(GenericMeasurement value)? generic,
    required TResult orElse(),
  }) {
    if (rcd != null) {
      return rcd(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RcdMeasurementImplToJson(
      this,
    );
  }
}

abstract class RcdMeasurement implements FieldMeasurement {
  const factory RcdMeasurement(
      {required final String id,
      required final String nodeId,
      required final DateTime measuredAt,
      required final String measuredBy,
      final String? instrument,
      final String? notes,
      final List<String>? photoUrls,
      final double? tripTimeMs,
      final double? tripCurrentmA,
      final double? contactVoltage,
      final bool? mechanicalTestPassed}) = _$RcdMeasurementImpl;

  factory RcdMeasurement.fromJson(Map<String, dynamic> json) =
      _$RcdMeasurementImpl.fromJson;

  @override
  String get id;
  @override
  String get nodeId;
  @override
  DateTime get measuredAt;
  @override
  String get measuredBy;
  @override
  String? get instrument;
  @override
  String? get notes;
  @override
  List<String>? get photoUrls;
  double? get tripTimeMs; // Tiempo disparo (ms)
  double? get tripCurrentmA; // Corriente disparo (mA)
  double? get contactVoltage; // Tensión de contacto (V)
  bool? get mechanicalTestPassed;
  @override
  @JsonKey(ignore: true)
  _$$RcdMeasurementImplCopyWith<_$RcdMeasurementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InsulationMeasurementImplCopyWith<$Res>
    implements $FieldMeasurementCopyWith<$Res> {
  factory _$$InsulationMeasurementImplCopyWith(
          _$InsulationMeasurementImpl value,
          $Res Function(_$InsulationMeasurementImpl) then) =
      __$$InsulationMeasurementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String nodeId,
      DateTime measuredAt,
      String measuredBy,
      String? instrument,
      String? notes,
      List<String>? photoUrls,
      double? resistancePhaseEarth,
      double? resistancePhaseNeutral,
      bool? continuityPE});
}

/// @nodoc
class __$$InsulationMeasurementImplCopyWithImpl<$Res>
    extends _$FieldMeasurementCopyWithImpl<$Res, _$InsulationMeasurementImpl>
    implements _$$InsulationMeasurementImplCopyWith<$Res> {
  __$$InsulationMeasurementImplCopyWithImpl(_$InsulationMeasurementImpl _value,
      $Res Function(_$InsulationMeasurementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nodeId = null,
    Object? measuredAt = null,
    Object? measuredBy = null,
    Object? instrument = freezed,
    Object? notes = freezed,
    Object? photoUrls = freezed,
    Object? resistancePhaseEarth = freezed,
    Object? resistancePhaseNeutral = freezed,
    Object? continuityPE = freezed,
  }) {
    return _then(_$InsulationMeasurementImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
      measuredAt: null == measuredAt
          ? _value.measuredAt
          : measuredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      measuredBy: null == measuredBy
          ? _value.measuredBy
          : measuredBy // ignore: cast_nullable_to_non_nullable
              as String,
      instrument: freezed == instrument
          ? _value.instrument
          : instrument // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrls: freezed == photoUrls
          ? _value._photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      resistancePhaseEarth: freezed == resistancePhaseEarth
          ? _value.resistancePhaseEarth
          : resistancePhaseEarth // ignore: cast_nullable_to_non_nullable
              as double?,
      resistancePhaseNeutral: freezed == resistancePhaseNeutral
          ? _value.resistancePhaseNeutral
          : resistancePhaseNeutral // ignore: cast_nullable_to_non_nullable
              as double?,
      continuityPE: freezed == continuityPE
          ? _value.continuityPE
          : continuityPE // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InsulationMeasurementImpl implements InsulationMeasurement {
  const _$InsulationMeasurementImpl(
      {required this.id,
      required this.nodeId,
      required this.measuredAt,
      required this.measuredBy,
      this.instrument,
      this.notes,
      final List<String>? photoUrls,
      this.resistancePhaseEarth,
      this.resistancePhaseNeutral,
      this.continuityPE,
      final String? $type})
      : _photoUrls = photoUrls,
        $type = $type ?? 'insulation';

  factory _$InsulationMeasurementImpl.fromJson(Map<String, dynamic> json) =>
      _$$InsulationMeasurementImplFromJson(json);

  @override
  final String id;
  @override
  final String nodeId;
  @override
  final DateTime measuredAt;
  @override
  final String measuredBy;
  @override
  final String? instrument;
  @override
  final String? notes;
  final List<String>? _photoUrls;
  @override
  List<String>? get photoUrls {
    final value = _photoUrls;
    if (value == null) return null;
    if (_photoUrls is EqualUnmodifiableListView) return _photoUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final double? resistancePhaseEarth;
// R(L-PE) MΩ
  @override
  final double? resistancePhaseNeutral;
// R(L-N) MΩ
  @override
  final bool? continuityPE;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FieldMeasurement.insulation(id: $id, nodeId: $nodeId, measuredAt: $measuredAt, measuredBy: $measuredBy, instrument: $instrument, notes: $notes, photoUrls: $photoUrls, resistancePhaseEarth: $resistancePhaseEarth, resistancePhaseNeutral: $resistancePhaseNeutral, continuityPE: $continuityPE)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsulationMeasurementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nodeId, nodeId) || other.nodeId == nodeId) &&
            (identical(other.measuredAt, measuredAt) ||
                other.measuredAt == measuredAt) &&
            (identical(other.measuredBy, measuredBy) ||
                other.measuredBy == measuredBy) &&
            (identical(other.instrument, instrument) ||
                other.instrument == instrument) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other._photoUrls, _photoUrls) &&
            (identical(other.resistancePhaseEarth, resistancePhaseEarth) ||
                other.resistancePhaseEarth == resistancePhaseEarth) &&
            (identical(other.resistancePhaseNeutral, resistancePhaseNeutral) ||
                other.resistancePhaseNeutral == resistancePhaseNeutral) &&
            (identical(other.continuityPE, continuityPE) ||
                other.continuityPE == continuityPE));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      nodeId,
      measuredAt,
      measuredBy,
      instrument,
      notes,
      const DeepCollectionEquality().hash(_photoUrls),
      resistancePhaseEarth,
      resistancePhaseNeutral,
      continuityPE);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InsulationMeasurementImplCopyWith<_$InsulationMeasurementImpl>
      get copyWith => __$$InsulationMeasurementImplCopyWithImpl<
          _$InsulationMeasurementImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? voltageLN,
            double? voltageLL,
            double? frequency,
            double? externalZe)
        source,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? tripTimeMs,
            double? tripCurrentmA,
            double? contactVoltage,
            bool? mechanicalTestPassed)
        rcd,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? resistancePhaseEarth,
            double? resistancePhaseNeutral,
            bool? continuityPE)
        insulation,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? loopImpedanceZs,
            double? voltageAtLoad,
            bool? polarityOk)
        load,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? earthResistanceRa,
            double? phaseCurrentR,
            double? phaseCurrentS,
            double? phaseCurrentT)
        panel,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? measuredVoltageLN,
            double? measuredRcdTripTime,
            double? measuredEarthResistance)
        generic,
  }) {
    return insulation(id, nodeId, measuredAt, measuredBy, instrument, notes,
        photoUrls, resistancePhaseEarth, resistancePhaseNeutral, continuityPE);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? voltageLN,
            double? voltageLL,
            double? frequency,
            double? externalZe)?
        source,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? tripTimeMs,
            double? tripCurrentmA,
            double? contactVoltage,
            bool? mechanicalTestPassed)?
        rcd,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? resistancePhaseEarth,
            double? resistancePhaseNeutral,
            bool? continuityPE)?
        insulation,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? loopImpedanceZs,
            double? voltageAtLoad,
            bool? polarityOk)?
        load,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? earthResistanceRa,
            double? phaseCurrentR,
            double? phaseCurrentS,
            double? phaseCurrentT)?
        panel,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? measuredVoltageLN,
            double? measuredRcdTripTime,
            double? measuredEarthResistance)?
        generic,
  }) {
    return insulation?.call(
        id,
        nodeId,
        measuredAt,
        measuredBy,
        instrument,
        notes,
        photoUrls,
        resistancePhaseEarth,
        resistancePhaseNeutral,
        continuityPE);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? voltageLN,
            double? voltageLL,
            double? frequency,
            double? externalZe)?
        source,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? tripTimeMs,
            double? tripCurrentmA,
            double? contactVoltage,
            bool? mechanicalTestPassed)?
        rcd,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? resistancePhaseEarth,
            double? resistancePhaseNeutral,
            bool? continuityPE)?
        insulation,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? loopImpedanceZs,
            double? voltageAtLoad,
            bool? polarityOk)?
        load,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? earthResistanceRa,
            double? phaseCurrentR,
            double? phaseCurrentS,
            double? phaseCurrentT)?
        panel,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? measuredVoltageLN,
            double? measuredRcdTripTime,
            double? measuredEarthResistance)?
        generic,
    required TResult orElse(),
  }) {
    if (insulation != null) {
      return insulation(
          id,
          nodeId,
          measuredAt,
          measuredBy,
          instrument,
          notes,
          photoUrls,
          resistancePhaseEarth,
          resistancePhaseNeutral,
          continuityPE);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SourceMeasurement value) source,
    required TResult Function(RcdMeasurement value) rcd,
    required TResult Function(InsulationMeasurement value) insulation,
    required TResult Function(LoadMeasurement value) load,
    required TResult Function(PanelMeasurement value) panel,
    required TResult Function(GenericMeasurement value) generic,
  }) {
    return insulation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SourceMeasurement value)? source,
    TResult? Function(RcdMeasurement value)? rcd,
    TResult? Function(InsulationMeasurement value)? insulation,
    TResult? Function(LoadMeasurement value)? load,
    TResult? Function(PanelMeasurement value)? panel,
    TResult? Function(GenericMeasurement value)? generic,
  }) {
    return insulation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SourceMeasurement value)? source,
    TResult Function(RcdMeasurement value)? rcd,
    TResult Function(InsulationMeasurement value)? insulation,
    TResult Function(LoadMeasurement value)? load,
    TResult Function(PanelMeasurement value)? panel,
    TResult Function(GenericMeasurement value)? generic,
    required TResult orElse(),
  }) {
    if (insulation != null) {
      return insulation(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InsulationMeasurementImplToJson(
      this,
    );
  }
}

abstract class InsulationMeasurement implements FieldMeasurement {
  const factory InsulationMeasurement(
      {required final String id,
      required final String nodeId,
      required final DateTime measuredAt,
      required final String measuredBy,
      final String? instrument,
      final String? notes,
      final List<String>? photoUrls,
      final double? resistancePhaseEarth,
      final double? resistancePhaseNeutral,
      final bool? continuityPE}) = _$InsulationMeasurementImpl;

  factory InsulationMeasurement.fromJson(Map<String, dynamic> json) =
      _$InsulationMeasurementImpl.fromJson;

  @override
  String get id;
  @override
  String get nodeId;
  @override
  DateTime get measuredAt;
  @override
  String get measuredBy;
  @override
  String? get instrument;
  @override
  String? get notes;
  @override
  List<String>? get photoUrls;
  double? get resistancePhaseEarth; // R(L-PE) MΩ
  double? get resistancePhaseNeutral; // R(L-N) MΩ
  bool? get continuityPE;
  @override
  @JsonKey(ignore: true)
  _$$InsulationMeasurementImplCopyWith<_$InsulationMeasurementImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadMeasurementImplCopyWith<$Res>
    implements $FieldMeasurementCopyWith<$Res> {
  factory _$$LoadMeasurementImplCopyWith(_$LoadMeasurementImpl value,
          $Res Function(_$LoadMeasurementImpl) then) =
      __$$LoadMeasurementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String nodeId,
      DateTime measuredAt,
      String measuredBy,
      String? instrument,
      String? notes,
      List<String>? photoUrls,
      double? loopImpedanceZs,
      double? voltageAtLoad,
      bool? polarityOk});
}

/// @nodoc
class __$$LoadMeasurementImplCopyWithImpl<$Res>
    extends _$FieldMeasurementCopyWithImpl<$Res, _$LoadMeasurementImpl>
    implements _$$LoadMeasurementImplCopyWith<$Res> {
  __$$LoadMeasurementImplCopyWithImpl(
      _$LoadMeasurementImpl _value, $Res Function(_$LoadMeasurementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nodeId = null,
    Object? measuredAt = null,
    Object? measuredBy = null,
    Object? instrument = freezed,
    Object? notes = freezed,
    Object? photoUrls = freezed,
    Object? loopImpedanceZs = freezed,
    Object? voltageAtLoad = freezed,
    Object? polarityOk = freezed,
  }) {
    return _then(_$LoadMeasurementImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
      measuredAt: null == measuredAt
          ? _value.measuredAt
          : measuredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      measuredBy: null == measuredBy
          ? _value.measuredBy
          : measuredBy // ignore: cast_nullable_to_non_nullable
              as String,
      instrument: freezed == instrument
          ? _value.instrument
          : instrument // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrls: freezed == photoUrls
          ? _value._photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      loopImpedanceZs: freezed == loopImpedanceZs
          ? _value.loopImpedanceZs
          : loopImpedanceZs // ignore: cast_nullable_to_non_nullable
              as double?,
      voltageAtLoad: freezed == voltageAtLoad
          ? _value.voltageAtLoad
          : voltageAtLoad // ignore: cast_nullable_to_non_nullable
              as double?,
      polarityOk: freezed == polarityOk
          ? _value.polarityOk
          : polarityOk // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoadMeasurementImpl implements LoadMeasurement {
  const _$LoadMeasurementImpl(
      {required this.id,
      required this.nodeId,
      required this.measuredAt,
      required this.measuredBy,
      this.instrument,
      this.notes,
      final List<String>? photoUrls,
      this.loopImpedanceZs,
      this.voltageAtLoad,
      this.polarityOk,
      final String? $type})
      : _photoUrls = photoUrls,
        $type = $type ?? 'load';

  factory _$LoadMeasurementImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoadMeasurementImplFromJson(json);

  @override
  final String id;
  @override
  final String nodeId;
  @override
  final DateTime measuredAt;
  @override
  final String measuredBy;
  @override
  final String? instrument;
  @override
  final String? notes;
  final List<String>? _photoUrls;
  @override
  List<String>? get photoUrls {
    final value = _photoUrls;
    if (value == null) return null;
    if (_photoUrls is EqualUnmodifiableListView) return _photoUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final double? loopImpedanceZs;
// Zs medida
  @override
  final double? voltageAtLoad;
// Caída de tensión check
  @override
  final bool? polarityOk;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FieldMeasurement.load(id: $id, nodeId: $nodeId, measuredAt: $measuredAt, measuredBy: $measuredBy, instrument: $instrument, notes: $notes, photoUrls: $photoUrls, loopImpedanceZs: $loopImpedanceZs, voltageAtLoad: $voltageAtLoad, polarityOk: $polarityOk)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadMeasurementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nodeId, nodeId) || other.nodeId == nodeId) &&
            (identical(other.measuredAt, measuredAt) ||
                other.measuredAt == measuredAt) &&
            (identical(other.measuredBy, measuredBy) ||
                other.measuredBy == measuredBy) &&
            (identical(other.instrument, instrument) ||
                other.instrument == instrument) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other._photoUrls, _photoUrls) &&
            (identical(other.loopImpedanceZs, loopImpedanceZs) ||
                other.loopImpedanceZs == loopImpedanceZs) &&
            (identical(other.voltageAtLoad, voltageAtLoad) ||
                other.voltageAtLoad == voltageAtLoad) &&
            (identical(other.polarityOk, polarityOk) ||
                other.polarityOk == polarityOk));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      nodeId,
      measuredAt,
      measuredBy,
      instrument,
      notes,
      const DeepCollectionEquality().hash(_photoUrls),
      loopImpedanceZs,
      voltageAtLoad,
      polarityOk);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadMeasurementImplCopyWith<_$LoadMeasurementImpl> get copyWith =>
      __$$LoadMeasurementImplCopyWithImpl<_$LoadMeasurementImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? voltageLN,
            double? voltageLL,
            double? frequency,
            double? externalZe)
        source,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? tripTimeMs,
            double? tripCurrentmA,
            double? contactVoltage,
            bool? mechanicalTestPassed)
        rcd,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? resistancePhaseEarth,
            double? resistancePhaseNeutral,
            bool? continuityPE)
        insulation,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? loopImpedanceZs,
            double? voltageAtLoad,
            bool? polarityOk)
        load,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? earthResistanceRa,
            double? phaseCurrentR,
            double? phaseCurrentS,
            double? phaseCurrentT)
        panel,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? measuredVoltageLN,
            double? measuredRcdTripTime,
            double? measuredEarthResistance)
        generic,
  }) {
    return load(id, nodeId, measuredAt, measuredBy, instrument, notes,
        photoUrls, loopImpedanceZs, voltageAtLoad, polarityOk);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? voltageLN,
            double? voltageLL,
            double? frequency,
            double? externalZe)?
        source,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? tripTimeMs,
            double? tripCurrentmA,
            double? contactVoltage,
            bool? mechanicalTestPassed)?
        rcd,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? resistancePhaseEarth,
            double? resistancePhaseNeutral,
            bool? continuityPE)?
        insulation,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? loopImpedanceZs,
            double? voltageAtLoad,
            bool? polarityOk)?
        load,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? earthResistanceRa,
            double? phaseCurrentR,
            double? phaseCurrentS,
            double? phaseCurrentT)?
        panel,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? measuredVoltageLN,
            double? measuredRcdTripTime,
            double? measuredEarthResistance)?
        generic,
  }) {
    return load?.call(id, nodeId, measuredAt, measuredBy, instrument, notes,
        photoUrls, loopImpedanceZs, voltageAtLoad, polarityOk);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? voltageLN,
            double? voltageLL,
            double? frequency,
            double? externalZe)?
        source,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? tripTimeMs,
            double? tripCurrentmA,
            double? contactVoltage,
            bool? mechanicalTestPassed)?
        rcd,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? resistancePhaseEarth,
            double? resistancePhaseNeutral,
            bool? continuityPE)?
        insulation,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? loopImpedanceZs,
            double? voltageAtLoad,
            bool? polarityOk)?
        load,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? earthResistanceRa,
            double? phaseCurrentR,
            double? phaseCurrentS,
            double? phaseCurrentT)?
        panel,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? measuredVoltageLN,
            double? measuredRcdTripTime,
            double? measuredEarthResistance)?
        generic,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(id, nodeId, measuredAt, measuredBy, instrument, notes,
          photoUrls, loopImpedanceZs, voltageAtLoad, polarityOk);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SourceMeasurement value) source,
    required TResult Function(RcdMeasurement value) rcd,
    required TResult Function(InsulationMeasurement value) insulation,
    required TResult Function(LoadMeasurement value) load,
    required TResult Function(PanelMeasurement value) panel,
    required TResult Function(GenericMeasurement value) generic,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SourceMeasurement value)? source,
    TResult? Function(RcdMeasurement value)? rcd,
    TResult? Function(InsulationMeasurement value)? insulation,
    TResult? Function(LoadMeasurement value)? load,
    TResult? Function(PanelMeasurement value)? panel,
    TResult? Function(GenericMeasurement value)? generic,
  }) {
    return load?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SourceMeasurement value)? source,
    TResult Function(RcdMeasurement value)? rcd,
    TResult Function(InsulationMeasurement value)? insulation,
    TResult Function(LoadMeasurement value)? load,
    TResult Function(PanelMeasurement value)? panel,
    TResult Function(GenericMeasurement value)? generic,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LoadMeasurementImplToJson(
      this,
    );
  }
}

abstract class LoadMeasurement implements FieldMeasurement {
  const factory LoadMeasurement(
      {required final String id,
      required final String nodeId,
      required final DateTime measuredAt,
      required final String measuredBy,
      final String? instrument,
      final String? notes,
      final List<String>? photoUrls,
      final double? loopImpedanceZs,
      final double? voltageAtLoad,
      final bool? polarityOk}) = _$LoadMeasurementImpl;

  factory LoadMeasurement.fromJson(Map<String, dynamic> json) =
      _$LoadMeasurementImpl.fromJson;

  @override
  String get id;
  @override
  String get nodeId;
  @override
  DateTime get measuredAt;
  @override
  String get measuredBy;
  @override
  String? get instrument;
  @override
  String? get notes;
  @override
  List<String>? get photoUrls;
  double? get loopImpedanceZs; // Zs medida
  double? get voltageAtLoad; // Caída de tensión check
  bool? get polarityOk;
  @override
  @JsonKey(ignore: true)
  _$$LoadMeasurementImplCopyWith<_$LoadMeasurementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PanelMeasurementImplCopyWith<$Res>
    implements $FieldMeasurementCopyWith<$Res> {
  factory _$$PanelMeasurementImplCopyWith(_$PanelMeasurementImpl value,
          $Res Function(_$PanelMeasurementImpl) then) =
      __$$PanelMeasurementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String nodeId,
      DateTime measuredAt,
      String measuredBy,
      String? instrument,
      String? notes,
      List<String>? photoUrls,
      double? earthResistanceRa,
      double? phaseCurrentR,
      double? phaseCurrentS,
      double? phaseCurrentT});
}

/// @nodoc
class __$$PanelMeasurementImplCopyWithImpl<$Res>
    extends _$FieldMeasurementCopyWithImpl<$Res, _$PanelMeasurementImpl>
    implements _$$PanelMeasurementImplCopyWith<$Res> {
  __$$PanelMeasurementImplCopyWithImpl(_$PanelMeasurementImpl _value,
      $Res Function(_$PanelMeasurementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nodeId = null,
    Object? measuredAt = null,
    Object? measuredBy = null,
    Object? instrument = freezed,
    Object? notes = freezed,
    Object? photoUrls = freezed,
    Object? earthResistanceRa = freezed,
    Object? phaseCurrentR = freezed,
    Object? phaseCurrentS = freezed,
    Object? phaseCurrentT = freezed,
  }) {
    return _then(_$PanelMeasurementImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
      measuredAt: null == measuredAt
          ? _value.measuredAt
          : measuredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      measuredBy: null == measuredBy
          ? _value.measuredBy
          : measuredBy // ignore: cast_nullable_to_non_nullable
              as String,
      instrument: freezed == instrument
          ? _value.instrument
          : instrument // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrls: freezed == photoUrls
          ? _value._photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      earthResistanceRa: freezed == earthResistanceRa
          ? _value.earthResistanceRa
          : earthResistanceRa // ignore: cast_nullable_to_non_nullable
              as double?,
      phaseCurrentR: freezed == phaseCurrentR
          ? _value.phaseCurrentR
          : phaseCurrentR // ignore: cast_nullable_to_non_nullable
              as double?,
      phaseCurrentS: freezed == phaseCurrentS
          ? _value.phaseCurrentS
          : phaseCurrentS // ignore: cast_nullable_to_non_nullable
              as double?,
      phaseCurrentT: freezed == phaseCurrentT
          ? _value.phaseCurrentT
          : phaseCurrentT // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PanelMeasurementImpl implements PanelMeasurement {
  const _$PanelMeasurementImpl(
      {required this.id,
      required this.nodeId,
      required this.measuredAt,
      required this.measuredBy,
      this.instrument,
      this.notes,
      final List<String>? photoUrls,
      this.earthResistanceRa,
      this.phaseCurrentR,
      this.phaseCurrentS,
      this.phaseCurrentT,
      final String? $type})
      : _photoUrls = photoUrls,
        $type = $type ?? 'panel';

  factory _$PanelMeasurementImpl.fromJson(Map<String, dynamic> json) =>
      _$$PanelMeasurementImplFromJson(json);

  @override
  final String id;
  @override
  final String nodeId;
  @override
  final DateTime measuredAt;
  @override
  final String measuredBy;
  @override
  final String? instrument;
  @override
  final String? notes;
  final List<String>? _photoUrls;
  @override
  List<String>? get photoUrls {
    final value = _photoUrls;
    if (value == null) return null;
    if (_photoUrls is EqualUnmodifiableListView) return _photoUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final double? earthResistanceRa;
// Resistencia Tierra (Ra)
  @override
  final double? phaseCurrentR;
// Consumo Fase R
  @override
  final double? phaseCurrentS;
// Consumo Fase S
  @override
  final double? phaseCurrentT;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FieldMeasurement.panel(id: $id, nodeId: $nodeId, measuredAt: $measuredAt, measuredBy: $measuredBy, instrument: $instrument, notes: $notes, photoUrls: $photoUrls, earthResistanceRa: $earthResistanceRa, phaseCurrentR: $phaseCurrentR, phaseCurrentS: $phaseCurrentS, phaseCurrentT: $phaseCurrentT)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PanelMeasurementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nodeId, nodeId) || other.nodeId == nodeId) &&
            (identical(other.measuredAt, measuredAt) ||
                other.measuredAt == measuredAt) &&
            (identical(other.measuredBy, measuredBy) ||
                other.measuredBy == measuredBy) &&
            (identical(other.instrument, instrument) ||
                other.instrument == instrument) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other._photoUrls, _photoUrls) &&
            (identical(other.earthResistanceRa, earthResistanceRa) ||
                other.earthResistanceRa == earthResistanceRa) &&
            (identical(other.phaseCurrentR, phaseCurrentR) ||
                other.phaseCurrentR == phaseCurrentR) &&
            (identical(other.phaseCurrentS, phaseCurrentS) ||
                other.phaseCurrentS == phaseCurrentS) &&
            (identical(other.phaseCurrentT, phaseCurrentT) ||
                other.phaseCurrentT == phaseCurrentT));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      nodeId,
      measuredAt,
      measuredBy,
      instrument,
      notes,
      const DeepCollectionEquality().hash(_photoUrls),
      earthResistanceRa,
      phaseCurrentR,
      phaseCurrentS,
      phaseCurrentT);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PanelMeasurementImplCopyWith<_$PanelMeasurementImpl> get copyWith =>
      __$$PanelMeasurementImplCopyWithImpl<_$PanelMeasurementImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? voltageLN,
            double? voltageLL,
            double? frequency,
            double? externalZe)
        source,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? tripTimeMs,
            double? tripCurrentmA,
            double? contactVoltage,
            bool? mechanicalTestPassed)
        rcd,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? resistancePhaseEarth,
            double? resistancePhaseNeutral,
            bool? continuityPE)
        insulation,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? loopImpedanceZs,
            double? voltageAtLoad,
            bool? polarityOk)
        load,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? earthResistanceRa,
            double? phaseCurrentR,
            double? phaseCurrentS,
            double? phaseCurrentT)
        panel,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? measuredVoltageLN,
            double? measuredRcdTripTime,
            double? measuredEarthResistance)
        generic,
  }) {
    return panel(
        id,
        nodeId,
        measuredAt,
        measuredBy,
        instrument,
        notes,
        photoUrls,
        earthResistanceRa,
        phaseCurrentR,
        phaseCurrentS,
        phaseCurrentT);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? voltageLN,
            double? voltageLL,
            double? frequency,
            double? externalZe)?
        source,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? tripTimeMs,
            double? tripCurrentmA,
            double? contactVoltage,
            bool? mechanicalTestPassed)?
        rcd,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? resistancePhaseEarth,
            double? resistancePhaseNeutral,
            bool? continuityPE)?
        insulation,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? loopImpedanceZs,
            double? voltageAtLoad,
            bool? polarityOk)?
        load,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? earthResistanceRa,
            double? phaseCurrentR,
            double? phaseCurrentS,
            double? phaseCurrentT)?
        panel,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? measuredVoltageLN,
            double? measuredRcdTripTime,
            double? measuredEarthResistance)?
        generic,
  }) {
    return panel?.call(
        id,
        nodeId,
        measuredAt,
        measuredBy,
        instrument,
        notes,
        photoUrls,
        earthResistanceRa,
        phaseCurrentR,
        phaseCurrentS,
        phaseCurrentT);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? voltageLN,
            double? voltageLL,
            double? frequency,
            double? externalZe)?
        source,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? tripTimeMs,
            double? tripCurrentmA,
            double? contactVoltage,
            bool? mechanicalTestPassed)?
        rcd,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? resistancePhaseEarth,
            double? resistancePhaseNeutral,
            bool? continuityPE)?
        insulation,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? loopImpedanceZs,
            double? voltageAtLoad,
            bool? polarityOk)?
        load,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? earthResistanceRa,
            double? phaseCurrentR,
            double? phaseCurrentS,
            double? phaseCurrentT)?
        panel,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? measuredVoltageLN,
            double? measuredRcdTripTime,
            double? measuredEarthResistance)?
        generic,
    required TResult orElse(),
  }) {
    if (panel != null) {
      return panel(
          id,
          nodeId,
          measuredAt,
          measuredBy,
          instrument,
          notes,
          photoUrls,
          earthResistanceRa,
          phaseCurrentR,
          phaseCurrentS,
          phaseCurrentT);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SourceMeasurement value) source,
    required TResult Function(RcdMeasurement value) rcd,
    required TResult Function(InsulationMeasurement value) insulation,
    required TResult Function(LoadMeasurement value) load,
    required TResult Function(PanelMeasurement value) panel,
    required TResult Function(GenericMeasurement value) generic,
  }) {
    return panel(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SourceMeasurement value)? source,
    TResult? Function(RcdMeasurement value)? rcd,
    TResult? Function(InsulationMeasurement value)? insulation,
    TResult? Function(LoadMeasurement value)? load,
    TResult? Function(PanelMeasurement value)? panel,
    TResult? Function(GenericMeasurement value)? generic,
  }) {
    return panel?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SourceMeasurement value)? source,
    TResult Function(RcdMeasurement value)? rcd,
    TResult Function(InsulationMeasurement value)? insulation,
    TResult Function(LoadMeasurement value)? load,
    TResult Function(PanelMeasurement value)? panel,
    TResult Function(GenericMeasurement value)? generic,
    required TResult orElse(),
  }) {
    if (panel != null) {
      return panel(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PanelMeasurementImplToJson(
      this,
    );
  }
}

abstract class PanelMeasurement implements FieldMeasurement {
  const factory PanelMeasurement(
      {required final String id,
      required final String nodeId,
      required final DateTime measuredAt,
      required final String measuredBy,
      final String? instrument,
      final String? notes,
      final List<String>? photoUrls,
      final double? earthResistanceRa,
      final double? phaseCurrentR,
      final double? phaseCurrentS,
      final double? phaseCurrentT}) = _$PanelMeasurementImpl;

  factory PanelMeasurement.fromJson(Map<String, dynamic> json) =
      _$PanelMeasurementImpl.fromJson;

  @override
  String get id;
  @override
  String get nodeId;
  @override
  DateTime get measuredAt;
  @override
  String get measuredBy;
  @override
  String? get instrument;
  @override
  String? get notes;
  @override
  List<String>? get photoUrls;
  double? get earthResistanceRa; // Resistencia Tierra (Ra)
  double? get phaseCurrentR; // Consumo Fase R
  double? get phaseCurrentS; // Consumo Fase S
  double? get phaseCurrentT;
  @override
  @JsonKey(ignore: true)
  _$$PanelMeasurementImplCopyWith<_$PanelMeasurementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GenericMeasurementImplCopyWith<$Res>
    implements $FieldMeasurementCopyWith<$Res> {
  factory _$$GenericMeasurementImplCopyWith(_$GenericMeasurementImpl value,
          $Res Function(_$GenericMeasurementImpl) then) =
      __$$GenericMeasurementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String nodeId,
      DateTime measuredAt,
      String measuredBy,
      String? instrument,
      String? notes,
      List<String>? photoUrls,
      double? measuredVoltageLN,
      double? measuredRcdTripTime,
      double? measuredEarthResistance});
}

/// @nodoc
class __$$GenericMeasurementImplCopyWithImpl<$Res>
    extends _$FieldMeasurementCopyWithImpl<$Res, _$GenericMeasurementImpl>
    implements _$$GenericMeasurementImplCopyWith<$Res> {
  __$$GenericMeasurementImplCopyWithImpl(_$GenericMeasurementImpl _value,
      $Res Function(_$GenericMeasurementImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? nodeId = null,
    Object? measuredAt = null,
    Object? measuredBy = null,
    Object? instrument = freezed,
    Object? notes = freezed,
    Object? photoUrls = freezed,
    Object? measuredVoltageLN = freezed,
    Object? measuredRcdTripTime = freezed,
    Object? measuredEarthResistance = freezed,
  }) {
    return _then(_$GenericMeasurementImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      nodeId: null == nodeId
          ? _value.nodeId
          : nodeId // ignore: cast_nullable_to_non_nullable
              as String,
      measuredAt: null == measuredAt
          ? _value.measuredAt
          : measuredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      measuredBy: null == measuredBy
          ? _value.measuredBy
          : measuredBy // ignore: cast_nullable_to_non_nullable
              as String,
      instrument: freezed == instrument
          ? _value.instrument
          : instrument // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrls: freezed == photoUrls
          ? _value._photoUrls
          : photoUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      measuredVoltageLN: freezed == measuredVoltageLN
          ? _value.measuredVoltageLN
          : measuredVoltageLN // ignore: cast_nullable_to_non_nullable
              as double?,
      measuredRcdTripTime: freezed == measuredRcdTripTime
          ? _value.measuredRcdTripTime
          : measuredRcdTripTime // ignore: cast_nullable_to_non_nullable
              as double?,
      measuredEarthResistance: freezed == measuredEarthResistance
          ? _value.measuredEarthResistance
          : measuredEarthResistance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GenericMeasurementImpl implements GenericMeasurement {
  const _$GenericMeasurementImpl(
      {required this.id,
      required this.nodeId,
      required this.measuredAt,
      required this.measuredBy,
      this.instrument,
      this.notes,
      final List<String>? photoUrls,
      this.measuredVoltageLN,
      this.measuredRcdTripTime,
      this.measuredEarthResistance,
      final String? $type})
      : _photoUrls = photoUrls,
        $type = $type ?? 'generic';

  factory _$GenericMeasurementImpl.fromJson(Map<String, dynamic> json) =>
      _$$GenericMeasurementImplFromJson(json);

  @override
  final String id;
  @override
  final String nodeId;
  @override
  final DateTime measuredAt;
  @override
  final String measuredBy;
  @override
  final String? instrument;
  @override
  final String? notes;
  final List<String>? _photoUrls;
  @override
  List<String>? get photoUrls {
    final value = _photoUrls;
    if (value == null) return null;
    if (_photoUrls is EqualUnmodifiableListView) return _photoUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// Legacy mapping fields
  @override
  final double? measuredVoltageLN;
  @override
  final double? measuredRcdTripTime;
  @override
  final double? measuredEarthResistance;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'FieldMeasurement.generic(id: $id, nodeId: $nodeId, measuredAt: $measuredAt, measuredBy: $measuredBy, instrument: $instrument, notes: $notes, photoUrls: $photoUrls, measuredVoltageLN: $measuredVoltageLN, measuredRcdTripTime: $measuredRcdTripTime, measuredEarthResistance: $measuredEarthResistance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenericMeasurementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.nodeId, nodeId) || other.nodeId == nodeId) &&
            (identical(other.measuredAt, measuredAt) ||
                other.measuredAt == measuredAt) &&
            (identical(other.measuredBy, measuredBy) ||
                other.measuredBy == measuredBy) &&
            (identical(other.instrument, instrument) ||
                other.instrument == instrument) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            const DeepCollectionEquality()
                .equals(other._photoUrls, _photoUrls) &&
            (identical(other.measuredVoltageLN, measuredVoltageLN) ||
                other.measuredVoltageLN == measuredVoltageLN) &&
            (identical(other.measuredRcdTripTime, measuredRcdTripTime) ||
                other.measuredRcdTripTime == measuredRcdTripTime) &&
            (identical(
                    other.measuredEarthResistance, measuredEarthResistance) ||
                other.measuredEarthResistance == measuredEarthResistance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      nodeId,
      measuredAt,
      measuredBy,
      instrument,
      notes,
      const DeepCollectionEquality().hash(_photoUrls),
      measuredVoltageLN,
      measuredRcdTripTime,
      measuredEarthResistance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GenericMeasurementImplCopyWith<_$GenericMeasurementImpl> get copyWith =>
      __$$GenericMeasurementImplCopyWithImpl<_$GenericMeasurementImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? voltageLN,
            double? voltageLL,
            double? frequency,
            double? externalZe)
        source,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? tripTimeMs,
            double? tripCurrentmA,
            double? contactVoltage,
            bool? mechanicalTestPassed)
        rcd,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? resistancePhaseEarth,
            double? resistancePhaseNeutral,
            bool? continuityPE)
        insulation,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? loopImpedanceZs,
            double? voltageAtLoad,
            bool? polarityOk)
        load,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? earthResistanceRa,
            double? phaseCurrentR,
            double? phaseCurrentS,
            double? phaseCurrentT)
        panel,
    required TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? measuredVoltageLN,
            double? measuredRcdTripTime,
            double? measuredEarthResistance)
        generic,
  }) {
    return generic(
        id,
        nodeId,
        measuredAt,
        measuredBy,
        instrument,
        notes,
        photoUrls,
        measuredVoltageLN,
        measuredRcdTripTime,
        measuredEarthResistance);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? voltageLN,
            double? voltageLL,
            double? frequency,
            double? externalZe)?
        source,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? tripTimeMs,
            double? tripCurrentmA,
            double? contactVoltage,
            bool? mechanicalTestPassed)?
        rcd,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? resistancePhaseEarth,
            double? resistancePhaseNeutral,
            bool? continuityPE)?
        insulation,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? loopImpedanceZs,
            double? voltageAtLoad,
            bool? polarityOk)?
        load,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? earthResistanceRa,
            double? phaseCurrentR,
            double? phaseCurrentS,
            double? phaseCurrentT)?
        panel,
    TResult? Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? measuredVoltageLN,
            double? measuredRcdTripTime,
            double? measuredEarthResistance)?
        generic,
  }) {
    return generic?.call(
        id,
        nodeId,
        measuredAt,
        measuredBy,
        instrument,
        notes,
        photoUrls,
        measuredVoltageLN,
        measuredRcdTripTime,
        measuredEarthResistance);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? voltageLN,
            double? voltageLL,
            double? frequency,
            double? externalZe)?
        source,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? tripTimeMs,
            double? tripCurrentmA,
            double? contactVoltage,
            bool? mechanicalTestPassed)?
        rcd,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? resistancePhaseEarth,
            double? resistancePhaseNeutral,
            bool? continuityPE)?
        insulation,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? loopImpedanceZs,
            double? voltageAtLoad,
            bool? polarityOk)?
        load,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? earthResistanceRa,
            double? phaseCurrentR,
            double? phaseCurrentS,
            double? phaseCurrentT)?
        panel,
    TResult Function(
            String id,
            String nodeId,
            DateTime measuredAt,
            String measuredBy,
            String? instrument,
            String? notes,
            List<String>? photoUrls,
            double? measuredVoltageLN,
            double? measuredRcdTripTime,
            double? measuredEarthResistance)?
        generic,
    required TResult orElse(),
  }) {
    if (generic != null) {
      return generic(
          id,
          nodeId,
          measuredAt,
          measuredBy,
          instrument,
          notes,
          photoUrls,
          measuredVoltageLN,
          measuredRcdTripTime,
          measuredEarthResistance);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SourceMeasurement value) source,
    required TResult Function(RcdMeasurement value) rcd,
    required TResult Function(InsulationMeasurement value) insulation,
    required TResult Function(LoadMeasurement value) load,
    required TResult Function(PanelMeasurement value) panel,
    required TResult Function(GenericMeasurement value) generic,
  }) {
    return generic(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SourceMeasurement value)? source,
    TResult? Function(RcdMeasurement value)? rcd,
    TResult? Function(InsulationMeasurement value)? insulation,
    TResult? Function(LoadMeasurement value)? load,
    TResult? Function(PanelMeasurement value)? panel,
    TResult? Function(GenericMeasurement value)? generic,
  }) {
    return generic?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SourceMeasurement value)? source,
    TResult Function(RcdMeasurement value)? rcd,
    TResult Function(InsulationMeasurement value)? insulation,
    TResult Function(LoadMeasurement value)? load,
    TResult Function(PanelMeasurement value)? panel,
    TResult Function(GenericMeasurement value)? generic,
    required TResult orElse(),
  }) {
    if (generic != null) {
      return generic(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$GenericMeasurementImplToJson(
      this,
    );
  }
}

abstract class GenericMeasurement implements FieldMeasurement {
  const factory GenericMeasurement(
      {required final String id,
      required final String nodeId,
      required final DateTime measuredAt,
      required final String measuredBy,
      final String? instrument,
      final String? notes,
      final List<String>? photoUrls,
      final double? measuredVoltageLN,
      final double? measuredRcdTripTime,
      final double? measuredEarthResistance}) = _$GenericMeasurementImpl;

  factory GenericMeasurement.fromJson(Map<String, dynamic> json) =
      _$GenericMeasurementImpl.fromJson;

  @override
  String get id;
  @override
  String get nodeId;
  @override
  DateTime get measuredAt;
  @override
  String get measuredBy;
  @override
  String? get instrument;
  @override
  String? get notes;
  @override
  List<String>? get photoUrls; // Legacy mapping fields
  double? get measuredVoltageLN;
  double? get measuredRcdTripTime;
  double? get measuredEarthResistance;
  @override
  @JsonKey(ignore: true)
  _$$GenericMeasurementImplCopyWith<_$GenericMeasurementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
