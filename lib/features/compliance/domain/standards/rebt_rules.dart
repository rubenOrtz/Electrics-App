import '../../../../features/diagram/domain/entities/electrical_node.dart';
// Maybe needed

import '../entities/compliance_base.dart';

class RebtSpainStandard extends RegulatoryStandard {
  @override
  String get id => 'rebt_spain';
  @override
  String get name => 'España - REBT 2002';

  @override
  List<ComplianceRule> get rules => [
        RebtItcBt19Rule(),
        // RebtItcBt22Rule(), // Example: Min Section
      ];
}

/// ITC-BT-19: Prescripciones generales (Caída de Tensión)
class RebtItcBt19Rule extends ComplianceRule {
  @override
  String get id => 'rebt_itc_bt_19';
  @override
  String get description => 'Caída de Tensión Máxima (ITC-BT-19)';

  @override
  List<ValidationResult> validate(ElectricalNode root) {
    final results = <ValidationResult>[];

    // Flatten tree
    final allNodes = _flatten(root);

    for (var node in allNodes) {
      double limit = 5.0; // Default generic limit (Private use)

      // Determine limit based on node type/context (simplified)
      // Lighting: 3%, Others: 5% (Main feeder varies)
      // For MVP we stick to 5%.

      // Check Voltage Drop in State (Calculated by Engine)
      final drop = node.state.voltageDropPercent;

      if (drop > limit) {
        results.add(ValidationResult(
          nodeId: node.id,
          ruleId: id,
          message:
              'Caída de tensión excesiva: ${drop.toStringAsFixed(2)}% (Máx $limit%)',
          severity: ValidationSeverity.error,
        ));
      }
    }

    return results;
  }

  List<ElectricalNode> _flatten(ElectricalNode node) {
    List<ElectricalNode> list = [node];

    List<ElectricalNode> children = node.maybeMap(
      source: (n) => n.children,
      panel: (n) => n.children,
      protection: (n) => n.copyWith(children: []).children,
      orElse: () => [],
    );

    // For protection, we must access .children
    if (node is ProtectionNode) {
      children = node.children;
    }

    for (var child in children) {
      list.addAll(_flatten(child));
    }
    return list;
  }
}
