import '../../../../features/diagram/domain/entities/electrical_node.dart';

enum ValidationSeverity { info, warning, error }

class ValidationResult {
  final String nodeId;
  final String ruleId;
  final String message;
  final ValidationSeverity severity;

  ValidationResult({
    required this.nodeId,
    required this.ruleId,
    required this.message,
    this.severity = ValidationSeverity.error,
  });
}

abstract class ComplianceRule {
  String get id;
  String get description;

  /// Validate a specific node tree
  List<ValidationResult> validate(ElectricalNode root);
}

abstract class RegulatoryStandard {
  String get id;
  String get name;
  List<ComplianceRule> get rules;

  /// Validates the full schema (Tree)
  List<ValidationResult> validateSchema(ElectricalNode root) {
    final results = <ValidationResult>[];
    for (final rule in rules) {
      results.addAll(rule.validate(root));
    }
    return results;
  }
}
