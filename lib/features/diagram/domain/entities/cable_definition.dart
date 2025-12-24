import 'electrical_enums.dart';

class CableDefinition {
  final String id;
  final String name;
  final String description;
  final ConductorMaterial material;
  final CableInsulation insulation;
  final double maxTemp;
  final bool isFlexible;

  const CableDefinition({
    required this.id,
    required this.name,
    required this.description,
    required this.material,
    required this.insulation,
    required this.maxTemp,
    required this.isFlexible,
  });
}
