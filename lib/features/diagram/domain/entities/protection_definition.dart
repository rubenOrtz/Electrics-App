import 'electrical_enums.dart';

class ProtectionDefinition {
  final String id;
  final String name;
  final ProtectionType type;
  final double ratingAmps;
  final int poles;
  final String curve;
  final double sensitivityMa;
  final double breakingCapacityKa;
  final double? defaultCableSection; // Sección por defecto en mm²

  const ProtectionDefinition({
    required this.id,
    required this.name,
    required this.type,
    this.ratingAmps = 16.0,
    this.poles = 2,
    this.curve = "C",
    this.sensitivityMa = 30.0,
    this.breakingCapacityKa = 6.0,
    this.defaultCableSection,
  });
}
