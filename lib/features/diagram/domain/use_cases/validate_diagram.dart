import '../../../../core/usecase/usecase.dart';
import '../entities/electrical_node.dart';
import '../../../compliance/domain/entities/compliance_base.dart';

class ValidateDiagramParams {
  final ElectricalNode root;
  final RegulatoryStandard standard;
  ValidateDiagramParams(this.root, this.standard);
}

class ValidateDiagramUseCase
    implements UseCase<List<ValidationResult>, ValidateDiagramParams> {
  @override
  Future<List<ValidationResult>> call({ValidateDiagramParams? params}) async {
    if (params == null) throw Exception("Params required");
    return params.standard.validateSchema(params.root);
  }
}
