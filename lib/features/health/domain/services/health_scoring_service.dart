import '../entities/field_measurement.dart';
import '../entities/installation_health.dart';
import '../../../diagram/domain/entities/electrical_node.dart';
import '../../../diagram/domain/services/tree_utilities.dart';
import 'dart:math';

/// Servicio que calcula la puntuación de salud de la instalación (0-100)
/// comparando cálculos teóricos con mediciones reales de campo.
class HealthScoringService {
  /// Calcula el estado de salud de toda la instalación
  InstallationHealth calculateHealth(
    ElectricalNode root,
    Map<String, FieldMeasurement> measurements,
  ) {
    int score = 100;
    int criticalCount = 0;
    int warningCount = 0;
    int verificationFailures = 0;

    // 1. Contar errores y warnings teóricos del ValidationEngine
    _traverseAndCountErrors(root, (errors, warnings) {
      criticalCount += errors;
      warningCount += warnings;
    });

    // Aplicar penalizaciones teóricas
    score -= (criticalCount * 25); // -25pts por error crítico
    score -= (warningCount * 5); // -5pts por warning

    // 2. Comparar mediciones vs cálculos (Teoría vs Realidad)
    final nodes = TreeUtilities.flattenElectricalNodes(root);
    for (var node in nodes) {
      final measurement = measurements[node.id];
      if (measurement != null) {
        final deviation = _compareTheoryVsReality(node, measurement);

        // Voltage deviations
        if (deviation.isVoltageCritical) {
          criticalCount++;
          score -= 20;
          verificationFailures++;
        } else if (deviation.isVoltageWarning) {
          warningCount++;
          score -= 10;
        }

        // Loop impedance anomaly (muy grave - conexión defectuosa)
        if (deviation.isLoopImpedanceCritical) {
          criticalCount++;
          score -= 30;
          verificationFailures++;
        }

        // RCD trip time failure
        if (deviation.isRcdFailed) {
          criticalCount++;
          score -= 25;
          verificationFailures++;
        }

        // Earth resistance failure
        if (deviation.isEarthFailed) {
          criticalCount++;
          score -= 20;
          verificationFailures++;
        }

        // Insulation resistance failure
        if (deviation.isInsulationFailed) {
          criticalCount++;
          score -= 30; // Critical safety issue
          verificationFailures++;
        }
      }
    }

    // Clamp score to 0-100
    score = max(0, min(100, score));

    return InstallationHealth(
      score: score,
      criticalCount: criticalCount,
      warningCount: warningCount,
      verificationFailures: verificationFailures,
      securityLevel: _classifySecurityLevel(score, criticalCount),
      complianceStatus: _classifyCompliance(criticalCount, warningCount),
      lastCalculated: DateTime.now(),
    );
  }

  /// Recorre el árbol contando errores y warnings
  void _traverseAndCountErrors(
    ElectricalNode node,
    void Function(int errors, int warnings) callback,
  ) {
    final result = node.result;
    if (result != null) {
      final errors = result.errors.length;
      final warnings = result.warnings.length;
      callback(errors, warnings);
    }

    node.map(
      source: (s) {
        for (var child in s.children) {
          _traverseAndCountErrors(child, callback);
        }
      },
      panel: (p) {
        for (var child in p.children) {
          _traverseAndCountErrors(child, callback);
        }
      },
      protection: (p) {
        for (var child in p.children) {
          _traverseAndCountErrors(child, callback);
        }
      },
      load: (_) {},
    );
  }



  /// Compara mediciones reales vs cálculos teóricos
  /// Compara mediciones reales vs cálculos teóricos
  _MeasurementDeviation _compareTheoryVsReality(
    ElectricalNode node,
    FieldMeasurement measurement,
  ) {
    bool isVoltageCritical = false;
    bool isVoltageWarning = false;
    bool isLoopImpedanceCritical = false;
    bool isRcdFailed = false;
    bool isEarthFailed = false;
    bool isInsulationFailed = false;

    final result = node.result;

    measurement.map(source: (m) {
      if (m.voltageLN != null && result != null) {
        final calculatedV = 230.0 - result.voltageDrop;
        final dev = ((m.voltageLN! - calculatedV).abs() / calculatedV) * 100;
        if (dev > 10) {
          isVoltageCritical = true;
        } else if (dev > 5) {
          isVoltageWarning = true;
        }
      }
    }, rcd: (m) {
      // ITC-BT-24: Max 300ms for 30mA (General)
      if (m.tripTimeMs != null && m.tripTimeMs! > 300) {
        isRcdFailed = true;
      }
      // Mechanical Test
      if (m.mechanicalTestPassed == false) {
        isRcdFailed = true;
      }
    }, insulation: (m) {
      // R < 0.5 MΩ -> Critical
      if (m.resistancePhaseEarth != null && m.resistancePhaseEarth! < 0.5) {
        isInsulationFailed = true;
      }
      if (m.resistancePhaseNeutral != null && m.resistancePhaseNeutral! < 0.5) {
        isInsulationFailed = true;
      }
    }, load: (m) {
      // Zs validation
      if (m.loopImpedanceZs != null && result != null) {
        final theoreticalZ = result.loopImpedance;
        // If measured Zs is significantly higher than theoretical (>50% deviation)
        // It implies potential disconnection or high resistance fault
        final dev = ((m.loopImpedanceZs! - theoreticalZ) / theoreticalZ) * 100;
        if (dev > 50) isLoopImpedanceCritical = true;
      }

      // Voltage check at load
      if (m.voltageAtLoad != null) {
        // Simple check < 207V (230 - 10%)
        if (m.voltageAtLoad! < 207) isVoltageCritical = true;
      }
    }, panel: (m) {
      if (m.earthResistanceRa != null) {
        // TT Scheme limit typical 20 Ohm (or calculated based on RCD)
        if (m.earthResistanceRa! > 20.0) isEarthFailed = true;
      }
    }, generic: (m) {
      // Fallback or legacy logic
      if (m.measuredRcdTripTime != null && m.measuredRcdTripTime! > 300) {
        isRcdFailed = true;
      }
      if (m.measuredEarthResistance != null &&
          m.measuredEarthResistance! > 20) {
        isEarthFailed = true;
      }
    });

    return _MeasurementDeviation(
      isVoltageCritical: isVoltageCritical,
      isVoltageWarning: isVoltageWarning,
      isLoopImpedanceCritical: isLoopImpedanceCritical,
      isRcdFailed: isRcdFailed,
      isEarthFailed: isEarthFailed,
      isInsulationFailed: isInsulationFailed,
    );
  }

  /// Clasifica el nivel de seguridad según score y errores
  SecurityLevel _classifySecurityLevel(int score, int criticalCount) {
    if (criticalCount > 0 || score < 40) return SecurityLevel.critical;
    if (score < 70) return SecurityLevel.low;
    if (score < 90) return SecurityLevel.medium;
    return SecurityLevel.high;
  }

  /// Clasifica el estado de cumplimiento normativo
  ComplianceStatus _classifyCompliance(int criticalCount, int warningCount) {
    if (criticalCount > 0) return ComplianceStatus.fail;
    if (warningCount > 0) return ComplianceStatus.reviewRequired;
    return ComplianceStatus.pass;
  }
}

/// Resultado de la comparación teoría vs realidad
class _MeasurementDeviation {
  final bool isVoltageCritical; // > 10% diferencia
  final bool isVoltageWarning; // 5-10% diferencia
  final bool isLoopImpedanceCritical; // > 20% mayor
  final bool isRcdFailed; // > 300ms
  final bool isEarthFailed; // > 20Ω (TT)
  final bool isInsulationFailed; // < 0.5 MΩ

  const _MeasurementDeviation({
    required this.isVoltageCritical,
    required this.isVoltageWarning,
    required this.isLoopImpedanceCritical,
    required this.isRcdFailed,
    required this.isEarthFailed,
    required this.isInsulationFailed,
  });
}
