import 'package:flutter/material.dart';
import '../../domain/entities/electrical_node.dart';
import '../../domain/entities/validation_status.dart';

class HealthCheckPanel extends StatelessWidget {
  final ElectricalNode? root;
  final VoidCallback? onViewDiagram;

  const HealthCheckPanel({
    Key? key,
    this.root,
    this.onViewDiagram,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stats = _calculateStats(root);
    final errorNodes = _collectErrorNodes(root);

    return Container(
      color: const Color(0xFF0F172A),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: stats.errorCount > 0
                      ? Colors.red.withValues(alpha: 0.2)
                      : stats.warningCount > 0
                          ? Colors.orange.withValues(alpha: 0.2)
                          : Colors.green.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  stats.errorCount > 0
                      ? Icons.error_outline
                      : stats.warningCount > 0
                          ? Icons.warning_amber
                          : Icons.check_circle_outline,
                  color: stats.errorCount > 0
                      ? Colors.redAccent
                      : stats.warningCount > 0
                          ? Colors.orange
                          : Colors.green,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stats.errorCount > 0
                          ? 'Problemas Detectados'
                          : stats.warningCount > 0
                              ? 'Advertencias Detectadas'
                              : 'Sistema OK',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${stats.totalNodes} componentes analizados',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Stats Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Errores Críticos',
                  stats.errorCount,
                  Icons.error_outline,
                  Colors.redAccent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'Advertencias',
                  stats.warningCount,
                  Icons.warning_amber,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  'OK',
                  stats.okCount,
                  Icons.check_circle,
                  Colors.green,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Error List
          if (errorNodes.isNotEmpty) ...[
            const Text(
              'Componentes con Problemas',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: errorNodes.length,
                itemBuilder: (context, index) {
                  final node = errorNodes[index];
                  final status =
                      node.result?.status ?? ValidationStatus.pending;
                  final errorCount = node.result?.errors.length ?? 0;
                  final warningCount = node.result?.warnings.length ?? 0;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: status == ValidationStatus.error
                            ? Colors.redAccent.withValues(alpha: 0.5)
                            : Colors.orange.withValues(alpha: 0.5),
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(
                        status == ValidationStatus.error
                            ? Icons.error_outline
                            : Icons.warning_amber,
                        color: status == ValidationStatus.error
                            ? Colors.redAccent
                            : Colors.orange,
                      ),
                      title: Text(
                        node.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        errorCount > 0
                            ? '$errorCount error${errorCount > 1 ? "es" : ""}'
                            : '$warningCount advertencia${warningCount > 1 ? "s" : ""}',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16,
                      ),
                      onTap: () {
                        // Switch to diagram tab
                        if (onViewDiagram != null) onViewDiagram!();
                      },
                    ),
                  );
                },
              ),
            ),
          ] else ...[
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 64,
                      color: Colors.green.withValues(alpha: 0.3),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No se detectaron problemas',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, int count, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            count.toString(),
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  _HealthStats _calculateStats(ElectricalNode? node) {
    if (node == null) return _HealthStats(0, 0, 0, 0);

    int errors = 0;
    int warnings = 0;
    int ok = 0;
    int total = 0;

    void traverse(ElectricalNode n) {
      total++;
      final status = n.result?.status ?? ValidationStatus.pending;

      if (status == ValidationStatus.error) {
        errors++;
      } else if (status == ValidationStatus.warning) {
        warnings++;
      } else if (status == ValidationStatus.ok) {
        ok++;
      }

      n.map(
        source: (s) => s.children.forEach(traverse),
        panel: (p) => p.children.forEach(traverse),
        protection: (p) => p.children.forEach(traverse),
        load: (_) {},
      );
    }

    traverse(node);
    return _HealthStats(errors, warnings, ok, total);
  }

  List<ElectricalNode> _collectErrorNodes(ElectricalNode? node) {
    if (node == null) return [];

    final List<ElectricalNode> nodes = [];

    void traverse(ElectricalNode n) {
      final status = n.result?.status ?? ValidationStatus.pending;

      if (status == ValidationStatus.error ||
          status == ValidationStatus.warning) {
        nodes.add(n);
      }

      n.map(
        source: (s) => s.children.forEach(traverse),
        panel: (p) => p.children.forEach(traverse),
        protection: (p) => p.children.forEach(traverse),
        load: (_) {},
      );
    }

    traverse(node);
    return nodes;
  }
}

class _HealthStats {
  final int errorCount;
  final int warningCount;
  final int okCount;
  final int totalNodes;

  _HealthStats(
      this.errorCount, this.warningCount, this.okCount, this.totalNodes);
}
