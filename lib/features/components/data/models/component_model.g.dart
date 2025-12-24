// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetComponentModelCollection on Isar {
  IsarCollection<ComponentModel> get componentModels => this.collection();
}

const ComponentModelSchema = CollectionSchema(
  name: r'ComponentModel',
  id: -2001216608500265195,
  properties: {
    r'breakingCapacity': PropertySchema(
      id: 0,
      name: r'breakingCapacity',
      type: IsarType.double,
    ),
    r'cableMaterial': PropertySchema(
      id: 1,
      name: r'cableMaterial',
      type: IsarType.string,
      enumMap: _ComponentModelcableMaterialEnumValueMap,
    ),
    r'componentId': PropertySchema(
      id: 2,
      name: r'componentId',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'curveType': PropertySchema(
      id: 4,
      name: r'curveType',
      type: IsarType.string,
    ),
    r'installationMethod': PropertySchema(
      id: 5,
      name: r'installationMethod',
      type: IsarType.string,
    ),
    r'insulationType': PropertySchema(
      id: 6,
      name: r'insulationType',
      type: IsarType.string,
    ),
    r'isFavorite': PropertySchema(
      id: 7,
      name: r'isFavorite',
      type: IsarType.bool,
    ),
    r'manufacturer': PropertySchema(
      id: 8,
      name: r'manufacturer',
      type: IsarType.string,
    ),
    r'maxOperatingTemp': PropertySchema(
      id: 9,
      name: r'maxOperatingTemp',
      type: IsarType.double,
    ),
    r'maxShortCircuitCurrent': PropertySchema(
      id: 10,
      name: r'maxShortCircuitCurrent',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 11,
      name: r'name',
      type: IsarType.string,
    ),
    r'poles': PropertySchema(
      id: 12,
      name: r'poles',
      type: IsarType.long,
    ),
    r'price': PropertySchema(
      id: 13,
      name: r'price',
      type: IsarType.double,
    ),
    r'protectionDeviceType': PropertySchema(
      id: 14,
      name: r'protectionDeviceType',
      type: IsarType.string,
      enumMap: _ComponentModelprotectionDeviceTypeEnumValueMap,
    ),
    r'ratedCurrent': PropertySchema(
      id: 15,
      name: r'ratedCurrent',
      type: IsarType.double,
    ),
    r'ratedPower': PropertySchema(
      id: 16,
      name: r'ratedPower',
      type: IsarType.double,
    ),
    r'section': PropertySchema(
      id: 17,
      name: r'section',
      type: IsarType.double,
    ),
    r'sensitivity': PropertySchema(
      id: 18,
      name: r'sensitivity',
      type: IsarType.double,
    ),
    r'series': PropertySchema(
      id: 19,
      name: r'series',
      type: IsarType.string,
    ),
    r'sourceType': PropertySchema(
      id: 20,
      name: r'sourceType',
      type: IsarType.string,
      enumMap: _ComponentModelsourceTypeEnumValueMap,
    ),
    r'type': PropertySchema(
      id: 21,
      name: r'type',
      type: IsarType.string,
      enumMap: _ComponentModeltypeEnumValueMap,
    ),
    r'updatedAt': PropertySchema(
      id: 22,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'voltage': PropertySchema(
      id: 23,
      name: r'voltage',
      type: IsarType.double,
    )
  },
  estimateSize: _componentModelEstimateSize,
  serialize: _componentModelSerialize,
  deserialize: _componentModelDeserialize,
  deserializeProp: _componentModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'name': IndexSchema(
      id: 879695947855722453,
      name: r'name',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'name',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'isFavorite': IndexSchema(
      id: 5742774614603939776,
      name: r'isFavorite',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isFavorite',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'type': IndexSchema(
      id: 5117122708147080838,
      name: r'type',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'type',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _componentModelGetId,
  getLinks: _componentModelGetLinks,
  attach: _componentModelAttach,
  version: '3.1.0+1',
);

int _componentModelEstimateSize(
  ComponentModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.cableMaterial;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  bytesCount += 3 + object.componentId.length * 3;
  {
    final value = object.curveType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.installationMethod;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.insulationType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.manufacturer;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.protectionDeviceType;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.series;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sourceType;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  bytesCount += 3 + object.type.name.length * 3;
  return bytesCount;
}

void _componentModelSerialize(
  ComponentModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.breakingCapacity);
  writer.writeString(offsets[1], object.cableMaterial?.name);
  writer.writeString(offsets[2], object.componentId);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeString(offsets[4], object.curveType);
  writer.writeString(offsets[5], object.installationMethod);
  writer.writeString(offsets[6], object.insulationType);
  writer.writeBool(offsets[7], object.isFavorite);
  writer.writeString(offsets[8], object.manufacturer);
  writer.writeDouble(offsets[9], object.maxOperatingTemp);
  writer.writeDouble(offsets[10], object.maxShortCircuitCurrent);
  writer.writeString(offsets[11], object.name);
  writer.writeLong(offsets[12], object.poles);
  writer.writeDouble(offsets[13], object.price);
  writer.writeString(offsets[14], object.protectionDeviceType?.name);
  writer.writeDouble(offsets[15], object.ratedCurrent);
  writer.writeDouble(offsets[16], object.ratedPower);
  writer.writeDouble(offsets[17], object.section);
  writer.writeDouble(offsets[18], object.sensitivity);
  writer.writeString(offsets[19], object.series);
  writer.writeString(offsets[20], object.sourceType?.name);
  writer.writeString(offsets[21], object.type.name);
  writer.writeDateTime(offsets[22], object.updatedAt);
  writer.writeDouble(offsets[23], object.voltage);
}

ComponentModel _componentModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ComponentModel();
  object.breakingCapacity = reader.readDoubleOrNull(offsets[0]);
  object.cableMaterial = _ComponentModelcableMaterialValueEnumMap[
      reader.readStringOrNull(offsets[1])];
  object.componentId = reader.readString(offsets[2]);
  object.createdAt = reader.readDateTime(offsets[3]);
  object.curveType = reader.readStringOrNull(offsets[4]);
  object.id = id;
  object.installationMethod = reader.readStringOrNull(offsets[5]);
  object.insulationType = reader.readStringOrNull(offsets[6]);
  object.isFavorite = reader.readBool(offsets[7]);
  object.manufacturer = reader.readStringOrNull(offsets[8]);
  object.maxOperatingTemp = reader.readDoubleOrNull(offsets[9]);
  object.maxShortCircuitCurrent = reader.readDoubleOrNull(offsets[10]);
  object.name = reader.readString(offsets[11]);
  object.poles = reader.readLongOrNull(offsets[12]);
  object.price = reader.readDoubleOrNull(offsets[13]);
  object.protectionDeviceType = _ComponentModelprotectionDeviceTypeValueEnumMap[
      reader.readStringOrNull(offsets[14])];
  object.ratedCurrent = reader.readDoubleOrNull(offsets[15]);
  object.ratedPower = reader.readDoubleOrNull(offsets[16]);
  object.section = reader.readDoubleOrNull(offsets[17]);
  object.sensitivity = reader.readDoubleOrNull(offsets[18]);
  object.series = reader.readStringOrNull(offsets[19]);
  object.sourceType = _ComponentModelsourceTypeValueEnumMap[
      reader.readStringOrNull(offsets[20])];
  object.type =
      _ComponentModeltypeValueEnumMap[reader.readStringOrNull(offsets[21])] ??
          ComponentType.protection;
  object.updatedAt = reader.readDateTimeOrNull(offsets[22]);
  object.voltage = reader.readDoubleOrNull(offsets[23]);
  return object;
}

P _componentModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (_ComponentModelcableMaterialValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readDoubleOrNull(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readLongOrNull(offset)) as P;
    case 13:
      return (reader.readDoubleOrNull(offset)) as P;
    case 14:
      return (_ComponentModelprotectionDeviceTypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 15:
      return (reader.readDoubleOrNull(offset)) as P;
    case 16:
      return (reader.readDoubleOrNull(offset)) as P;
    case 17:
      return (reader.readDoubleOrNull(offset)) as P;
    case 18:
      return (reader.readDoubleOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (_ComponentModelsourceTypeValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 21:
      return (_ComponentModeltypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          ComponentType.protection) as P;
    case 22:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 23:
      return (reader.readDoubleOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ComponentModelcableMaterialEnumValueMap = {
  r'copper': r'copper',
  r'aluminum': r'aluminum',
};
const _ComponentModelcableMaterialValueEnumMap = {
  r'copper': CableMaterial.copper,
  r'aluminum': CableMaterial.aluminum,
};
const _ComponentModelprotectionDeviceTypeEnumValueMap = {
  r'circuitBreaker': r'circuitBreaker',
  r'differential': r'differential',
  r'fuse': r'fuse',
  r'motorProtector': r'motorProtector',
};
const _ComponentModelprotectionDeviceTypeValueEnumMap = {
  r'circuitBreaker': ProtectionDeviceType.circuitBreaker,
  r'differential': ProtectionDeviceType.differential,
  r'fuse': ProtectionDeviceType.fuse,
  r'motorProtector': ProtectionDeviceType.motorProtector,
};
const _ComponentModelsourceTypeEnumValueMap = {
  r'grid': r'grid',
  r'transformer': r'transformer',
  r'generator': r'generator',
  r'ups': r'ups',
};
const _ComponentModelsourceTypeValueEnumMap = {
  r'grid': SourceType.grid,
  r'transformer': SourceType.transformer,
  r'generator': SourceType.generator,
  r'ups': SourceType.ups,
};
const _ComponentModeltypeEnumValueMap = {
  r'protection': r'protection',
  r'cable': r'cable',
  r'source': r'source',
};
const _ComponentModeltypeValueEnumMap = {
  r'protection': ComponentType.protection,
  r'cable': ComponentType.cable,
  r'source': ComponentType.source,
};

Id _componentModelGetId(ComponentModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _componentModelGetLinks(ComponentModel object) {
  return [];
}

void _componentModelAttach(
    IsarCollection<dynamic> col, Id id, ComponentModel object) {
  object.id = id;
}

extension ComponentModelQueryWhereSort
    on QueryBuilder<ComponentModel, ComponentModel, QWhere> {
  QueryBuilder<ComponentModel, ComponentModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterWhere> anyIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isFavorite'),
      );
    });
  }
}

extension ComponentModelQueryWhere
    on QueryBuilder<ComponentModel, ComponentModel, QWhereClause> {
  QueryBuilder<ComponentModel, ComponentModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<ComponentModel, ComponentModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<ComponentModel, ComponentModel, QAfterWhereClause> nameEqualTo(
      String name) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'name',
        value: [name],
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterWhereClause>
      nameNotEqualTo(String name) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [name],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'name',
              lower: [],
              upper: [name],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterWhereClause>
      isFavoriteEqualTo(bool isFavorite) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isFavorite',
        value: [isFavorite],
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterWhereClause>
      isFavoriteNotEqualTo(bool isFavorite) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isFavorite',
              lower: [],
              upper: [isFavorite],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isFavorite',
              lower: [isFavorite],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isFavorite',
              lower: [isFavorite],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isFavorite',
              lower: [],
              upper: [isFavorite],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterWhereClause> typeEqualTo(
      ComponentType type) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'type',
        value: [type],
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterWhereClause>
      typeNotEqualTo(ComponentType type) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type',
              lower: [],
              upper: [type],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type',
              lower: [type],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type',
              lower: [type],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'type',
              lower: [],
              upper: [type],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ComponentModelQueryFilter
    on QueryBuilder<ComponentModel, ComponentModel, QFilterCondition> {
  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      breakingCapacityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'breakingCapacity',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      breakingCapacityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'breakingCapacity',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      breakingCapacityEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'breakingCapacity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      breakingCapacityGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'breakingCapacity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      breakingCapacityLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'breakingCapacity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      breakingCapacityBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'breakingCapacity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      cableMaterialIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cableMaterial',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      cableMaterialIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cableMaterial',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      cableMaterialEqualTo(
    CableMaterial? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cableMaterial',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      cableMaterialGreaterThan(
    CableMaterial? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cableMaterial',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      cableMaterialLessThan(
    CableMaterial? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cableMaterial',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      cableMaterialBetween(
    CableMaterial? lower,
    CableMaterial? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cableMaterial',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      cableMaterialStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cableMaterial',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      cableMaterialEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cableMaterial',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      cableMaterialContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cableMaterial',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      cableMaterialMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cableMaterial',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      cableMaterialIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cableMaterial',
        value: '',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      cableMaterialIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cableMaterial',
        value: '',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      componentIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'componentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      componentIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'componentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      componentIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'componentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      componentIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'componentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      componentIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'componentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      componentIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'componentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      componentIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'componentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      componentIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'componentId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      componentIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'componentId',
        value: '',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      componentIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'componentId',
        value: '',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      curveTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'curveType',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      curveTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'curveType',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      curveTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'curveType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      curveTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'curveType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      curveTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'curveType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      curveTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'curveType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      curveTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'curveType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      curveTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'curveType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      curveTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'curveType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      curveTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'curveType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      curveTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'curveType',
        value: '',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      curveTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'curveType',
        value: '',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
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

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
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

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      installationMethodIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'installationMethod',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      installationMethodIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'installationMethod',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      installationMethodEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'installationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      installationMethodGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'installationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      installationMethodLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'installationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      installationMethodBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'installationMethod',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      installationMethodStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'installationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      installationMethodEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'installationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      installationMethodContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'installationMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      installationMethodMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'installationMethod',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      installationMethodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'installationMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      installationMethodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'installationMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      insulationTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'insulationType',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      insulationTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'insulationType',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      insulationTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'insulationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      insulationTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'insulationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      insulationTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'insulationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      insulationTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'insulationType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      insulationTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'insulationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      insulationTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'insulationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      insulationTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'insulationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      insulationTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'insulationType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      insulationTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'insulationType',
        value: '',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      insulationTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'insulationType',
        value: '',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      isFavoriteEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFavorite',
        value: value,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      manufacturerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'manufacturer',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      manufacturerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'manufacturer',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      manufacturerEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'manufacturer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      manufacturerGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'manufacturer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      manufacturerLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'manufacturer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      manufacturerBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'manufacturer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      manufacturerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'manufacturer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      manufacturerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'manufacturer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      manufacturerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'manufacturer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      manufacturerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'manufacturer',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      manufacturerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'manufacturer',
        value: '',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      manufacturerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'manufacturer',
        value: '',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      maxOperatingTempIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxOperatingTemp',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      maxOperatingTempIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxOperatingTemp',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      maxOperatingTempEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxOperatingTemp',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      maxOperatingTempGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxOperatingTemp',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      maxOperatingTempLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxOperatingTemp',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      maxOperatingTempBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxOperatingTemp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      maxShortCircuitCurrentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'maxShortCircuitCurrent',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      maxShortCircuitCurrentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'maxShortCircuitCurrent',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      maxShortCircuitCurrentEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxShortCircuitCurrent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      maxShortCircuitCurrentGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxShortCircuitCurrent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      maxShortCircuitCurrentLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxShortCircuitCurrent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      maxShortCircuitCurrentBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxShortCircuitCurrent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      polesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'poles',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      polesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'poles',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      polesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'poles',
        value: value,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      polesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'poles',
        value: value,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      polesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'poles',
        value: value,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      polesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'poles',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      priceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'price',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      priceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'price',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      priceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      priceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      priceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      priceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'price',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      protectionDeviceTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'protectionDeviceType',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      protectionDeviceTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'protectionDeviceType',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      protectionDeviceTypeEqualTo(
    ProtectionDeviceType? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'protectionDeviceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      protectionDeviceTypeGreaterThan(
    ProtectionDeviceType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'protectionDeviceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      protectionDeviceTypeLessThan(
    ProtectionDeviceType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'protectionDeviceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      protectionDeviceTypeBetween(
    ProtectionDeviceType? lower,
    ProtectionDeviceType? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'protectionDeviceType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      protectionDeviceTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'protectionDeviceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      protectionDeviceTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'protectionDeviceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      protectionDeviceTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'protectionDeviceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      protectionDeviceTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'protectionDeviceType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      protectionDeviceTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'protectionDeviceType',
        value: '',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      protectionDeviceTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'protectionDeviceType',
        value: '',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      ratedCurrentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ratedCurrent',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      ratedCurrentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ratedCurrent',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      ratedCurrentEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ratedCurrent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      ratedCurrentGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ratedCurrent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      ratedCurrentLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ratedCurrent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      ratedCurrentBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ratedCurrent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      ratedPowerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ratedPower',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      ratedPowerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ratedPower',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      ratedPowerEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ratedPower',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      ratedPowerGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ratedPower',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      ratedPowerLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ratedPower',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      ratedPowerBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ratedPower',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sectionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'section',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sectionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'section',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sectionEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'section',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sectionGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'section',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sectionLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'section',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sectionBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'section',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sensitivityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sensitivity',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sensitivityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sensitivity',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sensitivityEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sensitivity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sensitivityGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sensitivity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sensitivityLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sensitivity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sensitivityBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sensitivity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      seriesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'series',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      seriesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'series',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      seriesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'series',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      seriesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'series',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      seriesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'series',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      seriesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'series',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      seriesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'series',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      seriesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'series',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      seriesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'series',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      seriesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'series',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      seriesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'series',
        value: '',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      seriesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'series',
        value: '',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sourceTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sourceType',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sourceTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sourceType',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sourceTypeEqualTo(
    SourceType? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sourceTypeGreaterThan(
    SourceType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sourceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sourceTypeLessThan(
    SourceType? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sourceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sourceTypeBetween(
    SourceType? lower,
    SourceType? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sourceType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sourceTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sourceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sourceTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sourceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sourceTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sourceType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sourceTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sourceType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sourceTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceType',
        value: '',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      sourceTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sourceType',
        value: '',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      typeEqualTo(
    ComponentType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      typeGreaterThan(
    ComponentType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      typeLessThan(
    ComponentType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      typeBetween(
    ComponentType lower,
    ComponentType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      updatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      voltageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'voltage',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      voltageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'voltage',
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      voltageEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'voltage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      voltageGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'voltage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      voltageLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'voltage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterFilterCondition>
      voltageBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'voltage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension ComponentModelQueryObject
    on QueryBuilder<ComponentModel, ComponentModel, QFilterCondition> {}

extension ComponentModelQueryLinks
    on QueryBuilder<ComponentModel, ComponentModel, QFilterCondition> {}

extension ComponentModelQuerySortBy
    on QueryBuilder<ComponentModel, ComponentModel, QSortBy> {
  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByBreakingCapacity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakingCapacity', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByBreakingCapacityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakingCapacity', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByCableMaterial() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cableMaterial', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByCableMaterialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cableMaterial', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByComponentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'componentId', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByComponentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'componentId', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> sortByCurveType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'curveType', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByCurveTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'curveType', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByInstallationMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'installationMethod', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByInstallationMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'installationMethod', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByInsulationType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insulationType', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByInsulationTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insulationType', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByManufacturer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manufacturer', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByManufacturerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manufacturer', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByMaxOperatingTemp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxOperatingTemp', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByMaxOperatingTempDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxOperatingTemp', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByMaxShortCircuitCurrent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxShortCircuitCurrent', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByMaxShortCircuitCurrentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxShortCircuitCurrent', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> sortByPoles() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poles', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> sortByPolesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poles', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> sortByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> sortByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByProtectionDeviceType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protectionDeviceType', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByProtectionDeviceTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protectionDeviceType', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByRatedCurrent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratedCurrent', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByRatedCurrentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratedCurrent', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByRatedPower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratedPower', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByRatedPowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratedPower', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> sortBySection() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'section', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortBySectionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'section', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortBySensitivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensitivity', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortBySensitivityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensitivity', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> sortBySeries() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'series', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortBySeriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'series', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortBySourceType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceType', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortBySourceTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceType', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> sortByVoltage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voltage', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      sortByVoltageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voltage', Sort.desc);
    });
  }
}

extension ComponentModelQuerySortThenBy
    on QueryBuilder<ComponentModel, ComponentModel, QSortThenBy> {
  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByBreakingCapacity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakingCapacity', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByBreakingCapacityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'breakingCapacity', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByCableMaterial() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cableMaterial', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByCableMaterialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cableMaterial', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByComponentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'componentId', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByComponentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'componentId', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> thenByCurveType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'curveType', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByCurveTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'curveType', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByInstallationMethod() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'installationMethod', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByInstallationMethodDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'installationMethod', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByInsulationType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insulationType', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByInsulationTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insulationType', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByIsFavoriteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFavorite', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByManufacturer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manufacturer', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByManufacturerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manufacturer', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByMaxOperatingTemp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxOperatingTemp', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByMaxOperatingTempDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxOperatingTemp', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByMaxShortCircuitCurrent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxShortCircuitCurrent', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByMaxShortCircuitCurrentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxShortCircuitCurrent', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> thenByPoles() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poles', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> thenByPolesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poles', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> thenByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> thenByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByProtectionDeviceType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protectionDeviceType', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByProtectionDeviceTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'protectionDeviceType', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByRatedCurrent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratedCurrent', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByRatedCurrentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratedCurrent', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByRatedPower() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratedPower', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByRatedPowerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ratedPower', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> thenBySection() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'section', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenBySectionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'section', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenBySensitivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensitivity', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenBySensitivityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sensitivity', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> thenBySeries() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'series', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenBySeriesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'series', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenBySourceType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceType', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenBySourceTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceType', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy> thenByVoltage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voltage', Sort.asc);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QAfterSortBy>
      thenByVoltageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'voltage', Sort.desc);
    });
  }
}

extension ComponentModelQueryWhereDistinct
    on QueryBuilder<ComponentModel, ComponentModel, QDistinct> {
  QueryBuilder<ComponentModel, ComponentModel, QDistinct>
      distinctByBreakingCapacity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'breakingCapacity');
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct>
      distinctByCableMaterial({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cableMaterial',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct> distinctByComponentId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'componentId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct> distinctByCurveType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'curveType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct>
      distinctByInstallationMethod({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'installationMethod',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct>
      distinctByInsulationType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'insulationType',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct>
      distinctByIsFavorite() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFavorite');
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct>
      distinctByManufacturer({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'manufacturer', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct>
      distinctByMaxOperatingTemp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxOperatingTemp');
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct>
      distinctByMaxShortCircuitCurrent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxShortCircuitCurrent');
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct> distinctByPoles() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'poles');
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct> distinctByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'price');
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct>
      distinctByProtectionDeviceType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'protectionDeviceType',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct>
      distinctByRatedCurrent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ratedCurrent');
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct>
      distinctByRatedPower() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ratedPower');
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct> distinctBySection() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'section');
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct>
      distinctBySensitivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sensitivity');
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct> distinctBySeries(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'series', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct> distinctBySourceType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<ComponentModel, ComponentModel, QDistinct> distinctByVoltage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'voltage');
    });
  }
}

extension ComponentModelQueryProperty
    on QueryBuilder<ComponentModel, ComponentModel, QQueryProperty> {
  QueryBuilder<ComponentModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ComponentModel, double?, QQueryOperations>
      breakingCapacityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'breakingCapacity');
    });
  }

  QueryBuilder<ComponentModel, CableMaterial?, QQueryOperations>
      cableMaterialProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cableMaterial');
    });
  }

  QueryBuilder<ComponentModel, String, QQueryOperations> componentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'componentId');
    });
  }

  QueryBuilder<ComponentModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<ComponentModel, String?, QQueryOperations> curveTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'curveType');
    });
  }

  QueryBuilder<ComponentModel, String?, QQueryOperations>
      installationMethodProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'installationMethod');
    });
  }

  QueryBuilder<ComponentModel, String?, QQueryOperations>
      insulationTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'insulationType');
    });
  }

  QueryBuilder<ComponentModel, bool, QQueryOperations> isFavoriteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFavorite');
    });
  }

  QueryBuilder<ComponentModel, String?, QQueryOperations>
      manufacturerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'manufacturer');
    });
  }

  QueryBuilder<ComponentModel, double?, QQueryOperations>
      maxOperatingTempProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxOperatingTemp');
    });
  }

  QueryBuilder<ComponentModel, double?, QQueryOperations>
      maxShortCircuitCurrentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxShortCircuitCurrent');
    });
  }

  QueryBuilder<ComponentModel, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<ComponentModel, int?, QQueryOperations> polesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'poles');
    });
  }

  QueryBuilder<ComponentModel, double?, QQueryOperations> priceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'price');
    });
  }

  QueryBuilder<ComponentModel, ProtectionDeviceType?, QQueryOperations>
      protectionDeviceTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'protectionDeviceType');
    });
  }

  QueryBuilder<ComponentModel, double?, QQueryOperations>
      ratedCurrentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ratedCurrent');
    });
  }

  QueryBuilder<ComponentModel, double?, QQueryOperations> ratedPowerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ratedPower');
    });
  }

  QueryBuilder<ComponentModel, double?, QQueryOperations> sectionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'section');
    });
  }

  QueryBuilder<ComponentModel, double?, QQueryOperations>
      sensitivityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sensitivity');
    });
  }

  QueryBuilder<ComponentModel, String?, QQueryOperations> seriesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'series');
    });
  }

  QueryBuilder<ComponentModel, SourceType?, QQueryOperations>
      sourceTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceType');
    });
  }

  QueryBuilder<ComponentModel, ComponentType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<ComponentModel, DateTime?, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<ComponentModel, double?, QQueryOperations> voltageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'voltage');
    });
  }
}
