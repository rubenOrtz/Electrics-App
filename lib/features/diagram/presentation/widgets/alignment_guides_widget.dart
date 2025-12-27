import 'package:flutter/material.dart';

/// Widget for displaying alignment guide lines during drag operations
class AlignmentGuidesWidget extends StatelessWidget {
  final List<double> verticalLines;
  final List<double> horizontalLines;
  final Color lineColor;

  const AlignmentGuidesWidget({
    super.key,
    required this.verticalLines,
    required this.horizontalLines,
    this.lineColor = const Color(0xFFFF9800),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _AlignmentGuidesPainter(
        verticalLines: verticalLines,
        horizontalLines: horizontalLines,
        lineColor: lineColor,
      ),
      child: Container(),
    );
  }
}

class _AlignmentGuidesPainter extends CustomPainter {
  final List<double> verticalLines;
  final List<double> horizontalLines;
  final Color lineColor;

  _AlignmentGuidesPainter({
    required this.verticalLines,
    required this.horizontalLines,
    required this.lineColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Draw vertical alignment lines
    for (final x in verticalLines) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Draw horizontal alignment lines
    for (final y in horizontalLines) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_AlignmentGuidesPainter oldDelegate) {
    return oldDelegate.verticalLines != verticalLines ||
        oldDelegate.horizontalLines != horizontalLines ||
        oldDelegate.lineColor != lineColor;
  }
}
