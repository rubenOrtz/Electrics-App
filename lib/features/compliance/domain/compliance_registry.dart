import 'entities/compliance_base.dart';
import 'standards/rebt_rules.dart';

class ComplianceRegistry {
  static final List<RegulatoryStandard> _standards = [
    RebtSpainStandard(),
    // TODO: IecStandard(),
  ];

  static List<RegulatoryStandard> get all => _standards;

  static RegulatoryStandard getStandard(String? id) {
    if (id == null) return _standards.first;
    return _standards.firstWhere(
      (s) => s.id == id,
      orElse: () => _standards.first,
    );
  }
}
