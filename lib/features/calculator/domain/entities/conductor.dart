enum ConductorMaterial { copper, aluminum }

enum ConductorInsulation {
  pvc, // 70°C thermoplastic
  xlpe, // 90°C thermosetting
  lshf // Low Smoke Halogen Free (polyolefin), usually treated as 90°C similar to XLPE or 70°C depending on specific type
}

enum VoltageSystem {
  singlePhase, // 230V
  threePhase // 400V
}

extension MaterialConductivity on ConductorMaterial {
  // REBT conductivity at standard temperatures (PVC 70C, XLPE 90C)
  // These are 'Gamma' values

  double getConductivity(ConductorInsulation insulation) {
    if (this == ConductorMaterial.copper) {
      if (insulation == ConductorInsulation.pvc) return 48.0;
      return 44.0; // XLPE/EPR
    } else {
      // Aluminum
      if (insulation == ConductorInsulation.pvc) return 30.0;
      return 28.0; // XLPE/EPR
    }
  }
}
