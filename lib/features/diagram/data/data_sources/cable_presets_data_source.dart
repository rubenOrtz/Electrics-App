import '../../domain/entities/cable_definition.dart';
import '../../domain/entities/electrical_enums.dart';

abstract class CablePresetsDataSource {
  List<CableDefinition> getCables();
}

class CablePresetsDataSourceImpl implements CablePresetsDataSource {
  @override
  List<CableDefinition> getCables() {
    return const [
      CableDefinition(
        id: "h07v-k",
        name: "H07V-K",
        description:
            "Cable unipolar flexible sin cubierta (marron|azul|tierra)",
        material: ConductorMaterial.copper,
        insulation: CableInsulation.pvc,
        maxTemp: 70,
        isFlexible: true,
      ),
      CableDefinition(
        id: "h07z1-k",
        name: "H07Z1-K (AS)",
        description:
            "Cable libre de halógenos, obligatorio en pública concurrencia",
        material: ConductorMaterial.copper,
        insulation: CableInsulation.z1,
        maxTemp:
            70, // Z1 termoplástico is usually 70, though some compounds exist. Let's assume 70 for standard H07Z1-K.
        // Correction: H07Z1-K is thermoplastic, usually 70ºC.
        // RZ1-K is thermosetting (90ºC).
        isFlexible: true,
      ),
      CableDefinition(
        id: "rv-k",
        name: "RV-K",
        description:
            "Cable multiconductor flexible con cubierta PVC (Industrial/Exterior)",
        material: ConductorMaterial.copper,
        insulation:
            CableInsulation.xlpe, // Actually XLPE insulation, PVC sheath
        maxTemp: 90,
        isFlexible: true,
      ),
      CableDefinition(
        id: "rz1-k",
        name: "RZ1-K (AS)",
        description:
            "Cable verde, libre de halógenos, flexible (Línea General)",
        material: ConductorMaterial.copper,
        insulation: CableInsulation.xlpe, // XLPE/Z1 mix, usually 90C
        maxTemp: 90,
        isFlexible: true,
      ),
      CableDefinition(
        id: "vv-k",
        name: "VV-K",
        description: "Manguera PVC convencional 0.6/1kV",
        material: ConductorMaterial.copper,
        insulation: CableInsulation.pvc,
        maxTemp: 70,
        isFlexible: true,
      ),
    ];
  }
}
