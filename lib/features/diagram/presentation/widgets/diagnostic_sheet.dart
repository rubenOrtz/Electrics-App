import 'package:flutter/material.dart';
import '../../domain/entities/validation_status.dart';
import '../../domain/entities/electrical_node.dart';

/// Sheet que muestra diagnóstico detallado de errores y warnings
class DiagnosticSheet extends StatelessWidget {
  final ElectricalNode node;

  const DiagnosticSheet({
    Key? key,
    required this.node,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final result = node.map(
      source: (n) => n.result,
      panel: (n) => n.result,
      protection: (n) => n.result,
      load: (n) => n.result,
    );

    if (result == null) {
      return const SizedBox.shrink();
    }

    final errors = result.errors;
    final warnings = result.warnings;
    final hasIssues = errors.isNotEmpty || warnings.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                hasIssues ? Icons.warning : Icons.check_circle,
                color: hasIssues ? Colors.orange : Colors.green,
                size: 32,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Diagnóstico de Circuito',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      _getNodeName(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Cálculos básicos
          _buildCalculationsSummary(result),

          if (hasIssues) ...[
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),

            // Errores
            if (errors.isNotEmpty) ...[
              _buildSectionTitle('❌ Errores Críticos', Colors.redAccent),
              const SizedBox(height: 12),
              ...errors.map((error) => _buildErrorCard(error, context)),
            ],

            // Warnings
            if (warnings.isNotEmpty) ...[
              const SizedBox(height: 16),
              _buildSectionTitle('⚠️ Advertencias', Colors.orange),
              const SizedBox(height: 12),
              ...warnings.map((warning) => _buildWarningCard(warning, context)),
            ],
          ] else ...[
            const SizedBox(height: 24),
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 64,
                    color: Colors.green.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '✓ Todo correcto',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.green,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Este circuito cumple con la normativa',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildCalculationsSummary(dynamic result) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Corriente de diseño (Ib)',
              '${result.designCurrent.toStringAsFixed(1)} A'),
          _buildInfoRow(
              'Caída de tensión', '${result.voltageDrop.toStringAsFixed(2)}%'),
          _buildInfoRow('Tensión en nodo',
              '${result.voltageAtNode.toStringAsFixed(1)} V'),
          if (result.maxShortCircuitCurrent > 0)
            _buildInfoRow('Icc máxima',
                '${(result.maxShortCircuitCurrent / 1000).toStringAsFixed(1)} kA'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13)),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  Widget _buildErrorCard(ValidationError error, BuildContext context) {
    return error.map(
      cableOverload: (e) => _buildIssueCard(
        context: context,
        color: Colors.redAccent,
        icon: Icons.local_fire_department,
        title: 'Peligro de Incendio',
        message: e.message,
        suggestion:
            'Aumenta la sección del cable a ${e.requiredSection.toStringAsFixed(1)}mm² o reduce la protección.',
      ),
      voltageDrop: (e) => _buildIssueCard(
        context: context,
        color: Colors.redAccent,
        icon: Icons.trending_down,
        title: 'Caída de Tensión Excesiva',
        message: e.message,
        suggestion:
            'Aumenta la sección del cable, reduce la longitud, o distribuye la carga.',
      ),
      shortCircuit: (e) => _buildIssueCard(
        context: context,
        color: Colors.redAccent,
        icon: Icons.flash_on,
        title: 'Poder de Corte Insuficiente',
        message: e.message,
        suggestion:
            'Usa una protección con mayor poder de corte (mínimo ${e.shortCircuitCurrent.toStringAsFixed(1)}kA).',
      ),
      underprotection: (e) => _buildIssueCard(
        context: context,
        color: Colors.redAccent,
        icon: Icons.cable,
        title: 'Cable Muy Largo',
        message: e.message,
        suggestion:
            'Aumenta la sección del cable, reduce la longitud, o cambia a curva B.',
      ),
      overload: (e) => _buildIssueCard(
        context: context,
        color: Colors.redAccent,
        icon: Icons.warning_amber,
        title: 'Sobrecarga',
        message: e.message,
        suggestion:
            'La corriente de diseño (${e.ibAmps.toStringAsFixed(1)}A) excede la protección (${e.inAmps.toStringAsFixed(1)}A). Aumenta el calibre de la protección.',
      ),
      fireHazard: (e) => _buildIssueCard(
        context: context,
        color: Colors.redAccent,
        icon: Icons.local_fire_department,
        title: 'Riesgo de Incendio',
        message: e.message,
        suggestion:
            'Protección (${e.inAmps.toStringAsFixed(1)}A) > Capacidad del cable (${e.izAmps.toStringAsFixed(1)}A). Aumenta la sección del cable o reduce la protección.',
      ),
      general: (e) => _buildIssueCard(
        context: context,
        color: Colors.redAccent,
        icon: Icons.error_outline,
        title: 'Error',
        message: e.message,
        suggestion: null,
      ),
    );
  }

  Widget _buildWarningCard(ValidationWarning warning, BuildContext context) {
    return warning.map(
      oversizedCable: (w) => _buildIssueCard(
        context: context,
        color: Colors.orange,
        icon: Icons.info_outline,
        title: 'Cable Sobredimensionado',
        message: w.message,
        suggestion:
            'Podrías usar ${w.recommendedSection.toStringAsFixed(1)}mm² para optimizar costes.',
      ),
      lowPowerFactor: (w) => _buildIssueCard(
        context: context,
        color: Colors.orange,
        icon: Icons.battery_alert,
        title: 'Factor de Potencia Bajo',
        message: w.message,
        suggestion: 'Considera instalar baterías de condensadores.',
      ),
      general: (w) => _buildIssueCard(
        context: context,
        color: Colors.orange,
        icon: Icons.warning_amber,
        title: 'Advertencia',
        message: w.message,
        suggestion: null,
      ),
    );
  }

  Widget _buildIssueCard({
    required BuildContext context,
    required Color color,
    required IconData icon,
    required String title,
    required String message,
    String? suggestion,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: const TextStyle(fontSize: 13),
          ),
          if (suggestion != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.lightbulb_outline,
                      color: Colors.blue[700], size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      suggestion,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue[700],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getNodeName() {
    return node.map(
      source: (n) => n.name,
      panel: (n) => n.name,
      protection: (n) => n.name,
      load: (n) => n.name,
    );
  }

  /// Muestra el diagnostic sheet
  static void show(BuildContext context, ElectricalNode node) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: DiagnosticSheet(node: node),
        ),
      ),
    );
  }
}
