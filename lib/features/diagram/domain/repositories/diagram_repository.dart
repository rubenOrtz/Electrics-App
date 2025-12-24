import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/electrical_node.dart';
import '../entities/cable_definition.dart';
import '../entities/protection_definition.dart';

abstract class DiagramRepository {
  Future<Either<Failure, ElectricalNode>> saveDiagram(ElectricalNode root);
  Future<Either<Failure, ElectricalNode>> loadDiagram(String projectId);
  Future<Either<Failure, List<ElectricalNode>>> getSavedDiagrams();

  // Library Access
  List<CableDefinition> getAvailableCables();
  List<ProtectionDefinition> getAvailableProtections();
}
