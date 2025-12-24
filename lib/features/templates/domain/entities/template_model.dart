import 'package:json_annotation/json_annotation.dart';

part 'template_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TemplateModel {
  final String id;
  final String name;
  final String description;
  final String category;
  final List<TemplateNodeModel> nodes;

  TemplateModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.nodes,
  });

  factory TemplateModel.fromJson(Map<String, dynamic> json) =>
      _$TemplateModelFromJson(json);
  Map<String, dynamic> toJson() => _$TemplateModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TemplateNodeModel {
  final String id;
  final String type; // 'panel', 'conductor', 'source', 'load', 'protection'
  final String? parentId;
  final String name;

  /// Properties map that allows dynamic placeholders.
  /// Example: { "lengthMeters": "{{user_length}}" }
  /// Values can be Strings (placeholders) or primitives (numbers, bools).
  final Map<String, dynamic> properties;

  TemplateNodeModel({
    required this.id,
    required this.type,
    this.parentId,
    required this.name,
    required this.properties,
  });

  factory TemplateNodeModel.fromJson(Map<String, dynamic> json) =>
      _$TemplateNodeModelFromJson(json);
  Map<String, dynamic> toJson() => _$TemplateNodeModelToJson(this);
}
