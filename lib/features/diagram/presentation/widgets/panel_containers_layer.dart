import 'package:flutter/material.dart';

/// Painter for panel container rectangles in the diagram
class PanelContainersPainter extends CustomPainter {
  final Map<String, Rect> panelRects;
  final Map<String, String> panelNames;
  final Color borderColor;
  final Color fillColor;
  final Color textColor;

  PanelContainersPainter({
    required this.panelRects,
    required this.panelNames,
    this.borderColor = const Color(0xFF4A9EFF),
    this.fillColor = const Color(0x1A4A9EFF),
    this.textColor = Colors.white,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    for (final entry in panelRects.entries) {
      final panelId = entry.key;
      final rect = entry.value;

      // Draw filled rectangle
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(8)),
        fillPaint,
      );

      // Draw border
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(8)),
        borderPaint,
      );

      // Draw panel name label
      final panelName = panelNames[panelId] ?? 'Panel';
      final textSpan = TextSpan(
        text: panelName,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      // Position label at top-left of panel
      final labelOffset = Offset(
        rect.left + 8,
        rect.top + 8,
      );

      textPainter.paint(canvas, labelOffset);
    }
  }

  @override
  bool shouldRepaint(PanelContainersPainter oldDelegate) {
    return oldDelegate.panelRects != panelRects ||
        oldDelegate.panelNames != panelNames ||
        oldDelegate.borderColor != borderColor ||
        oldDelegate.fillColor != fillColor ||
        oldDelegate.textColor != textColor;
  }
}

/// Widget layer for rendering panel containers
class PanelContainersLayer extends StatelessWidget {
  final Map<String, Rect> panelRects;
  final Map<String, String> panelNames;
  final Color? borderColor;
  final Color? fillColor;
  final Color? textColor;

  const PanelContainersLayer({
    Key? key,
    required this.panelRects,
    required this.panelNames,
    this.borderColor,
    this.fillColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PanelContainersPainter(
        panelRects: panelRects,
        panelNames: panelNames,
        borderColor: borderColor ?? const Color(0xFF4A9EFF),
        fillColor: fillColor ?? const Color(0x1A4A9EFF),
        textColor: textColor ?? Colors.white,
      ),
      child: Container(),
    );
  }
}
