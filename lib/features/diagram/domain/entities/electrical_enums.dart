/// Defines the type of voltage for an electrical node.
enum VoltageType {
  acMonophasic,
  acTriphasic,
  dc;

  String get label {
    switch (this) {
      case VoltageType.acMonophasic:
        return 'AC Monofásico';
      case VoltageType.acTriphasic:
        return 'AC Trifásico';
      case VoltageType.dc:
        return 'DC (Corriente Continua)';
    }
  }
}

/// Defines the material of the conductor.
enum ConductorMaterial {
  copper,
  aluminum;

  String get label {
    switch (this) {
      case ConductorMaterial.copper:
        return 'Cobre';
      case ConductorMaterial.aluminum:
        return 'Aluminio';
    }
  }
}

/// Defines the insulation type of the cable.
enum CableInsulation {
  pvc,
  xlpe,
  z1;

  String get label {
    switch (this) {
      case CableInsulation.pvc:
        return 'PVC';
      case CableInsulation.xlpe:
        return 'XLPE';
      case CableInsulation.z1:
        return 'Z1 (Libre de Halógenos)';
    }
  }

  double get maxTemperature {
    switch (this) {
      case CableInsulation.pvc:
        return 70.0;
      case CableInsulation.xlpe:
      case CableInsulation.z1:
        return 90.0;
    }
  }
}

/// Defines the type of protection device.
enum ProtectionType {
  circuitBreaker, // Magnetotérmico
  differential, // Diferencial
  fuse, // Fusible
  surgeProtection // Sobretensiones
}

/// Defines the type of load connected to the circuit.
enum LoadType { lighting, power, motor }

/// Defines the installation method according to IEC 60364-5-52.
enum InstallationMethod {
  a1, // Conductores aislados en tubo en pared aislante
  a2, // Cable multiconductor en tubo en pared aislante
  b1, // Conductores aislados en tubo sobre pared de madera/mampostería
  b2, // Cable multiconductor en tubo sobre pared de madera/mampostería
  c, // Directamente sobre pared / mampostería
  d, // Enterrado (Buried)
  e, // Al aire libre (Bandeja perforada, etc.)
  f; // Al aire libre (Bandeja, contacto, etc.)

  String get label {
    switch (this) {
      case InstallationMethod.a1:
        return 'A1: Tubo empotrado (Aislado)';
      case InstallationMethod.a2:
        return 'A2: Tubo empotrado (Multiconductor)';
      case InstallationMethod.b1:
        return 'B1: Tubo superficie';
      case InstallationMethod.b2:
        return 'B2: Tubo superficie (Multiconductor)';
      case InstallationMethod.c:
        return 'C: Directo sobre pared';
      case InstallationMethod.d:
        return 'D: Enterrado'; // Ground
      case InstallationMethod.e:
        return 'E: Aire libre (Bandeja perforada)';
      case InstallationMethod.f:
        return 'F: Aire libre (Bandeja vertical/contacto)';
    }
  }

  bool get isBuried => this == InstallationMethod.d;
}

/// Helper class to hold correction factors for Iz calculation.
class CorrectionFactors {
  /// Ambient temperature in °C.
  /// Default: 30°C for Air, 20°C for Ground.
  final double ambientTemperature;

  /// Number of circuits bundled together.
  /// Default: 1 (Single circuit, no grouping).
  final int numberOfCircuits;

  /// Soil thermal resistivity (only for buried).
  /// Default: 2.5 K·m/W (Standard).
  final double soilResistivity;

  const CorrectionFactors({
    this.ambientTemperature = 30.0,
    this.numberOfCircuits = 1,
    this.soilResistivity = 2.5,
  });

  /// Factory for ground installations with different default temperature
  factory CorrectionFactors.ground({
    double ambientTemperature = 20.0,
    int numberOfCircuits = 1,
    double soilResistivity = 2.5,
  }) {
    return CorrectionFactors(
      ambientTemperature: ambientTemperature,
      numberOfCircuits: numberOfCircuits,
      soilResistivity: soilResistivity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ambientTemperature': ambientTemperature,
      'numberOfCircuits': numberOfCircuits,
      'soilResistivity': soilResistivity,
    };
  }

  factory CorrectionFactors.fromJson(Map<String, dynamic> json) {
    return CorrectionFactors(
      ambientTemperature:
          (json['ambientTemperature'] as num?)?.toDouble() ?? 30.0,
      numberOfCircuits: (json['numberOfCircuits'] as num?)?.toInt() ?? 1,
      soilResistivity: (json['soilResistivity'] as num?)?.toDouble() ?? 2.5,
    );
  }
}
