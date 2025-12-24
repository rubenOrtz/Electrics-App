import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/error/failures.dart';
import '../repositories/diagram_repository.dart';
import '../entities/electrical_node.dart';

class NoParams {}

class GetSavedDiagramsUseCase
    implements UseCase<Either<Failure, List<ElectricalNode>>, NoParams> {
  final DiagramRepository repository;

  GetSavedDiagramsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ElectricalNode>>> call({NoParams? params}) async {
    return await repository.getSavedDiagrams();
  }
}
