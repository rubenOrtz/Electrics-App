import '../../../diagram/domain/entities/electrical_enums.dart';

/// Domain service for electrical validation according to REBT/IEC standards.
/// Encapsulates business rules for voltage drops, impedance limits, and protection coordination.
///
/// **Architecture:** Singleton pattern for easy testing and dependency injection.
/// **Usage:**
/// ```dart
/// final service = ElectricalValidationService();
/// final error = service.validateVoltageDrop(...);
/// ```
///
/// **Testing:** Can be mocked by creating a test implementation of this class.
class ElectricalValidationService {
  // Singleton instance
  static final ElectricalValidationService _instance =
      ElectricalValidationService._internal();

  /// Factory constructor returns singleton instance
  factory ElectricalValidationService() => _instance;

  /// Private constructor for singleton pattern
  ElectricalValidationService._internal();

  // REBT Voltage Drop Limits (Interior Installations)
  // Note: Different limits apply for sub-main lines (Acometidas)
  static const double _lightingDropPercent = 0.03; // 3% for lighting
  static const double _powerDropPercent = 0.05; // 5% for power loads

  // Standard nominal voltage
  static const double _nominalVoltage = 230.0; // Single-phase

  // Impedance thresholds
  static const double _maxImpedanceWarning = 200.0; // Ohms

  /// Validates voltage drop for a given load type.
  /// Returns error message if invalid, null if valid.
  ///
  /// **Context:** These limits are for interior installations per REBT.
  String? validateVoltageDrop({
    required double measuredVoltage,
    required LoadType loadType,
    double nominalVoltage = _nominalVoltage,
  }) {
    final allowedDropPercent = _getAllowedDropPercent(loadType);
    final minVoltage = nominalVoltage * (1 - allowedDropPercent);
    final maxVoltage = nominalVoltage * 1.10; // +10% tolerance

    if (measuredVoltage < minVoltage) {
      return "Caída > ${(allowedDropPercent * 100).toStringAsFixed(0)}% (<${minVoltage.toStringAsFixed(1)}V)";
    }

    if (measuredVoltage > maxVoltage) {
      return "Sobretensión (>${maxVoltage.toStringAsFixed(1)}V)";
    }

    return null;
  }

  /// Validates loop impedance (Zs).
  /// Returns error message if invalid, null if valid.
  String? validateLoopImpedance(double impedance) {
    if (impedance <= 0) {
      return "Inválido (<=0)";
    }

    if (impedance > _maxImpedanceWarning) {
      return "Verificar (>${_maxImpedanceWarning.toStringAsFixed(0)}Ω)";
    }

    return null;
  }

  /// Validates RCD trip current against sensitivity.
  /// Returns error message if invalid, null if valid.
  String? validateRcdTripCurrent({
    required double tripCurrent,
    required double sensitivity,
  }) {
    if (tripCurrent > sensitivity) {
      return "Fallo >${sensitivity.toStringAsFixed(0)}mA";
    }

    return null;
  }

  /// Validates RCD trip time.
  /// Returns error message if invalid, null if valid.
  String? validateRcdTripTime(double tripTime) {
    const maxTripTime = 300.0; // milliseconds

    if (tripTime > maxTripTime) {
      return "Fallo >${maxTripTime.toStringAsFixed(0)}ms";
    }

    return null;
  }

  /// Validates contact voltage (touch voltage).
  /// Returns error message if invalid, null if valid.
  String? validateContactVoltage(double voltage) {
    const maxSafeVoltage = 50.0; // V

    if (voltage > maxSafeVoltage) {
      return "Peligro >${maxSafeVoltage.toStringAsFixed(0)}V";
    }

    return null;
  }

  /// Gets the allowed voltage drop percentage for a load type.
  double _getAllowedDropPercent(LoadType loadType) {
    switch (loadType) {
      case LoadType.lighting:
        return _lightingDropPercent;
      case LoadType.power:
      case LoadType.motor:
        return _powerDropPercent;
    }
  }

  /// Gets minimum acceptable voltage for a load type.
  double getMinVoltage({
    required LoadType loadType,
    double nominalVoltage = _nominalVoltage,
  }) {
    final dropPercent = _getAllowedDropPercent(loadType);
    return nominalVoltage * (1 - dropPercent);
  }

  /// Gets maximum acceptable voltage.
  double getMaxVoltage({double nominalVoltage = _nominalVoltage}) {
    return nominalVoltage * 1.10;
  }
}
