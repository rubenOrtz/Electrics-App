import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import '../../../../core/error/failures.dart';
import '../../../../features/diagram/domain/entities/electrical_node.dart';
import '../../../../features/diagram/data/models/electrical_node_dto.dart';
import '../../domain/entities/project.dart';
import '../../domain/repositories/project_repository.dart';
import '../models/project_model.dart';
import '../../domain/entities/budget_config.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final Isar _isar;

  ProjectRepositoryImpl(this._isar);

  @override
  Future<Either<Failure, List<Project>>> getProjects() async {
    try {
      final models =
          await _isar.projectModels.where().sortByNameDesc().findAll();
      final projects = models.map((model) => _mapToEntity(model)).toList();
      return Right(projects);
    } catch (e) {
      return Left(CacheFailure("Failed to get projects: $e"));
    }
  }

  @override
  Stream<List<Project>> getProjectsStream() {
    return _isar.projectModels
        .where()
        .sortByNameDesc()
        .watch(fireImmediately: true)
        .map(
          (models) => models.map((m) => _mapToEntity(m)).toList(),
        );
  }

  @override
  Future<bool> isProjectNameTaken(String name) async {
    final count = await _isar.projectModels.filter().nameEqualTo(name).count();
    return count > 0;
  }

  @override
  Future<Either<Failure, int>> saveProject(Project project) async {
    try {
      final model = _mapToModel(project);

      late int id;
      await _isar.writeTxn(() async {
        id = await _isar.projectModels.put(model);
      });
      return Right(id);
    } catch (e) {
      return Left(CacheFailure("Failed to save project: $e"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProject(int id) async {
    try {
      await _isar.writeTxn(() async {
        await _isar.projectModels.delete(id);
      });
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure("Failed to delete project: $e"));
    }
  }

  Project _mapToEntity(ProjectModel model) {
    ElectricalNode? root;
    if (model.nodesJson != null && model.nodesJson!.isNotEmpty) {
      try {
        final json = jsonDecode(model.nodesJson!);
        if (json is Map<String, dynamic>) {
          root = ElectricalNodeDto.fromJson(json).toDomain();
        }
      } catch (e) {
        // Error decoding, possibly old format or corrupted.
        // We return null root (safe default)
      }
    }

    BudgetConfig? budgetConfig;
    if (model.budgetConfigJson != null && model.budgetConfigJson!.isNotEmpty) {
      try {
        final json = jsonDecode(model.budgetConfigJson!);
        budgetConfig = BudgetConfig.fromJson(json);
      } catch (e) {
        // ignore
      }
    }

    return Project(
      id: model.id,
      name: model.name,
      reference: model.reference,
      client: model.client,
      ownerPhone: model.ownerPhone,
      ownerEmail: model.ownerEmail,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      root: root,
      electricalStandardId: model.electricalStandardId,
      budgetConfig: budgetConfig,
      supplyVoltage: model.supplyVoltage,
      installationUsage: model.installationUsage,
      expectedPower: model.expectedPower,
      powerFactor: model.powerFactor,
      requiresTechProject: model.requiresTechProject,
      isNewLink: model.isNewLink,
    );
  }

  ProjectModel _mapToModel(Project project) {
    final model = ProjectModel()
      ..name = project.name
      ..reference = project.reference
      ..client = project.client
      ..ownerPhone = project.ownerPhone
      ..ownerEmail = project.ownerEmail
      ..createdAt = project.createdAt
      ..updatedAt = DateTime.now()
      ..electricalStandardId = project.electricalStandardId
      ..supplyVoltage = project.supplyVoltage
      ..installationUsage = project.installationUsage
      ..expectedPower = project.expectedPower
      ..powerFactor = project.powerFactor
      ..requiresTechProject = project.requiresTechProject
      ..isNewLink = project.isNewLink;

    if (project.root != null) {
      model.nodesJson = jsonEncode(project.root!.toDto().toJson());
    }

    if (project.budgetConfig != null) {
      model.budgetConfigJson = jsonEncode(project.budgetConfig!.toJson());
    }

    if (project.id != null) {
      model.id = project.id!;
    }
    return model;
  }
}
