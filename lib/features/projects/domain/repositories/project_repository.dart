import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/project.dart';

abstract class ProjectRepository {
  Future<Either<Failure, List<Project>>> getProjects();
  Stream<List<Project>> getProjectsStream();
  Future<Either<Failure, int>> saveProject(Project project);
  Future<Either<Failure, void>> deleteProject(int id);
  Future<bool> isProjectNameTaken(String name);
}
