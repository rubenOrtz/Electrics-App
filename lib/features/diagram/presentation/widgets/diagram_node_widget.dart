import 'package:flutter/material.dart';
import '../../domain/entities/diagram_models.dart';

const double kNodeWidth = 80.0;
const double kNodeHeight = 120.0;
const double kFontSize = 12.0;

class DiagramNodeWidget extends StatelessWidget {
  final DiagramNode node;
  final bool isSelected;
  final Function(DiagramNode) onSelect;
  final Function(NodeType, DiagramNode) onAddChild;

  const DiagramNodeWidget({
    Key? key,
    required this.node,
    required this.isSelected,
    required this.onSelect,
    required this.onAddChild,
  }) : super(key: key);

  bool _isDropCompliant(dynamic dropVal, [double limit = 3.0]) {
    if (dropVal == null) return true; // Default compliant
    double val = 0.0;
    if (dropVal is num) {
      val = dropVal.toDouble();
    } else if (dropVal is String) {
      val = double.tryParse(dropVal) ?? 0.0;
    }
    return val <= limit;
  }

  @override
  Widget build(BuildContext context) {
    if (node.type == NodeType.cable) {
      return GestureDetector(
        onTap: () => onSelect(node),
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey, width: 2),
          ),
          child: const Center(
              child: Icon(Icons.show_chart, size: 10, color: Colors.white)),
        ),
      );
    }

    final isLoad = node.type == NodeType.load;

    // Fixed Sizes
    const width = kNodeWidth;
    const height = kNodeHeight;

    return DragTarget<NodeType>(
      onAcceptWithDetails: (details) => onAddChild(details.data, node),
      builder: (context, candidateData, rejectedData) {
        final isHovered = candidateData.isNotEmpty;

        if (isLoad) {
          final limit = node.properties['limit'] as double? ?? 3.0;
          final name = node.properties['name'] as String? ?? "";
          IconData mainIcon = Icons.lightbulb_outline;
          if (name.contains('⚙️')) {
            mainIcon = Icons.settings;
          } else if (limit == 5.0) {
            mainIcon = Icons.power;
          }

          // Circular Load
          return GestureDetector(
              onTap: () => onSelect(node),
              onPanUpdate: (details) {},
              child: SizedBox(
                width: width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              color: const Color(0xFF334155),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: isSelected
                                      ? Colors.blueAccent
                                      : (isHovered
                                          ? Colors.white
                                          : Colors.amber),
                                  width: isSelected ? 3 : 2),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4))
                              ]),
                          child: Icon(mainIcon,
                              color: Colors.amberAccent, size: 28),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                                color: _isDropCompliant(
                                        node.properties['drop_percent'], limit)
                                    ? Colors.green
                                    : Colors.red,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: const Color(0xFF0F172A), width: 2)),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      node.properties['name'] ?? "S/N",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.grey, fontSize: kFontSize),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Caída: ${node.properties['drop_percent']}% (Loc: ${node.properties['local_drop'] ?? '-'}%)\nLímite: ${limit.toStringAsFixed(0)}%",
                      style: const TextStyle(color: Colors.yellow, fontSize: 7),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ));
        }

        // Breaker / Box Card
        return GestureDetector(
          onTap: () => onSelect(node),
          onPanUpdate: (details) {},
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: isSelected
                        ? Colors.blueAccent
                        : (isHovered ? Colors.white : const Color(0xFF475569)),
                    width: isSelected ? 2 : 1),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4))
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(node.properties['name'] ?? "C??",
                      style: const TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: kFontSize),
                      maxLines: 1),
                ),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4)),
                  child: const Icon(Icons.check_box_outline_blank,
                      color: Colors.blueAccent, size: 20),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                        color: _isDropCompliant(node.properties['drop_percent'],
                                node.properties['limit'] as double? ?? 3.0)
                            ? Colors.green
                            : Colors.red,
                        shape: BoxShape.circle),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
