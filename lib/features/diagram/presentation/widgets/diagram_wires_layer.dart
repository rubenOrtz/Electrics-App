import 'package:flutter/material.dart';
import '../../domain/entities/electrical_node.dart';

/// Painter for drawing wires/connections between electrical nodes in the diagram
class DiagramWiresPainter extends CustomPainter {
  final ElectricalNode? root;
  final Map<String, Offset> positions;
  final Color wireColor;

  DiagramWiresPainter({
    required this.root,
    required this.positions,
    this.wireColor = const Color(0xFF888888),
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (root == null) return;

    final paint = Paint()
      ..color = wireColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    void drawConnections(ElectricalNode node) {
      final nodePos = positions[node.id];
      if (nodePos == null) return;

      final children = _getChildren(node);

      for (final child in children) {
        final childPos = positions[child.id];
        if (childPos != null) {
          // Use actual node widget dimensions from ElectricalNodeWidget
          // kNodeWidth = 80, kNodeHeight = 120 (NOT diagram_constants values)
          const nodeWidth = 80.0;
          const nodeHeight = 120.0;

          // Draw wire from node bottom center to child top center
          final fromCenter = Offset(
            nodePos.dx + (nodeWidth / 2), // Horizontal center = 40
            nodePos.dy + nodeHeight, // Bottom edge = 120
          );
          final toCenter = Offset(
            childPos.dx + (nodeWidth / 2), // Horizontal center = 40
            childPos.dy, // Top edge
          );

          // Vertical line from parent bottom
          final midY = (fromCenter.dy + toCenter.dy) / 2;
          canvas.drawLine(fromCenter, Offset(fromCenter.dx, midY), paint);

          // Horizontal line
          canvas.drawLine(
            Offset(fromCenter.dx, midY),
            Offset(toCenter.dx, midY),
            paint,
          );

          // Vertical line to child top
          canvas.drawLine(Offset(toCenter.dx, midY), toCenter, paint);
        }

        // Recursively draw child connections
        drawConnections(child);
      }
    }

    drawConnections(root!);
  }

  List<ElectricalNode> _getChildren(ElectricalNode node) {
    return node.maybeMap(
      source: (n) => n.children,
      panel: (n) => n.children,
      protection: (n) => n.children,
      orElse: () => [],
    );
  }

  @override
  bool shouldRepaint(DiagramWiresPainter oldDelegate) {
    return oldDelegate.root != root ||
        oldDelegate.positions != positions ||
        oldDelegate.wireColor != wireColor;
  }
}

/// Widget layer for rendering diagram wires
class DiagramWiresLayer extends StatelessWidget {
  final ElectricalNode? root;
  final Map<String, Offset> positions;
  final Color? wireColor;

  const DiagramWiresLayer({
    Key? key,
    required this.root,
    required this.positions,
    this.wireColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DiagramWiresPainter(
        root: root,
        positions: positions,
        wireColor: wireColor ?? const Color(0xFF888888),
      ),
      child: Container(),
    );
  }
}
