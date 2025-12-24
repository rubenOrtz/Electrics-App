import 'package:flutter/material.dart';
import '../../../../config/theme/app_themes.dart';
import '../../domain/entities/diagram_models.dart';
import '../../domain/entities/electrical_node.dart'; // For DragTarget
import 'alignment_guides_widget.dart';
import 'diagram_wires_layer.dart';
import 'panel_containers_layer.dart';
import 'electrical_node_widget.dart';

/// The main canvas area of the diagram, handling zooming, panning, and rendering layers.
class DiagramCanvas extends StatelessWidget {
  final TransformationController transformController;
  final DiagramTheme diagramTheme;
  final ElectricalNode? root;
  final Map<String, Offset> nodePositions;
  final Map<String, Rect> panelRects;
  final Map<String, String> panelNames;
  final List<DiagramNode> visualNodes;
  final DiagramNode? selectedNode;

  // Drag & Drop / Interaction callbacks
  final Function(TapDownDetails) onBackgroundTap;
  final Function(DiagramNode) onNodeSelected;
  final Function(DragTargetDetails<NodeType>, String) onNodeDroppedOnPanel;

  // Dragging State (passed down for visual feedback)
  final String? draggingNodeId;
  final List<double> verticalGuides;
  final List<double> horizontalGuides;

  const DiagramCanvas({
    Key? key,
    required this.transformController,
    required this.diagramTheme,
    required this.root,
    required this.nodePositions,
    required this.panelRects,
    required this.panelNames,
    required this.visualNodes,
    required this.onBackgroundTap,
    required this.onNodeSelected,
    required this.onNodeDroppedOnPanel,
    this.selectedNode,
    this.draggingNodeId,
    this.verticalGuides = const [],
    this.horizontalGuides = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController: transformController,
      minScale: 0.1,
      maxScale: 4.0,
      boundaryMargin: const EdgeInsets.all(double.infinity),
      constrained: false, // Infinite canvas
      child: GestureDetector(
        onTapDown: onBackgroundTap,
        child: SizedBox(
          width: 5000,
          height: 5000,
          child: Stack(
            children: [
              // 1. Grid Layer
              Positioned.fill(
                child: CustomPaint(
                  painter: _GridPainter(color: diagramTheme.gridLine),
                ),
              ),

              // 2. Panel Containers Layer
              PanelContainersLayer(
                panelRects: panelRects,
                panelNames: panelNames,
                borderColor: diagramTheme.nodeBorder, // Was panelBorder
                fillColor: diagramTheme.panelBg, // Was panelBackground
                textColor: diagramTheme.textColor, // Was textMain
              ),

              // 3. Drop ZONES for Panels (Invisible but reactive)
              ...panelRects.entries.map((entry) => Positioned.fromRect(
                    rect: entry.value,
                    child: DragTarget<NodeType>(
                      onAcceptWithDetails: (details) =>
                          onNodeDroppedOnPanel(details, entry.key),
                      builder: (ctx, candidates, _) {
                        return Container(
                          decoration: BoxDecoration(
                            border: candidates.isNotEmpty
                                ? Border.all(color: Colors.blueAccent, width: 2)
                                : null,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        );
                      },
                    ),
                  )),

              // 4. Wires Layer
              DiagramWiresLayer(
                positions: nodePositions,
                root: root,
                wireColor: diagramTheme.textColor.withValues(alpha: 0.5),
              ),

              // 5. Nodes Layer
              Stack(
                children: visualNodes.map((vNode) {
                  return Positioned(
                    left: vNode.position.dx,
                    top: vNode.position.dy,
                    child: DragTarget<NodeType>(
                      onAcceptWithDetails: (details) {
                        // When a NodeType is dropped on this node, add it as child
                        onNodeDroppedOnPanel(details, vNode.id);
                      },
                      builder: (ctx, candidates, rejected) {
                        return ElectricalNodeWidget(
                          node: vNode.relatedNode!,
                          isSelected: selectedNode?.id == vNode.id,
                          onTap: () => onNodeSelected(vNode),
                          onNodeDropped: (type) {
                            // Direct callback when dropping on widget
                            onNodeDroppedOnPanel(
                              DragTargetDetails(
                                  data: type, offset: Offset.zero),
                              vNode.id,
                            );
                          },
                        );
                      },
                    ),
                  );
                }).toList(),
              ),

              // 6. Alignment Guides
              if (draggingNodeId != null)
                AlignmentGuidesWidget(
                  verticalLines: verticalGuides,
                  horizontalLines: horizontalGuides,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  final Color color;
  _GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    const step = 50.0;

    // Draw only a portion or whole?
    // Optimization: Draw lines covering 5000x5000
    // This is expensive if we draw too many.
    // Logic from original file:
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
