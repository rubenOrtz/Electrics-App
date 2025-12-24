/// Electrical engineering constants for calculations and validation
/// Based on REBT (Spanish Low Voltage Electrical Regulations) and IEC standards
class ElectricalConstants {
  const ElectricalConstants._();

  // ============================================================================
  // PROTECTION
  // ============================================================================

  /// Default breaking capacity in kA (kiloamperes)
  /// Used when protection device doesn't specify Pdc
  static const double defaultBreakingCapacityKA = 6.0;

  /// Default simultaneity factor (diversity factor)
  /// Ks = 1.0 means all loads operate simultaneously
  static const double defaultSimultaneityFactor = 1.0;

  // ============================================================================
  // VOLTAGE DROP LIMITS (REBT ITC-BT-19)
  // ============================================================================

  /// Maximum voltage drop for power circuits (%) - REBT
  /// Applies to motor and power loads
  static const double voltageDropLimitForce = 5.0;

  /// Maximum voltage drop for lighting circuits (%) - REBT
  /// More restrictive to prevent flickering
  static const double voltageDropLimitLighting = 3.0;

  /// Default voltage drop limit when load type is unknown
  static const double voltageDropLimitDefault = 5.0;

  // ============================================================================
  // MAGNETIC TRIP MULTIPLIERS (IEC 60898)
  // ============================================================================

  /// Curve B: Instantaneous trip at 3-5 times In
  /// Used for long cables and sensitive loads
  static const double curveB_magneticMultiplier = 5.0;

  /// Curve C: Instantaneous trip at 5-10 times In
  /// Standard for general purpose (most common)
  static const double curveC_magneticMultiplier = 10.0;

  /// Curve D: Instantaneous trip at 10-20 times In
  /// Used for inductive loads (motors, transformers)
  static const double curveD_magneticMultiplier = 20.0;

  // ============================================================================
  // SHORT CIRCUIT CALCULATION
  // ============================================================================

  /// Transformer impedance factor (resistance ratio)
  /// Typically R = 0.2 * Z for distribution transformers
  static const double transformerResistanceRatio = 0.2;

  /// Transformer impedance factor (reactance ratio)
  /// Typically X = 0.98 * Z (derived from Pythagorean theorem)
  static const double transformerReactanceRatio = 0.98;

  /// Minimum short circuit current reduction factor
  /// IccMin = IccMax * 0.8 (conservative estimate for end-of-line)
  static const double minShortCircuitFactor = 0.8;

  // ============================================================================
  // STANDARD VOLTAGES (V)
  // ============================================================================

  /// Single-phase nominal voltage (230V in EU)
  static const double nominalVoltageSinglePhase = 230.0;

  /// Three-phase nominal voltage line-to-line (400V in EU)
  static const double nominalVoltageThreePhase = 400.0;

  /// Voltage tolerance (+10% / -10% per REBT)
  static const double voltageTolerance = 0.10;

  // ============================================================================
  // CABLE CURRENT CAPACITY (Iz) - Simplified estimates
  // ============================================================================

  /// Current capacity estimates for Cu, PVC, under conduit (UNE 20-460)
  /// Map: section (mm²) → current capacity (A)
  static final Map<double, double> cableCurrentCapacity = {
    1.5: 13.5,
    2.5: 18.0,
    4.0: 25.0,
    6.0: 32.0,
    10.0: 44.0,
    16.0: 61.0,
    25.0: 80.0,
    35.0: 100.0,
    50.0: 119.0,
    70.0: 151.0,
    95.0: 182.0,
    120.0: 210.0,
    150.0: 240.0,
    185.0: 275.0,
    240.0: 320.0,
  };

  // ============================================================================
  // CONDUCTOR PROPERTIES
  // ============================================================================

  /// Copper resistivity at 20°C (Ω·mm²/m)
  static const double copperResistivity = 0.01724;

  /// Aluminum resistivity at 20°C (Ω·mm²/m)
  static const double aluminumResistivity = 0.02826;

  /// Temperature coefficient for copper (per °C)
  static const double copperTempCoefficient = 0.00393;

  /// Temperature coefficient for aluminum (per °C)
  static const double aluminumTempCoefficient = 0.00403;

  // ============================================================================
  // POWER FACTOR
  // ============================================================================

  /// Minimum power factor for clamping (avoid division by zero)
  static const double minPowerFactor = 0.1;

  /// Maximum power factor
  static const double maxPowerFactor = 1.0;

  /// Typical power factor for resistive loads (lighting)
  static const double powerFactorResistive = 1.0;

  /// Typical power factor for inductive loads (motors)
  static const double powerFactorInductive = 0.8;

  // ============================================================================
  // SAFETY FACTORS
  // ============================================================================

  /// Safety factor for cable selection (typically 1.25x)
  static const double cableSafetyFactor = 1.25;

  /// Safety factor for protection selection
  static const double protectionSafetyFactor = 1.25;

  // ============================================================================
  // HELPERS
  // ============================================================================

  /// Get magnetic trip multiplier based on curve type
  static double magneticMultiplier(String curve) {
    switch (curve.toUpperCase()) {
      case 'B':
        return curveB_magneticMultiplier;
      case 'C':
        return curveC_magneticMultiplier;
      case 'D':
        return curveD_magneticMultiplier;
      default:
        return curveC_magneticMultiplier; // Default to C
    }
  }

  /// Get voltage drop limit based on load type
  static double voltageDropLimit({required bool isLighting}) {
    return isLighting ? voltageDropLimitLighting : voltageDropLimitForce;
  }

  /// Estimate cable current capacity from section
  /// Returns closest match from standard table
  static double estimateCurrentCapacity(double sectionMm2) {
    // Find closest standard section
    double closestSection = cableCurrentCapacity.keys.first;
    double minDiff = (sectionMm2 - closestSection).abs();

    for (final section in cableCurrentCapacity.keys) {
      final diff = (sectionMm2 - section).abs();
      if (diff < minDiff) {
        minDiff = diff;
        closestSection = section;
      }
    }

    return cableCurrentCapacity[closestSection] ?? 20.0;
  }

  /// Calculate required cable section for given current
  /// Returns first standard section that can handle the current
  static double requiredSection(double current) {
    for (final entry in cableCurrentCapacity.entries) {
      if (entry.value >= current) {
        return entry.key;
      }
    }
    return 240.0; // Maximum available
  }
}
