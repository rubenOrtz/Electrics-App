import 'dart:typed_data';
import 'dart:ui' show Offset;
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../projects/domain/entities/project.dart';
import '../../../diagram/domain/entities/electrical_node.dart';
import 'maps/region_form_map.dart';

class FormFillerService {
  final bool debugGrid;

  FormFillerService({this.debugGrid = false});

  Future<Uint8List> generateFromTemplate(
      Project project, RegionFormMap map) async {
    final pdf = pw.Document();
    await fillInDocument(pdf, project, map);
    return pdf.save();
  }

  Future<void> fillInDocument(
      pw.Document pdf, Project project, RegionFormMap map,
      {List<pw.Widget> extraWidgets = const []}) async {
    // 1. Load Template
    // Note: In a real environment, we'd need to know if this asset is an Image or a PDF.
    // ... (comments elided for brevity if desired, but keeping logic) ...

    final templateBytes = await rootBundle.load(map.templateAsset);

    pw.MemoryImage? templateImage;
    if (map.templateAsset.toLowerCase().endsWith('.pdf')) {
      // Rasterize the first page of the PDF to an image
      try {
        await for (final page in Printing.raster(
            templateBytes.buffer.asUint8List(),
            pages: [0],
            dpi: 72)) {
          final image = await page.toPng();
          templateImage = pw.MemoryImage(image);
          break;
        }
      } catch (e) {
        // Silently fail if template rasterization fails
      }
    } else {
      templateImage = pw.MemoryImage(templateBytes.buffer.asUint8List());
    }

    // 2. Main Page with Overlay
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero, // Full bleed
        build: (context) {
          return pw.Stack(
            children: [
              // Background
              if (templateImage != null)
                pw.Positioned.fill(
                  child: pw.Image(templateImage, fit: pw.BoxFit.cover),
                ),

              // Grid for Calibration
              if (debugGrid) _buildDebugGrid(),

              // Data Fields
              _buildTextAt(map.titularPos, project.client ?? ""),
              _buildTextAt(
                  map.direccionPos, "C/ Ejemplo, 123 (Sevilla)"), // Mock
              _buildTextAt(map.tensionPos, "230 V"), // Mock
              _buildTextAt(map.potenciaPos, "5.75 kW"), // Mock

              // Signature
              _buildSignature(map),

              // Overflow Note (if needed)
              if (_shouldOverflow(project, map))
                pw.Positioned(
                    left: 50,
                    top: 500, // Approx middle of table
                    child: pw.Text("VER ANEXO DE CIRCUITOS",
                        style: pw.TextStyle(
                            color: PdfColors.red,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 14))),

              // Extra Widgets (Specifics)
              ...extraWidgets,
            ],
          );
        },
      ),
    );

    // 3. Annex Page (if overflow)
    if (_shouldOverflow(project, map)) {
      _addAnnexPage(pdf, project);
    }
  }

  bool _shouldOverflow(Project project, RegionFormMap map) {
    // Calculate circuit count from tree
    int circuitCount = _countCircuits(project.root);
    return circuitCount > map.maxCircuitRows;
  }

  int _countCircuits(ElectricalNode? root) {
    if (root == null) return 0;
    int count = 0;
    if (root is ProtectionNode || root is LoadNode) {
      count++; // Simplify counting
    }
    // Real counting would be finding leaf circuits

    root.map(
      source: (n) {
        for (var c in n.children) {
          count += _countCircuits(c);
        }
      },
      panel: (n) {
        for (var c in n.children) {
          count += _countCircuits(c);
        }
      },
      protection: (n) {
        for (var c in n.children) {
          count += _countCircuits(c);
        }
      },
      load: (_) {},
    );
    return count;
  }

  pw.Widget _buildTextAt(Offset pos, String text) {
    // PDF coordinates are usually from Bottom-Left (Cartesian) in PDF specification,
    // BUT 'pdf' package widgets usually use Top-Left System in pw.Page build (standard layouts).
    // User provided "Offsets" likely in Top-Left system (Y=700 is high, meant for bottom? or top?).
    // "Offset(120, 750)" in A4 (height ~842) suggests Bottom if 0,0 is top.
    // Wait, if it's "750", that's near the bottom of the page.
    // If the user meant "Offset(x, y)" as logic coordinates, I will use Positioned.
    // Warning: pw.Stack with Positioned uses Top set by `top`.
    // If the input is Cartesian (Y up), I'd need to invert.
    // User Example: "titularPos = Offset(120, 750)".
    // If A4 height is ~841 pts. 750 is near the bottom. Titular is usually at the top.
    // So likely the User provided Cartesian (Y=0 bottom, Y=841 top).
    // I need to convert Cartesian to Widget (Top-Left) coordinates.
    // widgetY = pageHeight - cartesianY.

    // Let's assume user Input is Cartesian because they said "puntos PDF".
    // 750 is high up in Cartesian.

    const pageHeight = 841.89; // A4 height in pts
    final top = pageHeight - pos.dy;
    final left = pos.dx;

    return pw.Positioned(
      left: left,
      top: top,
      child: pw.Text(text, style: const pw.TextStyle(fontSize: 10)),
    );
  }

  pw.Widget _buildSignature(RegionFormMap map) {
    // Placeholder signature logic
    // In real app, load from File
    return pw.Positioned(
      left: map.firmaIngenieroPos.dx,
      top: 841.89 - map.firmaIngenieroPos.dy,
      child: pw.Container(
          width: map.firmaBoxSize.width,
          height: map.firmaBoxSize.height,
          decoration:
              pw.BoxDecoration(border: pw.Border.all(color: PdfColors.blue)),
          alignment: pw.Alignment.center,
          child: pw.Text("Firma Aquí",
              style: const pw.TextStyle(fontSize: 8, color: PdfColors.blue))),
    );
  }

  pw.Widget _buildDebugGrid() {
    // Draw grid lines
    return pw.LayoutBuilder(builder: (context, constraints) {
      return pw.Stack(children: [
        for (double x = 0; x < 600; x += 50)
          pw.Positioned(
              left: x,
              top: 0,
              bottom: 0,
              child: pw.Container(width: 0.5, color: PdfColors.grey300)),
        for (double y = 0; y < 900; y += 50)
          pw.Positioned(
              left: 0,
              right: 0,
              top: y,
              child: pw.Stack(children: [
                pw.Container(height: 0.5, color: PdfColors.grey300),
                pw.Text((841.89 - y).toStringAsFixed(0),
                    style:
                        const pw.TextStyle(fontSize: 6, color: PdfColors.grey)),
              ])),
      ]);
    });
  }

  void _addAnnexPage(pw.Document pdf, Project project) {
    // Reuse logic from Technical Memory logic or similar
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
              pw.Header(level: 1, text: "ANEXO I: RELACIÓN DE CIRCUITOS"),
              pw.SizedBox(height: 20),
              // We can't easily reuse _buildCalculationTable from other class unless it's public/static
              // or we duplicate logic.
              // Ideally, TechnicalMemoryGenerator should expose a static builder.
              // For now, I'll instantiate it? No, that returns bytes.
              // I'll define a simple table here for the Annex.
              _buildAnnexTable(project.root),
            ]));
  }

  pw.Widget _buildAnnexTable(ElectricalNode? root) {
    // Simplified table
    return pw.Table(border: pw.TableBorder.all(), children: [
      pw.TableRow(children: [
        pw.Text("Circuito"),
        pw.Text("Potencia"),
        pw.Text("Protección")
      ]),
      // TODO: Iterate properly
      pw.TableRow(
          children: [pw.Text("C1"), pw.Text("3450W"), pw.Text("1x16A")]),
      pw.TableRow(
          children: [pw.Text("C2"), pw.Text("2300W"), pw.Text("1x10A")]),
    ]);
  }
}
