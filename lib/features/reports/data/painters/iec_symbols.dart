import 'package:pdf/pdf.dart';

class IECSymbols {
  static void drawBreaker(PdfGraphics canvas, double x, double y,
      {double size = 20}) {
    // Vertical Line
    canvas.moveTo(x, y - (size / 2));
    canvas.lineTo(x, y + (size / 2));
    canvas.strokePath();

    // The "X" or Box
    // IEC 60617-7-02-01: Circuit Breaker is often a cross on the line
    // Draw Cross
    final half = size / 4;
    canvas.moveTo(x - half, y - half);
    canvas.lineTo(x + half, y + half);

    canvas.moveTo(x + half, y - half);
    canvas.lineTo(x - half, y + half);

    canvas.strokePath();

    // Trigger "Square" (Thermal/Magnetic)
    // Usually a small square attached to the side or top
    canvas.drawRect(x - (half / 2), y + (size / 4), half, half);
    canvas.strokePath();
  }

  static void drawDifferential(PdfGraphics canvas, double x, double y,
      {double size = 20}) {
    // Oval intersection
    canvas.drawEllipse(x, y, size / 3, size / 4);
    canvas.strokePath();

    // Line through
    canvas.moveTo(x, y - (size / 2));
    canvas.lineTo(x, y + (size / 2));
    canvas.strokePath();
  }

  static void drawContactor(PdfGraphics canvas, double x, double y,
      {double size = 20}) {
    // Rect with "KM" or Coil symbol
    canvas.drawRect(x - (size / 2), y - (size / 4), size, size / 2);
    canvas.strokePath();

    // Diagonals for coil? Or Semi-circle?
    // Switch symbol: |_ / _|
  }

  static void drawTerminal(PdfGraphics canvas, double x, double y) {
    canvas.drawEllipse(x, y, 1.5, 1.5); // Small circle
    // canvas.fillPath(); // Optional fill
    canvas.strokePath();
  }
}
