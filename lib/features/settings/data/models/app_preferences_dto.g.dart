// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_preferences_dto.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAppPreferencesDtoCollection on Isar {
  IsarCollection<AppPreferencesDto> get appPreferencesDtos => this.collection();
}

const AppPreferencesDtoSchema = CollectionSchema(
  name: r'AppPreferencesDto',
  id: 7665667134154061047,
  properties: {
    r'highContrastEnabled': PropertySchema(
      id: 0,
      name: r'highContrastEnabled',
      type: IsarType.bool,
    ),
    r'locale': PropertySchema(
      id: 1,
      name: r'locale',
      type: IsarType.string,
    ),
    r'notificationsEnabled': PropertySchema(
      id: 2,
      name: r'notificationsEnabled',
      type: IsarType.bool,
    ),
    r'textSize': PropertySchema(
      id: 3,
      name: r'textSize',
      type: IsarType.string,
    ),
    r'themeMode': PropertySchema(
      id: 4,
      name: r'themeMode',
      type: IsarType.string,
    )
  },
  estimateSize: _appPreferencesDtoEstimateSize,
  serialize: _appPreferencesDtoSerialize,
  deserialize: _appPreferencesDtoDeserialize,
  deserializeProp: _appPreferencesDtoDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _appPreferencesDtoGetId,
  getLinks: _appPreferencesDtoGetLinks,
  attach: _appPreferencesDtoAttach,
  version: '3.1.0+1',
);

int _appPreferencesDtoEstimateSize(
  AppPreferencesDto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.locale.length * 3;
  bytesCount += 3 + object.textSize.length * 3;
  bytesCount += 3 + object.themeMode.length * 3;
  return bytesCount;
}

void _appPreferencesDtoSerialize(
  AppPreferencesDto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.highContrastEnabled);
  writer.writeString(offsets[1], object.locale);
  writer.writeBool(offsets[2], object.notificationsEnabled);
  writer.writeString(offsets[3], object.textSize);
  writer.writeString(offsets[4], object.themeMode);
}

AppPreferencesDto _appPreferencesDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AppPreferencesDto();
  object.highContrastEnabled = reader.readBool(offsets[0]);
  object.id = id;
  object.locale = reader.readString(offsets[1]);
  object.notificationsEnabled = reader.readBool(offsets[2]);
  object.textSize = reader.readString(offsets[3]);
  object.themeMode = reader.readString(offsets[4]);
  return object;
}

P _appPreferencesDtoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _appPreferencesDtoGetId(AppPreferencesDto object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _appPreferencesDtoGetLinks(
    AppPreferencesDto object) {
  return [];
}

void _appPreferencesDtoAttach(
    IsarCollection<dynamic> col, Id id, AppPreferencesDto object) {
  object.id = id;
}

extension AppPreferencesDtoQueryWhereSort
    on QueryBuilder<AppPreferencesDto, AppPreferencesDto, QWhere> {
  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AppPreferencesDtoQueryWhere
    on QueryBuilder<AppPreferencesDto, AppPreferencesDto, QWhereClause> {
  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AppPreferencesDtoQueryFilter
    on QueryBuilder<AppPreferencesDto, AppPreferencesDto, QFilterCondition> {
  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      highContrastEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'highContrastEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      localeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      localeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      localeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      localeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'locale',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      localeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      localeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      localeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'locale',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      localeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'locale',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      localeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'locale',
        value: '',
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      localeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'locale',
        value: '',
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      notificationsEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationsEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      textSizeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textSize',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      textSizeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textSize',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      textSizeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textSize',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      textSizeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textSize',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      textSizeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textSize',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      textSizeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textSize',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      textSizeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textSize',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      textSizeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textSize',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      textSizeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textSize',
        value: '',
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      textSizeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textSize',
        value: '',
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      themeModeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'themeMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      themeModeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'themeMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      themeModeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'themeMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      themeModeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'themeMode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      themeModeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'themeMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      themeModeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'themeMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      themeModeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'themeMode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      themeModeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'themeMode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      themeModeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'themeMode',
        value: '',
      ));
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterFilterCondition>
      themeModeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'themeMode',
        value: '',
      ));
    });
  }
}

extension AppPreferencesDtoQueryObject
    on QueryBuilder<AppPreferencesDto, AppPreferencesDto, QFilterCondition> {}

extension AppPreferencesDtoQueryLinks
    on QueryBuilder<AppPreferencesDto, AppPreferencesDto, QFilterCondition> {}

extension AppPreferencesDtoQuerySortBy
    on QueryBuilder<AppPreferencesDto, AppPreferencesDto, QSortBy> {
  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterSortBy>
      sortByHighContrastEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'highContrastEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterSortBy>
      sortByHighContrastEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'highContrastEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterSortBy>
      sortByLocale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locale', Sort.asc);
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterSortBy>
      sortByLocaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locale', Sort.desc);
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterSortBy>
      sortByNotificationsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterSortBy>
      sortByNotificationsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterSortBy>
      sortByTextSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textSize', Sort.asc);
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterSortBy>
      sortByTextSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textSize', Sort.desc);
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterSortBy>
      sortByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.asc);
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterSortBy>
      sortByThemeModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.desc);
    });
  }
}

extension AppPreferencesDtoQuerySortThenBy
    on QueryBuilder<AppPreferencesDto, AppPreferencesDto, QSortThenBy> {
  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterSortBy>
      thenByHighContrastEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'highContrastEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterSortBy>
      thenByHighContrastEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'highContrastEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterSortBy>
      thenByLocale() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locale', Sort.asc);
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterSortBy>
      thenByLocaleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'locale', Sort.desc);
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterSortBy>
      thenByNotificationsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.asc);
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterSortBy>
      thenByNotificationsEnabledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationsEnabled', Sort.desc);
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterSortBy>
      thenByTextSize() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textSize', Sort.asc);
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterSortBy>
      thenByTextSizeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textSize', Sort.desc);
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterSortBy>
      thenByThemeMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.asc);
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QAfterSortBy>
      thenByThemeModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'themeMode', Sort.desc);
    });
  }
}

extension AppPreferencesDtoQueryWhereDistinct
    on QueryBuilder<AppPreferencesDto, AppPreferencesDto, QDistinct> {
  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QDistinct>
      distinctByHighContrastEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'highContrastEnabled');
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QDistinct>
      distinctByLocale({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'locale', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QDistinct>
      distinctByNotificationsEnabled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationsEnabled');
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QDistinct>
      distinctByTextSize({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textSize', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppPreferencesDto, AppPreferencesDto, QDistinct>
      distinctByThemeMode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'themeMode', caseSensitive: caseSensitive);
    });
  }
}

extension AppPreferencesDtoQueryProperty
    on QueryBuilder<AppPreferencesDto, AppPreferencesDto, QQueryProperty> {
  QueryBuilder<AppPreferencesDto, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AppPreferencesDto, bool, QQueryOperations>
      highContrastEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'highContrastEnabled');
    });
  }

  QueryBuilder<AppPreferencesDto, String, QQueryOperations> localeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'locale');
    });
  }

  QueryBuilder<AppPreferencesDto, bool, QQueryOperations>
      notificationsEnabledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationsEnabled');
    });
  }

  QueryBuilder<AppPreferencesDto, String, QQueryOperations> textSizeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textSize');
    });
  }

  QueryBuilder<AppPreferencesDto, String, QQueryOperations>
      themeModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'themeMode');
    });
  }
}
