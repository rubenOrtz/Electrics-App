import 'dart:ui';

/// Service for handling drag and drop logic with alignment snapping
class DragDropHandler {
  final double snapThreshold;

  const DragDropHandler({this.snapThreshold = 10.0});

  /// Calculate snapped position based on existing node positions
  /// Returns snapped offset and lists of guide lines to display
  SnapResult calculateSnap({
    required Offset dragPosition,
    required Map<String, Offset> existingPositions,
    required String? draggingNodeId,
  }) {
    final verticalLines = <double>[];
    final horizontalLines = <double>[];
    var snappedX = dragPosition.dx;
    var snappedY = dragPosition.dy;

    // Find nearby positions to snap to
    for (final entry in existingPositions.entries) {
      // Skip the node being dragged
      if (entry.key == draggingNodeId) continue;

      final pos = entry.value;

      // Check vertical alignment (X coordinate)
      if ((dragPosition.dx - pos.dx).abs() < snapThreshold) {
        snappedX = pos.dx;
        verticalLines.add(pos.dx);
      }

      // Check horizontal alignment (Y coordinate)
      if ((dragPosition.dy - pos.dy).abs() < snapThreshold) {
        snappedY = pos.dy;
        horizontalLines.add(pos.dy);
      }
    }

    return SnapResult(
      snappedPosition: Offset(snappedX, snappedY),
      verticalGuides: verticalLines,
      horizontalGuides: horizontalLines,
      isSnapped: verticalLines.isNotEmpty || horizontalLines.isNotEmpty,
    );
  }

  /// Check if a position is valid for dropping (e.g., not overlapping)
  bool isValidDropPosition({
    required Offset position,
    required Map<String, Offset> existingPositions,
    required Size nodeSize,
    String? excludeNodeId,
  }) {
    final dragRect = Rect.fromLTWH(
      position.dx,
      position.dy,
      nodeSize.width,
      nodeSize.height,
    );

    // Check for overlaps with existing nodes
    for (final entry in existingPositions.entries) {
      if (entry.key == excludeNodeId) continue;

      final existingRect = Rect.fromLTWH(
        entry.value.dx,
        entry.value.dy,
        nodeSize.width,
        nodeSize.height,
      );

      if (dragRect.overlaps(existingRect)) {
        return false;
      }
    }

    return true;
  }

  /// Calculate optimal drop zone based on proximity to existing nodes
  Offset? findNearestDropZone({
    required Offset position,
    required List<Offset> validZones,
    double maxDistance = 100.0,
  }) {
    if (validZones.isEmpty) return null;

    Offset? nearest;
    double minDistance = double.infinity;

    for (final zone in validZones) {
      final distance = (position - zone).distance;
      if (distance < maxDistance && distance < minDistance) {
        minDistance = distance;
        nearest = zone;
      }
    }

    return nearest;
  }
}

/// Result of snap calculation
class SnapResult {
  final Offset snappedPosition;
  final List<double> verticalGuides;
  final List<double> horizontalGuides;
  final bool isSnapped;

  const SnapResult({
    required this.snappedPosition,
    required this.verticalGuides,
    required this.horizontalGuides,
    required this.isSnapped,
  });
}
