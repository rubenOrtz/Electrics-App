import '../../domain/entities/protection_definition.dart';
import '../../domain/entities/electrical_enums.dart';

abstract class ProtectionPresetsDataSource {
  List<ProtectionDefinition> getProtections();
  ProtectionDefinition? match(
      ProtectionType type, double rating, String curve, double sens);
}

class ProtectionPresetsDataSourceImpl implements ProtectionPresetsDataSource {
  @override
  List<ProtectionDefinition> getProtections() {
    return const [
      // --- Magnetotérmicos (PIAs) ---
      ProtectionDefinition(
        id: "pia_10_c_2p",
        name: "PIA 10A Curva C (Alumbrado)",
        type: ProtectionType.circuitBreaker,
        ratingAmps: 10,
        poles: 2,
        curve: "C",
        breakingCapacityKa: 6.0,
        defaultCableSection: 1.5,
      ),
      ProtectionDefinition(
        id: "pia_16_c_2p",
        name: "PIA 16A Curva C (Fuerza General)",
        type: ProtectionType.circuitBreaker,
        ratingAmps: 16,
        poles: 2,
        curve: "C",
        breakingCapacityKa: 6.0,
        defaultCableSection: 2.5,
      ),
      ProtectionDefinition(
        id: "pia_20_c_2p",
        name: "PIA 20A Curva C (Potencia)",
        type: ProtectionType.circuitBreaker,
        ratingAmps: 20,
        poles: 2,
        curve: "C",
        breakingCapacityKa: 6.0,
        defaultCableSection: 4.0,
      ),
      ProtectionDefinition(
        id: "pia_25_c_2p",
        name: "PIA 25A Curva C (Horno/Inducción)",
        type: ProtectionType.circuitBreaker,
        ratingAmps: 25,
        poles: 2,
        curve: "C",
        breakingCapacityKa: 6.0,
        defaultCableSection: 6.0,
      ),
      ProtectionDefinition(
        id: "pia_32_c_2p",
        name: "PIA 32A Curva C",
        type: ProtectionType.circuitBreaker,
        ratingAmps: 32,
        poles: 2,
        curve: "C",
        breakingCapacityKa: 6.0,
        defaultCableSection: 6.0,
      ),
      ProtectionDefinition(
        id: "pia_40_c_2p",
        name: "PIA 40A Curva C",
        type: ProtectionType.circuitBreaker,
        ratingAmps: 40,
        poles: 2,
        curve: "C",
        breakingCapacityKa: 6.0,
        defaultCableSection: 10.0,
      ),

      // --- Diferenciales (IDs) ---
      ProtectionDefinition(
        id: "id_25_30_2p",
        name: "Diferencial 25A 30mA AC",
        type: ProtectionType.differential,
        ratingAmps: 25,
        poles: 2,
        sensitivityMa: 30,
        breakingCapacityKa: 6.0,
        defaultCableSection: 6.0,
      ),
      ProtectionDefinition(
        id: "id_40_30_2p",
        name: "Diferencial 40A 30mA AC",
        type: ProtectionType.differential,
        ratingAmps: 40,
        poles: 2,
        sensitivityMa: 30,
        breakingCapacityKa: 6.0,
        defaultCableSection: 10.0,
      ),
      ProtectionDefinition(
        id: "id_63_30_2p",
        name: "Diferencial 63A 30mA AC",
        type: ProtectionType.differential,
        ratingAmps: 63,
        poles: 2,
        sensitivityMa: 30,
        breakingCapacityKa: 6.0,
        defaultCableSection: 16.0,
      ),
      ProtectionDefinition(
        id: "id_40_30_2p_a",
        name: "Diferencial 40A 30mA Clase A (Superinmunizado)",
        type: ProtectionType.differential,
        ratingAmps: 40,
        poles: 2,
        sensitivityMa: 30,
        breakingCapacityKa: 6.0,
        defaultCableSection: 10.0,
      ),
    ];
  }

  @override
  ProtectionDefinition? match(
      ProtectionType type, double rating, String curve, double sens) {
    try {
      return getProtections().firstWhere((p) =>
          p.type == type &&
          p.ratingAmps == rating &&
          (type == ProtectionType.circuitBreaker
              ? p.curve == curve
              : p.sensitivityMa == sens));
    } catch (_) {
      return null;
    }
  }
}
