import 'package:electrician_app/features/projects/data/models/project_model.dart';
import 'package:electrician_app/core/error/failures.dart';
import 'package:isar/isar.dart';

abstract class ProjectLocalDataSource {
  Future<List<ProjectModel>> getProjects();
  Future<int> saveProject(ProjectModel project);
  Future<void> deleteProject(int id);
  Future<bool> isProjectNameTaken(String name);
  Stream<List<ProjectModel>> getProjectsStream();
}

class ProjectLocalDataSourceImpl implements ProjectLocalDataSource {
  final Isar isar;

  ProjectLocalDataSourceImpl(this.isar);

  @override
  Future<List<ProjectModel>> getProjects() async {
    try {
      return await isar.projectModels.where().sortByNameDesc().findAll();
    } catch (e) {
      throw CacheFailure("Failed to get projects: $e");
    }
  }

  @override
  Future<int> saveProject(ProjectModel project) async {
    try {
      int id = 0;
      await isar.writeTxn(() async {
        id = await isar.projectModels.put(project);
      });
      return id;
    } catch (e) {
      throw CacheFailure("Failed to save project: $e");
    }
  }

  @override
  Future<void> deleteProject(int id) async {
    try {
      await isar.writeTxn(() async {
        await isar.projectModels.delete(id);
      });
    } catch (e) {
      throw CacheFailure("Failed to delete project: $e");
    }
  }

  @override
  Future<bool> isProjectNameTaken(String name) async {
    final count = await isar.projectModels.filter().nameEqualTo(name).count();
    return count > 0;
  }

  @override
  Stream<List<ProjectModel>> getProjectsStream() {
    return isar.projectModels
        .where()
        .sortByNameDesc()
        .watch(fireImmediately: true);
  }
}
