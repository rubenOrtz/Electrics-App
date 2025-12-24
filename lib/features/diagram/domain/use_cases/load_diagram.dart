import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/error/failures.dart';
import '../repositories/diagram_repository.dart';
import '../entities/electrical_node.dart';

class LoadDiagramUseCase
    implements UseCase<Either<Failure, ElectricalNode>, String> {
  final DiagramRepository repository;

  LoadDiagramUseCase(this.repository);

  @override
  Future<Either<Failure, ElectricalNode>> call({String? params}) async {
    if (params == null) return const Left(CacheFailure("No ID provided"));
    return await repository.loadDiagram(params);
  }
}
