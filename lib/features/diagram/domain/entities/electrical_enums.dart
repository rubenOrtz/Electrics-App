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
