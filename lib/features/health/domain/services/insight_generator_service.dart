import '../entities/insight.dart';
import '../entities/field_measurement.dart';
import '../../../diagram/domain/entities/electrical_node.dart';
import '../../../diagram/domain/entities/validation_status.dart';
import '../../../diagram/domain/services/tree_utilities.dart';

/// Servicio que genera insights accionables desde errores de validación
/// y fallos de verificación (teoría vs realidad).
class InsightGeneratorService {
  /// Genera lista de insights priorizados
  List<Insight> generateInsights(
    ElectricalNode root,
    Map<String, FieldMeasurement> measurements,
  ) {
    final insights = <Insight>[];

    // Flatten tree once for better performance
    final nodes = TreeUtilities.flattenElectricalNodes(root);

    // 1. Insights de errores teóricos (ValidationEngine)
    insights.addAll(_generateTheoryInsights(nodes));

    // 2. Insights de verificación (mediciones vs cálculos)
    insights.addAll(_generateVerificationInsights(nodes, measurements));

    // 3. Insights de éxito (si todo OK)
    if (insights.where((i) => i.type == InsightType.critical).isEmpty) {
      insights.add(_generateSuccessInsight(root));
    }

    // Ordenar por prioridad
    insights.sort((a, b) => a.priority.value.compareTo(b.priority.value));

    return insights;
  }

  /// Genera insights desde errores teóricos del ValidationEngine
  List<Insight> _generateTheoryInsights(List<ElectricalNode> nodes) {
    final insights = <Insight>[];

    for (var node in nodes) {
      final result = node.result;
      if (result == null) continue;

      // Errores críticos
      for (var error in result.errors) {
        insights.add(_mapErrorToInsight(node, error));
      }

      // Warnings
      for (var warning in result.warnings) {
        insights.add(_mapWarningToInsight(node, warning));
      }
    }

    return insights;
  }

  /// Genera insights desde verificaciones de campo
  List<Insight> _generateVerificationInsights(
    List<ElectricalNode> nodes,
    Map<String, FieldMeasurement> measurements,
  ) {
    final insights = <Insight>[];

    for (var n in nodes) {
      final measurement = measurements[n.id];
      if (measurement == null) continue;

      final result = n.result;

      measurement.map(source: (m) {
        if (m.voltageLN != null && result != null) {
          final calculatedV = 230.0 - result.voltageDrop;
          final measuredV = m.voltageLN!;
          final deviation =
              ((measuredV - calculatedV).abs() / calculatedV) * 100;

          if (deviation > 10) {
            insights.add(Insight(
              id: '${n.id}_voltage_critical',
              type: InsightType.critical,
              title: 'Caída de Tensión Excesiva',
              node: n,
              description:
                  'Medida: ${measuredV.toStringAsFixed(1)}V. Esperada: ${calculatedV.toStringAsFixed(1)}V. Desviación: ${deviation.toStringAsFixed(1)}%.',
              suggestion: 'Verificar acometida y conexiones.',
              action: 'Inspección',
              priority: InsightPriority.high,
            ));
          }
        }
      }, rcd: (m) {
        if (m.tripTimeMs != null && m.tripTimeMs! > 300) {
          insights.add(Insight(
            id: '${n.id}_rcd_failed',
            type: InsightType.critical,
            title: 'Fallo Test Diferencial',
            node: n,
            description:
                'Tiempo disparo: ${m.tripTimeMs!.toStringAsFixed(0)}ms (>300ms).',
            suggestion: 'Diferencial defectuoso. Riesgo seguridad.',
            action: 'Sustituir Diferencial',
            priority: InsightPriority.high,
          ));
        }
      }, insulation: (m) {
        if (m.resistancePhaseEarth != null && m.resistancePhaseEarth! < 0.5) {
          insights.add(Insight(
            id: '${n.id}_insulation_failed',
            type: InsightType.critical,
            title: 'Fallo Aislamiento',
            node: n,
            description:
                'Resistencia: ${m.resistancePhaseEarth!.toStringAsFixed(2)}MΩ (<0.5MΩ).',
            suggestion: 'Aislamiento degradado en conductor.',
            action: 'Revisar Cableado',
            priority: InsightPriority.high,
          ));
        }
      }, load: (m) {
        if (m.loopImpedanceZs != null && result != null) {
          final theoreticalZ = result.loopImpedance;
          final measuredZ = m.loopImpedanceZs!;
          final deviation = ((measuredZ - theoreticalZ) / theoreticalZ) * 100;
          if (deviation > 50) {
            insights.add(Insight(
              id: '${n.id}_zs_deviation',
              type: InsightType.critical,
              title: 'Impedancia Bucle Elevada',
              node: n,
              description:
                  'Zs Medida: ${measuredZ.toStringAsFixed(2)}Ω vs Teórica: ${theoreticalZ.toStringAsFixed(2)}Ω.',
              suggestion: 'Verificar continuidad y conexiones de tierra.',
              priority: InsightPriority.high,
            ));
          }
        }
      }, panel: (m) {
        if (m.earthResistanceRa != null && m.earthResistanceRa! > 20) {
          insights.add(Insight(
            id: '${n.id}_earth_ra',
            type: InsightType.critical,
            title: 'Resistencia Tierra Alta',
            node: n,
            description:
                'Ra: ${m.earthResistanceRa!.toStringAsFixed(1)}Ω (>20Ω).',
            suggestion: 'Mejorar sistema de electrodos de tierra.',
            priority: InsightPriority.high,
          ));
        }
      }, generic: (m) {
        // Legacy support
        if (m.measuredVoltageLN != null) {
          // ... simplified logic if needed
        }
      });
    }

    return insights;
  }

  /// Mapea ValidationError a Insight
  Insight _mapErrorToInsight(ElectricalNode node, ValidationError error) {
    // Mapeo específico según tipo de error
    if (error.message.contains('Ib > In')) {
      return Insight(
        id: '${node.id}_${error.hashCode}',
        type: InsightType.critical,
        title: 'Sobrecarga de Corriente',
        node: node,
        description: error.message,
        suggestion: 'Aumentar calibre de protección o reducir carga.',
        action: 'Revisar Dimensionamiento',
        priority: InsightPriority.high,
      );
    }

    if (error.message.contains('In > Iz')) {
      return Insight(
        id: '${node.id}_${error.hashCode}',
        type: InsightType.critical,
        title: 'Cable Subdimensionado',
        node: node,
        description: error.message,
        suggestion: 'Aumentar sección de cable.',
        action: 'Cambio de Cable',
        priority: InsightPriority.high,
      );
    }

    if (error.message.contains('Caída de tensión')) {
      return Insight(
        id: '${node.id}_${error.hashCode}',
        type: InsightType.critical,
        title: 'Caída de Tensión Excesiva',
        node: node,
        description: error.message,
        suggestion: 'Aumentar sección de cable o acortar longitud.',
        action: 'Verificar Sección',
        priority: InsightPriority.high,
      );
    }

    // Error genérico
    return Insight(
      id: '${node.id}_${error.hashCode}',
      type: InsightType.critical,
      title: 'Error de Validación',
      node: node,
      description: error.message,
      suggestion: 'Revisar configuración del componente.',
      priority: InsightPriority.high,
    );
  }

  /// Mapea ValidationWarning a Insight
  Insight _mapWarningToInsight(ElectricalNode node, ValidationWarning warning) {
    return Insight(
      id: '${node.id}_${warning.hashCode}',
      type: InsightType.warning,
      title: 'Aviso de Dimensionamiento',
      node: node,
      description: warning.message,
      suggestion: 'Revisar y optimizar configuración.',
      priority: InsightPriority.medium,
    );
  }

  /// Genera insight de éxito
  Insight _generateSuccessInsight(ElectricalNode root) {
    return Insight(
      id: 'success_general',
      type: InsightType.success,
      title: 'Instalación en Buen Estado',
      node: root,
      description: 'No se detectaron problemas críticos en la instalación.',
      suggestion:
          'Continuar con mantenimiento preventivo programado y verificaciones periódicas.',
      priority: InsightPriority.low,
    );
  }

}
