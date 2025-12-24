import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/error/failures.dart';
import '../repositories/diagram_repository.dart';
import '../entities/electrical_node.dart';

class SaveDiagramUseCase
    implements UseCase<Either<Failure, ElectricalNode>, ElectricalNode> {
  final DiagramRepository repository;

  SaveDiagramUseCase(this.repository);

  @override
  Future<Either<Failure, ElectricalNode>> call({ElectricalNode? params}) async {
    if (params == null) return const Left(CacheFailure("No diagram provided"));
    return await repository.saveDiagram(params);
  }
}
