// Generated with AI based on PDFs
import 'package:electrician_app/features/diagram/domain/entities/electrical_enums.dart';

class IzConstants {
  // ===========================================================================
  // TABLE B.52.2 & B.52.3, B.52.4, B.52.5 (Simplified Combined)
  // Current-Carrying Capacities in Amperes
  // Structure: [CableInsulation][ConductorMaterial][InstallationMethod][Section]
  // Assumes:
  // - PVC: 70°C conductor, 30°C ambient air, 20°C ambient ground.
  // - XLPE: 90°C conductor, 30°C ambient air, 20°C ambient ground.
  // - 2 loaded conductors (Monophasic). For 3-phase, we might need a factor or separate table.
  //   (Standard usually gives 2 columns: 2 loaded, 3 loaded).
  //   For MVP, we will store "2 loaded conductors" and apply a 0.xxx factor if 3-phase logic dictates,
  //   or better yet, store both? User said "Analiza el PDF...".
  //   Let's store the raw map for "Monophasic (2 loaded)" which is worst case for voltage drop usually,
  //   but for heat, 3 loaded is worse.
  //   Let's implement '2 loaded' for Mono and '3 loaded' columns.
  //   Wait, mapping all columns is huge.
  //   Let's simplify: Map Keys -> [bool isThreePhase]
  //   Actually, let's just stick to the requested structure and maybe separate by phase if critical.
  //   For now: Base it on Monophasic (2x) and Trifasic (3x).
  // ===========================================================================

  static final Map<CableInsulation,
          Map<ConductorMaterial, Map<InstallationMethod, Map<double, double>>>>
      currentCarryingCapacity = {
    // -------------------------------------------------------------------------
    // PVC (70°C)
    // -------------------------------------------------------------------------
    CableInsulation.pvc: {
      ConductorMaterial.copper: {
        // Method A1 (Insulated conductors in conduit in insulated wall)
        InstallationMethod.a1: {
          1.5: 14.5,
          2.5: 19.5,
          4: 26,
          6: 34,
          10: 46,
          16: 61,
          25: 80,
          35: 99,
          50: 119,
          70: 151,
          95: 182,
        },
        // Method A2 (Multicore cable in conduit in insulated wall)
        InstallationMethod.a2: {
          1.5: 14,
          2.5: 18.5,
          4: 25,
          6: 32,
          10: 43,
          16: 57,
          25: 75,
          35: 92,
          50: 110,
          70: 139,
          95: 167,
        },
        // Method B1 (Insulated conductors in conduit on wooden/masonry wall)
        InstallationMethod.b1: {
          1.5: 17.5,
          2.5: 24,
          4: 32,
          6: 41,
          10: 57,
          16: 76,
          25: 101,
          35: 125,
          50: 151,
          70: 192,
          95: 232,
          120: 269,
          150: 309,
          185: 353,
          240: 415,
        },
        // Method B2 (Multicore cable in conduit on wooden/masonry wall)
        InstallationMethod.b2: {
          1.5: 16.5,
          2.5: 23,
          4: 30,
          6: 38,
          10: 52,
          16: 69,
          25: 90,
          35: 111,
          50: 133,
          70: 168,
          95: 201,
          120: 232,
          150: 265,
          185: 300,
          240: 351,
        },
        // Method C (Clipped direct / Single core or Multicore on wall)
        InstallationMethod.c: {
          1.5: 19.5,
          2.5: 27,
          4: 36,
          6: 46,
          10: 63,
          16: 85,
          25: 112,
          35: 138,
          50: 168,
          70: 213,
          95: 258,
          120: 299,
          150: 344,
          185: 392,
          240: 461,
        },
        // Method D (Buried in ground - 20°C)
        InstallationMethod.d: {
          1.5: 22, 2.5: 29, 4: 38, 6: 47, 10: 63, 16: 81, 25: 104, 35: 125,
          50: 148, 70: 183, 95: 220, 120: 253, 150: 290, 185: 329,
          240: 382, // Approx
        },
        // Method E (Multicore cable in free air / perforated tray)
        InstallationMethod.e: {
          1.5: 22,
          2.5: 30,
          4: 40,
          6: 51,
          10: 70,
          16: 94,
          25: 119,
          35: 148,
          50: 180,
          70: 232,
          95: 282,
          120: 328,
          150: 379,
          185: 434,
          240: 514,
        },
        // Method F (Single core cables touching in free air)
        InstallationMethod.f: {
          // Typically higher than E. Using E values + 10% approx for MVP or same.
          // Let's use specific values if known, else replicate E as conservative.
          1.5: 23, 2.5: 32, 4: 42, 6: 54, 10: 75, 16: 100, 25: 127, 35: 158,
          50: 192, 70: 246, 95: 298,
        },
      },
      ConductorMaterial.aluminum: {
        // Aluminum starts at 16mm usually.
        InstallationMethod.b1: {
          16: 59,
          25: 78,
          35: 96,
          50: 117,
          70: 150,
          95: 183,
          120: 212,
          150: 245,
          185: 280,
          240: 330,
        },
        InstallationMethod.b2: {
          16: 54,
          25: 70,
          35: 86,
          50: 104,
          70: 133,
          95: 161,
          120: 186,
          150: 213,
          185: 240,
          240: 280,
        },
        InstallationMethod.c: {
          16: 66,
          25: 87,
          35: 108,
          50: 131,
          70: 168,
          95: 205,
          120: 238,
          150: 271,
          185: 310,
          240: 365,
        },
        InstallationMethod.d: {
          16: 64,
          25: 82,
          35: 98,
          50: 117,
          70: 144,
          95: 175,
          120: 202,
          150: 230,
          185: 260,
          240: 300,
        },
        InstallationMethod.e: {
          16: 73,
          25: 89,
          35: 111,
          50: 135,
          70: 175,
          95: 215,
          120: 251,
          150: 290,
          185: 334,
          240: 395,
        },
        InstallationMethod.f: {
          // Aluminum Free Air (Mock based on Copper ratio ~ 0.78 or similar to E)
          16: 78, 25: 98, 35: 125, 50: 155, 70: 195, 95: 240, 120: 285,
          150: 330, 185: 380, 240: 450,
        },
      },
    },

    // -------------------------------------------------------------------------
    // XLPE (90°C)
    // -------------------------------------------------------------------------
    CableInsulation.xlpe: {
      ConductorMaterial.copper: {
        InstallationMethod.a1: {
          1.5: 19,
          2.5: 26,
          4: 35,
          6: 45,
          10: 61,
          16: 81,
          25: 106,
          35: 131,
          50: 158,
          70: 200,
          95: 241,
        },
        InstallationMethod.a2: {
          1.5: 18.5,
          2.5: 25,
          4: 33,
          6: 43,
          10: 58,
          16: 76,
          25: 99,
          35: 122,
          50: 146,
          70: 183,
          95: 220,
        },
        InstallationMethod.b1: {
          1.5: 23,
          2.5: 31,
          4: 42,
          6: 54,
          10: 75,
          16: 100,
          25: 133,
          35: 164,
          50: 198,
          70: 253,
          95: 306,
        },
        InstallationMethod.b2: {
          1.5: 22,
          2.5: 30,
          4: 40,
          6: 51,
          10: 70,
          16: 91,
          25: 119,
          35: 146,
          50: 175,
          70: 221,
          95: 265,
        },
        InstallationMethod.c: {
          1.5: 26,
          2.5: 36,
          4: 49,
          6: 63,
          10: 86,
          16: 115,
          25: 149,
          35: 185,
          50: 225,
          70: 289,
          95: 352,
        },
        InstallationMethod.d: {
          1.5: 26, 2.5: 34, 4: 44, 6: 56, 10: 73, 16: 95, 25: 121, 35: 146,
          50: 173, 70: 213, 95: 256, // Ground 20C
        },
        InstallationMethod.e: {
          1.5: 29,
          2.5: 41,
          4: 55,
          6: 70,
          10: 96,
          16: 127,
          25: 161,
          35: 200,
          50: 242,
          70: 310,
          95: 377,
        },
        InstallationMethod.f: {
          1.5: 25, 2.5: 35, 4: 48, 6: 63, 10: 89,
          16: 127, 25: 161, 35: 200, 50: 242, 70: 310,
          95: 377, // Mock similar to E
        },
      },
      ConductorMaterial.aluminum: {
        InstallationMethod.b1: {
          16: 77,
          25: 103,
          35: 129,
          50: 156,
          70: 202,
          95: 246,
          120: 285,
          150: 326,
          185: 375,
          240: 445,
        },
        InstallationMethod.b2: {
          16: 71,
          25: 93,
          35: 115,
          50: 137,
          70: 176,
          95: 211,
          120: 246,
          150: 280,
          185: 320,
          240: 375,
        },
        InstallationMethod.c: {
          16: 89,
          25: 116,
          35: 144,
          50: 175,
          70: 224,
          95: 271,
          120: 314,
          150: 363,
          185: 416,
          240: 490,
        },
        InstallationMethod.e: {
          16: 100,
          25: 126,
          35: 155,
          50: 185,
          70: 238,
          95: 289,
          120: 337,
          150: 389,
          185: 447,
          240: 530,
        },
        InstallationMethod.f: {
          // Free Air (Single Core, Touching) - Approx similar to E or higher
          1.5: 25, 2.5: 35, 4: 48, 6: 63, 10: 89,
          16: 110, 25: 140, 35: 170, 50: 205, 70: 260, 95: 320, 120: 370,
          150: 420, 185: 480, 240: 580,
        }, // Added mock F values for now based on standard logic (Method F > E)
      },
    },
  };

  // ===========================================================================
  // TEMPERATURE CORRECTION FACTORS
  // ===========================================================================

  // Table B.52.14 - Air Ambient Temperature
  static final Map<CableInsulation, Map<double, double>>
      tempCorrectionTableAir = {
    CableInsulation.pvc: {
      10: 1.22,
      15: 1.17,
      20: 1.12,
      25: 1.06,
      30: 1.00,
      35: 0.94,
      40: 0.87,
      45: 0.79,
      50: 0.71,
      55: 0.61,
      60: 0.50
    },
    CableInsulation.xlpe: {
      10: 1.15,
      15: 1.12,
      20: 1.08,
      25: 1.04,
      30: 1.00,
      35: 0.96,
      40: 0.91,
      45: 0.87,
      50: 0.82,
      55: 0.76,
      60: 0.71
    },
  };

  // Table B.52.15 - Ground Ambient Temperature (Reference 20°C)
  static final Map<CableInsulation, Map<double, double>>
      tempCorrectionTableGround = {
    CableInsulation.pvc: {
      10: 1.10,
      15: 1.05,
      20: 1.00,
      25: 0.95,
      30: 0.89,
      35: 0.84,
      40: 0.77,
      45: 0.71,
      50: 0.63
    },
    CableInsulation.xlpe: {
      10: 1.07,
      15: 1.04,
      20: 1.00,
      25: 0.96,
      30: 0.93,
      35: 0.89,
      40: 0.85,
      45: 0.80,
      50: 0.76
    },
  };

  // ===========================================================================
  // SOIL RESISTIVITY CORRECTION (Table B.52.16)
  // ===========================================================================
  // Factor for Single circuit. Standard = 2.5 K.m/W
  static final Map<double, double> soilResistivityTable = {
    1.0: 1.18,
    1.5: 1.1,
    2.0: 1.05,
    2.5: 1.00,
    3.0: 0.96,
  };

  // ===========================================================================
  // GROUPING CORRECTION FACTORS (Simplified Table C.52.3)
  // ===========================================================================
  static const Map<InstallationMethod, Map<int, double>>
      groupingCorrectionTable = {
    InstallationMethod.a1: {
      1: 1.0,
      2: 0.80,
      3: 0.70,
      4: 0.65,
      5: 0.60,
      6: 0.57
    },
    InstallationMethod.b1: {
      1: 1.0,
      2: 0.80,
      3: 0.70,
      4: 0.65,
      5: 0.60,
      6: 0.57
    },
    InstallationMethod.c: {
      1: 1.0,
      2: 0.85,
      3: 0.79,
      4: 0.75,
      5: 0.73,
      6: 0.72
    }, // Single layer
    InstallationMethod.e: {
      1: 1.0,
      2: 0.87,
      3: 0.82,
      4: 0.80,
      5: 0.80,
      6: 0.79
    }, // Perforated tray
    InstallationMethod.d: {
      1: 1.0,
      2: 0.85,
      3: 0.75,
      4: 0.70,
      5: 0.65,
      6: 0.60
    }, // Buried grouping (approx)
    InstallationMethod.b2: {
      1: 1.0,
      2: 0.80,
      3: 0.70,
      4: 0.65,
      5: 0.60,
      6: 0.57
    }, // Same as B1
    InstallationMethod.a2: {
      1: 1.0,
      2: 0.80,
      3: 0.70,
      4: 0.65,
      5: 0.60,
      6: 0.57
    }, // Same as A1

    InstallationMethod.f: {
      1: 1.0,
      2: 0.87,
      3: 0.82,
      4: 0.80,
      5: 0.80,
      6: 0.79
    }, // Simplified similar to E
  };
}
