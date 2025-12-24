import 'package:isar/isar.dart';

part 'project_model.g.dart';

@collection
class ProjectModel {
  Id id = Isar.autoIncrement;

  late String name;
  String? reference;
  String? client;
  late DateTime createdAt;
  late DateTime updatedAt;

  // Stores List<DiagramNode> serialized as JSON
  String? nodesJson;
  String? budgetConfigJson;
  String? electricalStandardId;

  String? ownerPhone;
  String? ownerEmail;

  String? supplyVoltage;
  String? installationUsage;
  double? expectedPower;
  double? powerFactor;
  bool? requiresTechProject;
  bool? isNewLink;
}
