// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'template_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TemplateModel _$TemplateModelFromJson(Map<String, dynamic> json) =>
    TemplateModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      nodes: (json['nodes'] as List<dynamic>)
          .map((e) => TemplateNodeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TemplateModelToJson(TemplateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'nodes': instance.nodes.map((e) => e.toJson()).toList(),
    };

TemplateNodeModel _$TemplateNodeModelFromJson(Map<String, dynamic> json) =>
    TemplateNodeModel(
      id: json['id'] as String,
      type: json['type'] as String,
      parentId: json['parentId'] as String?,
      name: json['name'] as String,
      properties: json['properties'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$TemplateNodeModelToJson(TemplateNodeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'parentId': instance.parentId,
      'name': instance.name,
      'properties': instance.properties,
    };
