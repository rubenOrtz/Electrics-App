import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../domain/services/trip_curve_calculator.dart';

/// Custom painter for rendering trip curves in log-log scale
/// Follows IEC 60898 standard visualization
class TripCurvePainter extends CustomPainter {
  final TripCurveData curveData;
  final Color curveColor;
  final Color zoneColor;
  final bool showGrid;
  final Color backgroundColor;
  final Color gridColor;
  final Color axisColor;
  final Color textColor;

  TripCurvePainter({
    required this.curveData,
    this.curveColor = Colors.blue,
    this.zoneColor = const Color(0x404CAF50),
    this.showGrid = true,
    this.backgroundColor = Colors.white,
    this.gridColor = const Color(0xFFE0E0E0), // Colors.grey.shade300
    this.axisColor = Colors.black,
    this.textColor = Colors.black,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Define chart bounds
    final chartRect = Rect.fromLTWH(
      60, // Left margin for Y-axis labels
      20, // Top margin
      size.width - 80, // Chart width
      size.height - 60, // Chart height
    );

    // Draw background
    canvas.drawRect(
      chartRect,
      Paint()..color = backgroundColor,
    );

    if (showGrid) {
      _drawGrid(canvas, chartRect);
    }

    _drawAxes(canvas, chartRect, size);
    _drawTripZone(canvas, chartRect);
    _drawCurveBoundaries(canvas, chartRect);
    _drawLegend(canvas, size);
  }

  void _drawGrid(Canvas canvas, Rect chartRect) {
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.5;

    // Vertical grid lines (current multiples: 1, 2, 5, 10, 20, 50)
    final verticalLines = [1.0, 2.0, 5.0, 10.0, 20.0, 50.0];
    for (final multiple in verticalLines) {
      final x = _currentToX(multiple, chartRect);
      canvas.drawLine(
        Offset(x, chartRect.top),
        Offset(x, chartRect.bottom),
        gridPaint,
      );
    }

    // Horizontal grid lines (time: 0.01, 0.1, 1, 10, 100, 1000, 10000)
    final horizontalLines = [0.01, 0.1, 1.0, 10.0, 100.0, 1000.0, 10000.0];
    for (final time in horizontalLines) {
      final y = _timeToY(time, chartRect);
      canvas.drawLine(
        Offset(chartRect.left, y),
        Offset(chartRect.right, y),
        gridPaint,
      );
    }
  }

  void _drawAxes(Canvas canvas, Rect chartRect, Size size) {
    final axisPaint = Paint()
      ..color = axisColor
      ..strokeWidth = 1.5;

    // X-axis (bottom)
    canvas.drawLine(
      Offset(chartRect.left, chartRect.bottom),
      Offset(chartRect.right, chartRect.bottom),
      axisPaint,
    );

    // Y-axis (left)
    canvas.drawLine(
      Offset(chartRect.left, chartRect.top),
      Offset(chartRect.left, chartRect.bottom),
      axisPaint,
    );

    // X-axis labels (current multiples)
    final xLabels = [1.0, 2.0, 5.0, 10.0, 20.0, 50.0];
    for (final multiple in xLabels) {
      final x = _currentToX(multiple, chartRect);
      _drawText(
        canvas,
        '${multiple.toStringAsFixed(0)}x',
        Offset(x, chartRect.bottom + 10),
        fontSize: 10,
      );
    }

    // Y-axis labels (time in seconds)
    final yLabels = [
      (0.01, '10ms'),
      (0.1, '100ms'),
      (1.0, '1s'),
      (10.0, '10s'),
      (100.0, '100s'),
      (1000.0, '1000s'),
      (10000.0, '10000s'),
    ];
    for (final (time, label) in yLabels) {
      final y = _timeToY(time, chartRect);
      _drawText(
        canvas,
        label,
        Offset(5, y),
        fontSize: 9,
        align: TextAlign.left,
      );
    }

    // Axis titles
    _drawText(
      canvas,
      'Múltiplos de In',
      Offset(chartRect.center.dx, size.height - 5),
      fontSize: 12,
      isBold: true,
    );

    _drawText(
      canvas,
      'Tiempo',
      Offset(15, chartRect.top - 5),
      fontSize: 12,
      isBold: true,
    );
  }

  void _drawTripZone(Canvas canvas, Rect chartRect) {
    final zonePath = Path();
    final minCurve = curveData.getInterpolatedMin();
    final maxCurve = curveData.getInterpolatedMax();

    // Start from first point of min curve
    final startPoint = minCurve.first;
    zonePath.moveTo(
      _currentToX(startPoint.currentMultiple, chartRect),
      _timeToY(startPoint.timeSeconds, chartRect),
    );

    // Draw min curve forward
    for (final point in minCurve) {
      zonePath.lineTo(
        _currentToX(point.currentMultiple, chartRect),
        _timeToY(point.timeSeconds, chartRect),
      );
    }

    // Draw max curve backward
    for (final point in maxCurve.reversed) {
      zonePath.lineTo(
        _currentToX(point.currentMultiple, chartRect),
        _timeToY(point.timeSeconds, chartRect),
      );
    }

    zonePath.close();

    // Fill the zone
    canvas.drawPath(
      zonePath,
      Paint()
        ..color = zoneColor
        ..style = PaintingStyle.fill,
    );
  }

  void _drawCurveBoundaries(Canvas canvas, Rect chartRect) {
    final paint = Paint()
      ..color = curveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // Draw min curve
    Path minPath = Path();
    final minCurve = curveData.getInterpolatedMin();
    final firstMin = minCurve.first;
    minPath.moveTo(
      _currentToX(firstMin.currentMultiple, chartRect),
      _timeToY(firstMin.timeSeconds, chartRect),
    );
    for (final point in minCurve.skip(1)) {
      minPath.lineTo(
        _currentToX(point.currentMultiple, chartRect),
        _timeToY(point.timeSeconds, chartRect),
      );
    }
    canvas.drawPath(minPath, paint);

    // Draw max curve (dashed)
    paint.strokeWidth = 1.5;
    Path maxPath = Path();
    final maxCurve = curveData.getInterpolatedMax();
    final firstMax = maxCurve.first;
    maxPath.moveTo(
      _currentToX(firstMax.currentMultiple, chartRect),
      _timeToY(firstMax.timeSeconds, chartRect),
    );
    for (final point in maxCurve.skip(1)) {
      maxPath.lineTo(
        _currentToX(point.currentMultiple, chartRect),
        _timeToY(point.timeSeconds, chartRect),
      );
    }
    canvas.drawPath(maxPath, paint..color = curveColor.withValues(alpha: 0.6));
  }

  void _drawLegend(Canvas canvas, Size size) {
    final legendX = size.width - 150;
    const legendY = 40.0;

    // Curve type and rating
    _drawText(
      canvas,
      'Curva ${curveData.curveType}',
      Offset(legendX, legendY),
      fontSize: 14,
      isBold: true,
    );

    _drawText(
      canvas,
      'In = ${curveData.ratedCurrent.toStringAsFixed(0)}A',
      Offset(legendX, legendY + 20),
      fontSize: 12,
    );

    // Magnetic trip range
    _drawText(
      canvas,
      'Disparo magnético:',
      Offset(legendX, legendY + 45),
      fontSize: 10,
      isBold: true,
    );

    _drawText(
      canvas,
      '${curveData.magneticTripMin.toStringAsFixed(0)}-${curveData.magneticTripMax.toStringAsFixed(0)} x In',
      Offset(legendX, legendY + 60),
      fontSize: 10,
    );
  }

  /// Convert current multiple to X coordinate (logarithmic)
  double _currentToX(double currentMultiple, Rect chartRect) {
    const minCurrent = 1.0;
    const maxCurrent = 50.0;

    final logMin = math.log(minCurrent);
    final logMax = math.log(maxCurrent);
    final logCurrent = math.log(currentMultiple.clamp(minCurrent, maxCurrent));

    final ratio = (logCurrent - logMin) / (logMax - logMin);
    return chartRect.left + ratio * chartRect.width;
  }

  /// Convert time to Y coordinate (logarithmic, inverted)
  double _timeToY(double timeSeconds, Rect chartRect) {
    const minTime = 0.01;
    const maxTime = 10000.0;

    final logMin = math.log(minTime);
    final logMax = math.log(maxTime);
    final logTime = math.log(timeSeconds.clamp(minTime, maxTime));

    final ratio = (logTime - logMin) / (logMax - logMin);
    // Invert Y (higher time = lower on chart)
    return chartRect.bottom - ratio * chartRect.height;
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset position, {
    double fontSize = 12,
    bool isBold = false,
    TextAlign align = TextAlign.center,
  }) {
    final textSpan = TextSpan(
      text: text,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textAlign: align,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    final offset = Offset(
      position.dx - (align == TextAlign.center ? textPainter.width / 2 : 0),
      position.dy - textPainter.height / 2,
    );

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(TripCurvePainter oldDelegate) {
    return oldDelegate.curveData != curveData ||
        oldDelegate.curveColor != curveColor ||
        oldDelegate.showGrid != showGrid;
  }
}
