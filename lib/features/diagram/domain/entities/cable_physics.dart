import 'dart:math';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cable_physics.freezed.dart';

enum CableMaterial { copper, aluminum }

enum InstallationMethod {
  underPlaster,
  inAir,
  underground,
  inCableduct,
}

@freezed
class CablePhysics with _$CablePhysics {
  const factory CablePhysics({
    required double section,
    @Default(CableMaterial.copper) CableMaterial material,
    required double length,

    /// Temperatura máxima del conductor (70°C PVC, 90°C XLPE)
    @Default(70.0) double temperatureRating,
    @Default(25.0) double ambientTemp,
    @Default(1.0) double groupingFactor,
    @Default(InstallationMethod.underPlaster)
    InstallationMethod installationMethod,
    @Default(0.0) double baseCurrentCapacity,
  }) = _CablePhysics;

  const CablePhysics._();

  // --- CONSTANTES FÍSICAS UNIFICADAS ---

  /// Resistividad base a 20°C (Ω·mm²/m)
  /// Alineado con ElectricalMath: IEC Standard Annealed Copper
  double get baseResistivity {
    switch (material) {
      case CableMaterial.copper:
        return 0.017241; // (Equivale aprox a 1/58) - Estándar Internacional
      case CableMaterial.aluminum:
        return 0.028264; // Estándar Internacional
    }
  }

  /// Coeficiente de temperatura (1/°C)
  double get temperatureCoefficient {
    switch (material) {
      case CableMaterial.copper:
        return 0.00393;
      case CableMaterial.aluminum:
        return 0.00403;
    }
  }

  // --- CÁLCULOS DE RESISTENCIA ---

  /// Resistencia a 20°C
  /// Usada para: Cálculo de Icc MÁXIMA (en frío, principio de línea)
  double get resistanceAt20C {
    if (section <= 0) return double.infinity;
    return (baseResistivity * length) / section;
  }

  /// Resistencia a Temperatura Máxima de Servicio (70°C / 90°C)
  /// Usada para: Cálculo de CAÍDA DE TENSIÓN y Icc MÍNIMA (seguridad)
  double get resistanceAtMaxTemp {
    if (section <= 0) return double.infinity;

    // Fórmula: R_t = R_20 * (1 + alpha * (T_max - 20))
    // Esto aumenta la resistencia un ~20% respecto a frío
    final rhoTemp = baseResistivity *
        (1 + temperatureCoefficient * (temperatureRating - 20.0));

    return (rhoTemp * length) / section;
  }

  // Por defecto, para cálculos de seguridad (caída tensión), usamos la resistencia en caliente
  double get resistance => resistanceAtMaxTemp;

  // --- CÁLCULOS DE REACTANCIA E IMPEDANCIA ---

  /// Reactancia inductiva (X)
  /// Solo significativa en secciones grandes (>16mm2)
  double get reactance {
    if (section < 16.0) return 0.0;
    // Valor medio típico: 0.08 mΩ/m
    return 0.00008 * length;
  }

  /// Impedancia total (Z) en caliente
  double get impedance {
    final R = resistanceAtMaxTemp;
    final X = reactance;
    return sqrt(R * R + X * X);
  }

  // --- CAPACIDAD DE CORRIENTE (Iz) ---

  double get temperatureCorrectionFactor {
    final tempDiff =
        ambientTemp - 25.0; // Asumiendo base 25°C (aire) o 20°C (tierra)
    if (tempDiff <= 0) return 1.0;
    // Reducción conservadora
    final reduction = tempDiff * 0.008;
    return (1.0 - reduction).clamp(0.5, 1.0);
  }

  double get currentCapacity {
    if (baseCurrentCapacity == 0.0) {
      return _estimateCurrentCapacity();
    }
    return baseCurrentCapacity * temperatureCorrectionFactor * groupingFactor;
  }

  /// Tabla de respaldo simplificada (IEC 60364-5-52 aprox, PVC Cobre)
  double _estimateCurrentCapacity() {
    final Map<double, double> estimates = {
      1.5: 13.5, // Aprox B1 2 conductores
      2.5: 18.0,
      4.0: 24.0,
      6.0: 31.0,
      10.0: 42.0,
      16.0: 56.0,
      25.0: 73.0,
      35.0: 89.0,
      50.0: 108.0,
    };

    // Algoritmo de búsqueda exacto o "nearest neighbor" superior
    // Si section es 1.5 devuelve 13.5.
    return estimates[section] ?? (section * 4.0); // Fallback seguro
  }
}
