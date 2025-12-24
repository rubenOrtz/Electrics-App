import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../projects/domain/entities/project.dart';
import '../../../diagram/domain/entities/electrical_node.dart';
import '../../../diagram/domain/entities/electrical_enums.dart';
import 'report_generator_interface.dart';
import '../painters/iec_symbols.dart';

class SingleLineDiagramGenerator implements ReportGenerator {
  @override
  Future<Uint8List> generate(Project project) async {
    final pdf = pw.Document();
    await build(pdf, project);
    return pdf.save();
  }

  @override
  Future<void> build(pw.Document pdf, Project project) async {
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a3.landscape,
        margin: const pw.EdgeInsets.all(20),
        build: (context) {
          return pw.Stack(
            children: [
              // Main Diagram Area
              pw.Positioned.fill(
                bottom: 80, // Leave space for Title Block
                child: _buildDiagram(project.root),
              ),
              // Title Block (Cajetín) in bottom right
              pw.Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: pw.Container(
                  height: 80,
                  child: _buildTitleBlock(project),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  pw.Widget _buildTitleBlock(Project project) {
    // Using a hybrid approach: Container with custom border styling matching TechnicalFramePainter
    // Ideally, we'd use TechnicalFramePainter entirely, but combining Widgets is easier for text.
    // Let's stick to the Widget layout but strictly matching the 190x35mm spec.

    return pw.Container(
      width: 190 * PdfPageFormat.mm,
      height: 35 * PdfPageFormat.mm,
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black, width: 1),
      ),
      child: pw.Row(
        children: [
          // LOGO (40mm)
          pw.Container(
            width: 40 * PdfPageFormat.mm,
            alignment: pw.Alignment.center,
            decoration: const pw.BoxDecoration(
              border: pw.Border(right: pw.BorderSide(width: 0.5)),
            ),
            child: pw.Text("LOGO",
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
          ),
          // DATA
          pw.Expanded(
            child: pw.Column(
              children: [
                // Row 1: Project Title
                pw.Expanded(
                  flex: 3,
                  child: pw.Container(
                      alignment: pw.Alignment.centerLeft,
                      padding: const pw.EdgeInsets.all(5),
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: 0.5)),
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text("PROYECTO",
                              style: const pw.TextStyle(
                                  fontSize: 6, color: PdfColors.grey700)),
                          pw.Text(project.name,
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 12)),
                        ],
                      )),
                ),
                // Row 2: Client
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                      alignment: pw.Alignment.centerLeft,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: const pw.BoxDecoration(
                        border: pw.Border(bottom: pw.BorderSide(width: 0.5)),
                      ),
                      child: pw.Row(children: [
                        pw.Text("TITULAR: ",
                            style: pw.TextStyle(
                                fontSize: 6, fontWeight: pw.FontWeight.bold)),
                        pw.Text(project.client ?? "-",
                            style: const pw.TextStyle(fontSize: 8)),
                      ])),
                ),
                // Row 3: Meta
                pw.Expanded(
                  flex: 2,
                  child: pw.Row(
                    children: [
                      _buildMetaCell("FECHA",
                          "${project.createdAt.day}/${project.createdAt.month}/${project.createdAt.year}"),
                      _buildMetaCell("ESCALA", "S/E"),
                      _buildMetaCell("HOJA", "1 de 1"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildMetaCell(String label, String value) {
    return pw.Expanded(
        child: pw.Container(
            decoration: const pw.BoxDecoration(
              border: pw.Border(right: pw.BorderSide(width: 0.5)),
            ),
            padding: const pw.EdgeInsets.all(2),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(label,
                    style: const pw.TextStyle(
                        fontSize: 5, color: PdfColors.grey700)),
                pw.Text(value,
                    style: pw.TextStyle(
                        fontSize: 7, fontWeight: pw.FontWeight.bold)),
              ],
            )));
  }

  // --- Diagram Logic ---

  pw.Widget _buildDiagram(ElectricalNode? root) {
    if (root == null) {
      return pw.Center(child: pw.Text("No Diagram Data"));
    }

    return pw.LayoutBuilder(
      builder: (context, constraints) {
        return pw.CustomPaint(
          size: PdfPoint(
              constraints?.maxWidth ?? 800, constraints?.maxHeight ?? 500),
          painter: (canvas, size) {
            // Draw schematic starting from top
            _drawNodeRecursively(canvas, root, Offset(50, size.y - 50));
          },
        );
      },
    );
  }

  void _drawNodeRecursively(
      PdfGraphics canvas, ElectricalNode node, Offset pos) {
    // 1. Draw current node symbol
    _drawSymbol(canvas, node, pos);

    // 2. Draw label
    _drawLabel(canvas, node, pos);

    // 3. Draw connection and recurse
    final children = node.map(
      source: (n) => n.children,
      panel: (n) => n.children,
      protection: (n) => n.children,
      load: (_) => <ElectricalNode>[],
    );

    if (children.isEmpty) return;

    const double xSpacing = 60.0;
    const double ySpacing = 80.0;

    double totalWidth = (children.length - 1) * xSpacing;
    double startX = pos.dx - (totalWidth / 2);

    for (int i = 0; i < children.length; i++) {
      final child = children[i];
      final childPos = Offset(startX + (i * xSpacing), pos.dy - ySpacing);

      // Draw Wire
      canvas.setColor(PdfColors.black);
      canvas.setLineWidth(1);
      // Orthogonal routing
      canvas.moveTo(pos.dx, pos.dy - 10);
      canvas.lineTo(pos.dx, pos.dy - (ySpacing / 2));
      canvas.lineTo(childPos.dx, pos.dy - (ySpacing / 2));
      canvas.lineTo(childPos.dx, childPos.dy + 10);
      canvas.strokePath();

      _drawNodeRecursively(canvas, child, childPos);
    }
  }

  void _drawSymbol(PdfGraphics canvas, ElectricalNode node, Offset pos) {
    canvas.setColor(PdfColors.black);
    canvas.setLineWidth(1.0); // Detailed lines 0.5mm approx

    node.map(
      source: (_) {
        // Grid Connection
        IECSymbols.drawTerminal(canvas, pos.dx, pos.dy);
        // Supply Arrow
        canvas.moveTo(pos.dx, pos.dy + 10);
        canvas.lineTo(pos.dx - 5, pos.dy + 15);
        canvas.moveTo(pos.dx, pos.dy + 10);
        canvas.lineTo(pos.dx + 5, pos.dy + 15);
        canvas.strokePath();
      },
      panel: (_) {
        // Distribution Board Frame
        canvas.drawRect(pos.dx - 20, pos.dy - 15, 40, 30);
        canvas.strokePath();
      },
      protection: (n) {
        if (n.protectionType == ProtectionType.differential) {
          IECSymbols.drawDifferential(canvas, pos.dx, pos.dy);
        } else {
          IECSymbols.drawBreaker(canvas, pos.dx, pos.dy);
        }
      },
      load: (_) {
        // Motor or Load Arrow
        // Draw Arrow down
        canvas.moveTo(pos.dx, pos.dy);
        canvas.lineTo(pos.dx, pos.dy - 10);
        canvas.strokePath();

        // Arrow head
        canvas.moveTo(pos.dx, pos.dy - 10);
        canvas.lineTo(pos.dx - 3, pos.dy - 7);
        canvas.moveTo(pos.dx, pos.dy - 10);
        canvas.lineTo(pos.dx + 3, pos.dy - 7);
        canvas.strokePath();
      },
    );
  }

  void _drawLabel(PdfGraphics canvas, ElectricalNode node, Offset pos) {
    // Label logic placeholder
  }
}

// Helper
class Offset {
  final double dx;
  final double dy;
  const Offset(this.dx, this.dy);
}
