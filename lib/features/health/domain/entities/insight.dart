import '../../../diagram/domain/entities/electrical_node.dart';

/// Representa un insight accionable generado desde errores de validación
/// o fallos de verificación (teoría vs realidad).
class Insight {
  final String id;
  final InsightType type;
  final String title;
  final ElectricalNode node;
  final String description;
  final String suggestion;
  final String? action; // Acción sugerida (ej: "Revisión Inmediata")
  final InsightPriority priority;

  const Insight({
    required this.id,
    required this.type,
    required this.title,
    required this.node,
    required this.description,
    required this.suggestion,
    this.action,
    required this.priority,
  });
}

/// Tipo de insight
enum InsightType {
  critical, // Error crítico (rojo)
  warning, // Advertencia (naranja)
  success, // Todo OK (verde)
  info, // Información (azul)
}

/// Prioridad para ordenamiento
enum InsightPriority {
  high(1),
  medium(2),
  low(3);

  final int value;
  const InsightPriority(this.value);
}
