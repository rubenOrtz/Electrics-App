import '../entities/electrical_node.dart';
import '../entities/electrical_enums.dart';

/// Factory for creating ElectricalNode instances with standard REBT defaults.
///
/// **Purpose:** Encapsulates business rules for default electrical component values.
/// Removes hardcoded engineering specs from UI layer.
///
/// **Standards:** Spanish REBT (ITC-BT-15, ITC-BT-24)
/// - Default breaker: 16A (common residential circuit)
/// - Default differential: 40A, 30mA (Type A, general use)
/// - Default source: 230V, 10kA short-circuit
///
/// **Usage:**
/// ```dart
/// final factory = NodeFactory();
/// final breaker = factory.createDefaultBreaker();
/// final rcd = factory.createDefaultDifferential();
/// ```
class NodeFactory {
  // Standard REBT defaults
  static const double _defaultVoltage = 230.0; // Single-phase
  static const double _defaultBreakerRating = 16.0; // Amps
  static const double _defaultRcdRating = 40.0; // Amps
  static const double _defaultRcdSensitivity = 30.0; // mA
  static const double _defaultSourceIcc = 10000.0; // 10kA

  /// Creates a default circuit breaker (ITC-BT-15)
  ///
  /// **Default:** 16A (common residential circuit rating)
  ElectricalNode createDefaultBreaker({
    required String id,
    String name = 'PIA',
  }) {
    return ElectricalNode.protection(
      id: id,
      name: name,
      protectionType: ProtectionType.circuitBreaker,
      ratingAmps: _defaultBreakerRating,
      pdc: 6.0, // 6kA breaking capacity (standard residential)
      curve: 'C', // IEC 60898 Type C
      sensitivity: 0, // Not RCD
    );
  }

  /// Creates a default differential (RCD) (ITC-BT-24)
  ///
  /// **Default:** 40A, 30mA (general protection)
  ElectricalNode createDefaultDifferential({
    required String id,
    String name = 'Dif',
  }) {
    return ElectricalNode.protection(
      id: id,
      name: name,
      protectionType: ProtectionType.differential,
      ratingAmps: _defaultRcdRating,
      sensitivity: _defaultRcdSensitivity,
    );
  }

  /// Creates a default electrical source
  ///
  /// **Default:** 230V, 10kA (typical residential supply)
  ElectricalNode createDefaultSource({
    required String id,
    String name = 'Acometida',
  }) {
    return ElectricalNode.source(
      id: id,
      name: name,
      nominalVoltage: _defaultVoltage,
      shortCircuitCapacity: _defaultSourceIcc,
    );
  }

  /// Creates a default panel (switchboard)
  ElectricalNode createDefaultPanel({
    required String id,
    String name = 'Cuadro',
  }) {
    return ElectricalNode.panel(
      id: id,
      name: name,
    );
  }

  /// Creates a default load
  ///
  /// **Default:** 1000W power load, cosPhi varies by type
  ElectricalNode createDefaultLoad({
    required String id,
    String name = 'Carga',
    LoadType type = LoadType.power,
  }) {
    // cosPhi defaults by load type (REBT typical values)
    final double defaultCosPhi;
    switch (type) {
      case LoadType.lighting:
        defaultCosPhi = 1.0; // Resistive loads
        break;
      case LoadType.power:
        defaultCosPhi = 0.9; // Typical power outlets
        break;
      case LoadType.motor:
        defaultCosPhi = 0.8; // Inductive loads
        break;
    }

    return ElectricalNode.load(
      id: id,
      name: name,
      type: type,
      powerWatts: 1000.0, // 1kW default
      cosPhi: defaultCosPhi,
      isThreePhase: false,
    );
  }
}
