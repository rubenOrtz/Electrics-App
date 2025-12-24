import '../entities/conductor.dart';

enum InstallationMethod {
  b1, // Tube in wall
  b2, // Tube on surface
  c, // Direct on surface
  e, // Perforated tray
  d // Underground (direct buried) -- simplified
}

class CableService {
  // Simplified Table: Max Current (A) for Copper, PVC (70C), 3 loaded conductors (Three-phase)
  // Based on IEC 60364-5-52 Table B.52.4 (Simulated for MVP)
  // [Section (mm2): Current (A)]
  static final Map<double, double> copperPvc3PhMethodB2 = {
    1.5: 15.5,
    2.5: 21,
    4.0: 28,
    6.0: 36,
    10.0: 50,
    16.0: 68,
    25.0: 89,
    35.0: 110,
    50.0: 134,
    70.0: 171,
    95.0: 207,
    120.0: 239,
  };

  // Simplified Table: Max Current (A) for Aluminum, XLPE (90C), 3 loaded conductors
  // Based on equivalents
  static final Map<double, double> aluXlpe3PhMethodB2 = {
    10.0:
        0, // Al usually starts at 16 or larger for practical building wiring, but let's say 0 for invalid
    16.0: 59,
    25.0: 77,
    35.0: 95,
    50.0: 115,
    70.0: 149,
    95.0: 180,
  };

  /// Returns the maximum admissible current (Ampacity / Iz) in Amperes
  /// Returns 0.0 if not found
  Future<double> getMaxCurrent({
    required ConductorMaterial material,
    required ConductorInsulation insulation,
    required InstallationMethod method,
    required double section,
    bool threePhase =
        true, // If false, assume single phase (2 loaded conductors) -> usually higher current allowed
  }) async {
    if (method != InstallationMethod.b2) {}

    if (material == ConductorMaterial.copper &&
        insulation == ConductorInsulation.pvc) {
      return copperPvc3PhMethodB2[section] ?? 0.0;
    }

    if (material == ConductorMaterial.aluminum &&
        insulation == ConductorInsulation.xlpe) {
      return aluXlpe3PhMethodB2[section] ?? 0.0;
    }

    // Default Fallbacks (Approximations)
    return 0.0;
  }

  /// Helper to get next standard section
  double getNextStandardSection(double minCurrent, ConductorMaterial material,
      ConductorInsulation insulation, InstallationMethod method) {
    final map = (material == ConductorMaterial.copper)
        ? copperPvc3PhMethodB2
        : aluXlpe3PhMethodB2;

    for (var entry in map.entries) {
      if (entry.value >= minCurrent) {
        return entry.key;
      }
    }
    return 0.0;
  }
}
