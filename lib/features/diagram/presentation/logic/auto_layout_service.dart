import 'dart:ui';
import '../../domain/entities/electrical_node.dart';
// Ensure PanelNode is recognized if needed
import '../widgets/diagram_constants.dart';

/// Service for calculating automatic layout positions for the diagram
/// Pure business logic - NO Flutter widgets, minimal UI dependencies
class AutoLayoutService {
  const AutoLayoutService._();

  /// Calculate positions for all nodes in the tree
  /// Returns a map of node IDs to their calculated positions
  static Map<String, Offset> calculateLayout(ElectricalNode? root) {
    if (root == null) return {};

    final Map<String, Offset> positions = {};
    final Map<String, double> subtreeWidths = {};

    const double nodeW = kNodeWidth;
    const double siblingGap = 50.0;
    const double levelHeight = 250.0;

    // Phase 1: Calculate subtree widths (bottom-up)
    double calculateWidth(ElectricalNode node) {
      final isPanel = node.maybeMap(
        panel: (_) => true,
        orElse: () => false,
      );

      final children = _getChildren(node);

      if (children.isEmpty) {
        // Panels with no children = no width
        final w = isPanel ? 0.0 : nodeW;
        subtreeWidths[node.id] = w;
        return w;
      }

      double width = 0;
      for (var child in children) {
        width += calculateWidth(child);
      }
      width += (children.length - 1) * siblingGap;

      // Panels are transparent - just return children's width
      final myW = isPanel ? width : (width > nodeW ? width : nodeW);
      subtreeWidths[node.id] = myW;
      return myW;
    }

    calculateWidth(root);

    // Phase 2: Assign positions (top-down)
    void assignPosition(ElectricalNode node, double x, double y) {
      final isPanel = node.maybeMap(
        panel: (_) => true,
        orElse: () => false,
      );

      final myWidth = subtreeWidths[node.id]!;
      final centeredX = x + (myWidth - nodeW) / 2;

      // Skip position assignment for Panels (invisible containers)
      if (!isPanel) {
        positions[node.id] = Offset(centeredX, y);
      }

      final children = _getChildren(node);
      if (children.isEmpty) return;

      // Panels place children at same Y level
      final childY = isPanel ? y : y + levelHeight;

      // Center children distribution
      double currentX;
      if (isPanel) {
        // Calculate total width of children
        double totalChildrenWidth = 0;
        for (var child in children) {
          totalChildrenWidth += subtreeWidths[child.id]!;
        }
        totalChildrenWidth += (children.length - 1) * siblingGap;

        // Center under parent
        currentX = x + (myWidth - totalChildrenWidth) / 2;
      } else {
        currentX = x;
      }

      for (var child in children) {
        assignPosition(child, currentX, childY);
        currentX += subtreeWidths[child.id]! + siblingGap;
      }
    }

    // Start layout in "middle" of canvas (matching old implementation)
    // Canvas is 5000x5000, so we start at (2500, 150) for proper centering
    assignPosition(root, 2500, 150);

    return positions;
  }

  /// Calculate bounding box for diagram (for centering view)
  static Rect calculateBoundingBox(Map<String, Offset> positions) {
    if (positions.isEmpty) {
      return const Rect.fromLTWH(0, 0, 800, 600);
    }

    double minX = double.infinity;
    double minY = double.infinity;
    double maxX = double.negativeInfinity;
    double maxY = double.negativeInfinity;

    const double nodeW = kNodeWidth;
    const double nodeH = kNodeHeight;

    for (final pos in positions.values) {
      minX = minX < pos.dx ? minX : pos.dx;
      minY = minY < pos.dy ? minY : pos.dy;
      maxX = maxX > (pos.dx + nodeW) ? maxX : (pos.dx + nodeW);
      maxY = maxY > (pos.dy + nodeH) ? maxY : (pos.dy + nodeH);
    }

    const padding = 100.0;
    return Rect.fromLTRB(
      minX - padding,
      minY - padding,
      maxX + padding,
      maxY + padding,
    );
  }

  /// Calculate rectangles for panel containers based on node positions
  static Map<String, Rect> calculatePanelRects({
    required ElectricalNode root,
    required Map<String, Offset> positions,
    double nodeWidth = kNodeWidth,
    double nodeHeight = kNodeHeight,
  }) {
    final Map<String, Rect> panelRects = {};

    void computeRects(ElectricalNode node) {
      final isPanel = node.maybeMap(
        panel: (_) => true,
        orElse: () => false,
      );

      if (isPanel) {
        // Panels don't have positions, but need rectangles around their children
        final allChildren = _getChildren(node);

        // First process children recursively
        for (var c in allChildren) {
          computeRects(c);
        }

        // Then calculate this Panel's rectangle from children bounds
        if (allChildren.isNotEmpty) {
          double minX = double.infinity;
          double maxX = -double.infinity;
          double maxY = -double.infinity;
          double minY = double.infinity;

          for (var c in allChildren) {
            // Check direct children positions/bounds
            // Logic simplified: Get bounds of all children recursively
            final bounds =
                _getSubtreeBounds(c, positions, nodeWidth, nodeHeight);
            if (bounds != Rect.zero) {
              if (bounds.left < minX) minX = bounds.left;
              if (bounds.right > maxX) maxX = bounds.right;
              if (bounds.bottom > maxY) maxY = bounds.bottom;
              if (bounds.top < minY) minY = bounds.top;
            }
          }

          if (minX != double.infinity) {
            // Add padding for panel container
            panelRects[node.id] =
                Rect.fromLTRB(minX - 40, minY - 20, maxX + 40, maxY + 60);
          }
        }
      } else {
        // Not a panel (Source, Protection, etc.)
        // Just process children
        final allChildren = _getChildren(node);
        for (var c in allChildren) {
          computeRects(c);
        }
      }
    }

    computeRects(root);
    return panelRects;
  }

  static Rect _getSubtreeBounds(ElectricalNode rootNode,
      Map<String, Offset> positions, double w, double h) {
    // If this node has a position, start with its bounds
    double minX = double.infinity;
    double maxX = -double.infinity;
    double minY = double.infinity;
    double maxY = -double.infinity;

    if (positions.containsKey(rootNode.id)) {
      final pos = positions[rootNode.id]!;
      minX = pos.dx;
      maxX = pos.dx + w;
      minY = pos.dy;
      maxY = pos.dy + h;
    }

    // Include children bounds
    final children = _getChildren(rootNode);
    for (var c in children) {
      final childBounds = _getSubtreeBounds(c, positions, w, h);
      if (childBounds != Rect.zero) {
        if (childBounds.left < minX) minX = childBounds.left;
        if (childBounds.right > maxX) maxX = childBounds.right;
        if (childBounds.top < minY) minY = childBounds.top;
        if (childBounds.bottom > maxY) maxY = childBounds.bottom;
      }
    }

    if (minX == double.infinity) return Rect.zero;
    return Rect.fromLTRB(minX, minY, maxX, maxY);
  }

  /// Helper to get children from any node type
  static List<ElectricalNode> _getChildren(ElectricalNode node) {
    return node.maybeMap(
      source: (n) => n.children,
      panel: (n) => n.children,
      protection: (n) => n.children,
      orElse: () => [],
    );
  }
}
