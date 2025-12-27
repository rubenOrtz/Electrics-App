import 'package:flutter/material.dart';
import '../../../../config/theme/app_themes.dart';
import '../../../diagram/domain/entities/electrical_node.dart';
import '../../domain/entities/field_measurement.dart';

class ComponentsListSheet extends StatelessWidget {
  final List<ElectricalNode> components;
  final Map<String, List<FieldMeasurement>> measurements;
  final Function(ElectricalNode, List<FieldMeasurement>) onComponentTap;

  const ComponentsListSheet({
    super.key,
    required this.components,
    required this.measurements,
    required this.onComponentTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final diagramTheme = theme.extension<DiagramTheme>()!;

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: diagramTheme.panelBg,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border.all(
              color: diagramTheme.nodeBorder.withValues(alpha: 0.5),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Handle
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: diagramTheme.textColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.list_alt,
                      color: diagramTheme.accentColor,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Listado de Componentes',
                      style: TextStyle(
                        color: diagramTheme.textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: diagramTheme.accentColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${components.length} Items',
                        style: TextStyle(
                          color: diagramTheme.accentColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // List
              Expanded(
                child: components.isEmpty
                    ? Center(
                        child: Text(
                          'No hay componentes disponibles',
                          style: TextStyle(
                            color:
                                diagramTheme.textColor.withValues(alpha: 0.6),
                          ),
                        ),
                      )
                    : ListView.separated(
                        controller: scrollController,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        itemCount: components.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final component = components[index];
                          final componentMeasurements =
                              measurements[component.id] ?? [];

                          return _buildListItem(
                            context,
                            component,
                            componentMeasurements,
                            diagramTheme,
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListItem(
    BuildContext context,
    ElectricalNode component,
    List<FieldMeasurement> measurements,
    DiagramTheme diagramTheme,
  ) {
    bool hasIssues = measurements
        .isNotEmpty; // Example logic, adapt if needed based on measurements values

    return GestureDetector(
      onTap: () => onComponentTap(component, measurements),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: diagramTheme.nodeBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasIssues
                ? Colors.redAccent.withValues(alpha: 0.5)
                : diagramTheme.nodeBorder.withValues(alpha: 0.5),
            width: hasIssues ? 2 : 1, // Highlight issues
          ),
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: diagramTheme.canvasBg.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: diagramTheme.nodeBorder.withValues(alpha: 0.3),
                ),
              ),
              child: Icon(
                _getComponentIcon(component),
                color: diagramTheme.accentColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getComponentName(component),
                    style: TextStyle(
                      color: diagramTheme.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'ID: ${component.id.substring(0, 8)}',
                    style: TextStyle(
                      color: diagramTheme.textColor.withValues(alpha: 0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            // Status Icon/Action
            Icon(
              Icons.chevron_right,
              color: diagramTheme.textColor.withValues(alpha: 0.4),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getComponentIcon(ElectricalNode node) {
    return node.map(
      source: (_) => Icons.power_input,
      panel: (_) => Icons.grid_view,
      protection: (_) => Icons.shield_outlined,
      load: (_) => Icons.lightbulb_outline,
    );
  }

  String _getComponentName(ElectricalNode node) {
    return node.map(
      source: (n) => n.name,
      panel: (n) => n.name,
      protection: (n) => n.name,
      load: (n) => n.name,
    );
  }
}
