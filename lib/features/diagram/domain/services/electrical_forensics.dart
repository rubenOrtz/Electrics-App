// ignore_for_file: non_constant_identifier_names
import '../entities/electrical_node.dart';
import '../entities/forensic_finding.dart';
import '../entities/measurement_state.dart';

/// Motor de diagnóstico forense para detectar fallos físicos
/// comparando valores teóricos con medidas reales.
class ElectricalForensics {
  static List<ForensicFinding> analyzeNode(ElectricalNode node) {
    // Si no hay medidas, no hay análisis forense posible (solo validación teórica, que ya se hace en ValidationEngine)
    final measurement = node.map(
      source: (n) => n.lastMeasurement,
      panel: (n) => n.lastMeasurement,
      protection: (n) => n.lastMeasurement,
      load: (n) => n.lastMeasurement,
    );

    if (measurement == null) return [];

    final findings = <ForensicFinding>[];

    // Obtener valores teóricos del cálculo
    // Usamos el state también ya que contiene voltajes calculados
    final theoreticalVoltage = node.state.voltageVolts; // Volts
    final theoreticalCurrent = node.state.currentAmps; // Amps

    // 1. REGLA: LOOSE CONNECTION (Conexión Floja)
    _analyzeLooseConnection(measurement, theoreticalVoltage, findings);

    // 2. REGLA: PHANTOM LOAD (Carga Fantasma / Fuga)
    _analyzePhantomLoad(measurement, theoreticalCurrent, findings);

    // 3. REGLA: THERMAL STRESS (Estrés Térmico)
    _analyzeThermalStress(measurement, findings);

    // 4. REGLA: MAGNETIC FAILURE (Solo Protecciones)
    if (node is ProtectionNode) {
      _analyzeMagneticFailure(node, measurement, findings);
    }

    return findings;
  }

  // --- REGLAS HEURÍSTICAS ---

  /// Regla: Si voltaje medido < 95% teórico
  /// Causa probable: Resistencia en serie no esperada (borna floja, cable dañado)
  static void _analyzeLooseConnection(
    MeasurementState m,
    double theoreticalVoltage,
    List<ForensicFinding> findings,
  ) {
    final measuredV = m.voltageLN;
    if (measuredV == null || theoreticalVoltage == 0) return;

    // Threshold: 95% voltage retention
    final minExpected = theoreticalVoltage * 0.95;

    if (measuredV < minExpected) {
      final dropPercent =
          ((theoreticalVoltage - measuredV) / theoreticalVoltage) * 100;

      findings.add(ForensicFinding(
        code: 'LOOSE_CONNECTION',
        title: 'Posible conexión floja',
        description:
            'La tensión medida (${measuredV.toStringAsFixed(1)}V) es ${dropPercent.toStringAsFixed(1)}% menor que la calculada (${theoreticalVoltage.toStringAsFixed(1)}V). Verificar apriete de bornas aguas arriba.',
        severity: FindingSeverity.warning,
        measuredValue: measuredV,
        theoreticalValue: theoreticalVoltage,
      ));
    }
  }

  /// Regla: Si corriente medida > 15% teórica
  /// Causa probable: Carga no documentada o fuga a tierra importante
  static void _analyzePhantomLoad(
    MeasurementState m,
    double theoreticalCurrent,
    List<ForensicFinding> findings,
  ) {
    final measuredI = m.current;
    if (measuredI == null) return;

    // Ignorar corrientes muy bajas (< 0.5A) para evitar falsos positivos por ruido
    if (measuredI < 0.5 && theoreticalCurrent < 0.5) return;

    // Threshold: 115% current
    final maxExpected =
        theoreticalCurrent > 0 ? theoreticalCurrent * 1.15 : 0.5;

    if (measuredI > maxExpected) {
      final excess = measuredI - theoreticalCurrent;

      findings.add(ForensicFinding(
        code: 'PHANTOM_LOAD',
        title: 'Carga fantasma detectada',
        description:
            'La corriente medida (${measuredI.toStringAsFixed(1)}A) supera la teórica (${theoreticalCurrent.toStringAsFixed(1)}A) en ${excess.toStringAsFixed(1)}A. Buscar cargas no documentadas o fugas.',
        severity: FindingSeverity.warning,
        measuredValue: measuredI,
        theoreticalValue: theoreticalCurrent,
      ));
    }
  }

  /// Regla: Temperatura > 60ºC
  /// Causa probable: Sobrecarga o mal contacto
  static void _analyzeThermalStress(
    MeasurementState m,
    List<ForensicFinding> findings,
  ) {
    final temp = m.temperature;
    if (temp == null) return;

    const criticalTemp =
        60.0; // ºC standard limit for terminals (often 70 or 90 for cable, but 60 is safe warning)

    if (temp > criticalTemp) {
      findings.add(ForensicFinding(
        code: 'THERMAL_STRESS',
        title: 'Temperatura crítica',
        description:
            'Temperatura medida en bornas (${temp.toStringAsFixed(1)}ºC) excede el límite seguro ($criticalTempºC). Riesgo de incendio.',
        severity: FindingSeverity.critical,
        measuredValue: temp,
        theoreticalValue: criticalTemp,
      ));
    }
  }

  /// Regla: Impedancia de Bucle > Zmax para disparo magnético
  /// Causa probable: Cable muy largo o sección insuficiente para la protección instalada
  static void _analyzeMagneticFailure(
    ProtectionNode node,
    MeasurementState m,
    List<ForensicFinding> findings,
  ) {
    final Zs = m.loopImpedance;
    if (Zs == null) return;

    final In = node.ratingAmps;
    final curve = node.curve;

    // Factor de disparo magnético (limite superior)
    double magneticFactor;
    switch (curve.toUpperCase()) {
      case 'B':
        magneticFactor = 5.0;
        break;
      case 'C':
        magneticFactor = 10.0;
        break;
      case 'D':
        magneticFactor = 20.0;
        break; // 10-20 In usually
      case 'Z':
        magneticFactor = 3.0;
        break;
      case 'K':
        magneticFactor = 14.0;
        break;
      case 'MA':
        magneticFactor = 12.0;
        break;
      default:
        magneticFactor = 10.0; // Assume C
    }

    // Corriente necesaria para disparo instantáneo
    final Im = In * magneticFactor;

    // Impedancia máxima permitida: Zs_max = U0 / Im
    // U0 = 230V Phase-Neutral
    final maxZs = 230.0 / Im;

    if (Zs > maxZs) {
      findings.add(ForensicFinding(
        code: 'MAGNETIC_FAILURE',
        title: 'Fallo protección magnética',
        description:
            'La impedancia de bucle ($Zs Ω) es muy alta. El PIA $curve${In.toInt()} no disparará ante un cortocircuito en punta (Req: < ${maxZs.toStringAsFixed(2)} Ω).',
        severity: FindingSeverity.critical,
        measuredValue: Zs,
        theoreticalValue: maxZs,
      ));
    }
  }
}
