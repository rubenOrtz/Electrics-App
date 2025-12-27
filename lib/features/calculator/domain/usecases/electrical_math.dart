import 'dart:math';
import '../entities/conductor.dart';

class ElectricalMath {
  // Constantes de Resistividad a 20°C (Ω·mm²/m)
  static const double rhoCopper = 0.01724;
  static const double rhoAluminum = 0.02826;

  /// Calculates Voltage Drop (Caída de Tensión) in Volts
  /// Uses precise Resistivity formula: ΔU = (k * ρ * L * I) / S
  static double calculateVoltageDrop({
    required double length,
    required double current,
    required double section,
    required ConductorMaterial material,
    required ConductorInsulation insulation,
    required VoltageSystem system,
    double cosinePhi = 1.0,
  }) {
    // 1. Seleccionar Resistividad (ρ) según material
    double rho;
    if (material == ConductorMaterial.copper) {
      rho = rhoCopper;
    } else {
      rho = rhoAluminum;
    }

    // 2. Seleccionar Coeficiente (K)
    // Monofásica = 2 (Ida + Vuelta)
    double k;
    if (system == VoltageSystem.singlePhase) {
      k = 2.0;
    } else {
      k = sqrt(3);
    }

    // 3. Physics Formula
    // e = (k * ρ * L * I) / S
    return (k * rho * length * current) / section;
  }

  /// Calculates Voltage Drop Percentage (%)
  static double calculateVoltageDropPercentage({
    required double dropVolts,
    required double nominalVoltage,
  }) {
    if (nominalVoltage == 0) return 0.0;
    return (dropVolts / nominalVoltage) * 100.0;
  }

  /// Calculates Current (Amperes) from Power (Watts)
  /// I = P / (V * cosφ) Monofásica
  static double calculateCurrent({
    required double powerWatts,
    required double voltage,
    required VoltageSystem system,
    double powerFactor = 1.0,
  }) {
    if (voltage == 0) return 0;
    double pf = powerFactor <= 0 ? 1.0 : powerFactor;

    if (system == VoltageSystem.singlePhase) {
      // Fórmula Sagrada Monofásica: I = P / (V * cosPhi)
      return powerWatts / (voltage * pf);
    } else {
      // Fórmula Trifásica: I = P / (√3 * V * cosPhi)
      return powerWatts / (sqrt(3) * voltage * pf);
    }
  }
}
