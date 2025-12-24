import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../diagram/domain/entities/electrical_node.dart';

class PdfReportGenerator {
  final ElectricalNode rootNode;
  final String projectName;
  final String clientName;
  final String companyName;
  // logo bytes would be passed here in a real app

  PdfReportGenerator({
    required this.rootNode,
    required this.projectName,
    required this.clientName,
    required this.companyName,
  });

  Future<Uint8List> generate() async {
    final pdf = pw.Document();

    // 1. Diagram Page (Vectorial)
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        build: (context) {
          return pw.FullPage(
            ignoreMargins: true,
            child: pw.Stack(
              children: [
                _buildHeader(context),
                pw.Center(child: _buildVectorDiagram(rootNode)),
                _buildFooter(context),
              ],
            ),
          );
        },
      ),
    );

    // 2. Calculation Memory Page (Table)
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            children: [
              _buildHeader(context),
              pw.SizedBox(height: 20),
              pw.Text("Memoria de Cálculo",
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              _buildCalculationTable(),
              pw.Spacer(),
              _buildFooter(context),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Container(
        margin: const pw.EdgeInsets.only(bottom: 20),
        child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(companyName,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text("Proyecto: $projectName"),
                  ]),
              pw.Text("Cliente: $clientName"),
            ]));
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Container(
        alignment: pw.Alignment.centerRight,
        margin: const pw.EdgeInsets.only(top: 10),
        child: pw.Text("Página ${context.pageNumber} de ${context.pagesCount}",
            style: const pw.TextStyle(color: PdfColors.grey)));
  }

  // --- Vector Diagram Logic ---

  pw.Widget _buildVectorDiagram(ElectricalNode root) {
    // This CustomPaint equivalent uses a painter callback
    return pw.CustomPaint(
      size: const PdfPoint(800, 500), // A4 Landscape-ish canvas
      painter: (canvas, size) {
        _drawNodeRecursively(canvas, root, Offset.zero);
      },
    );
  }

  void _drawNodeRecursively(
      PdfGraphics canvas, ElectricalNode node, Offset parentPos) {
    canvas.setColor(PdfColors.black);
  }

  // --- Table Logic ---

  pw.Widget _buildCalculationTable() {
    final rows = <pw.TableRow>[];

    // Header
    rows.add(pw.TableRow(
      decoration: const pw.BoxDecoration(color: PdfColors.grey300),
      children: [
        _buildCell("Circuito", isHeader: true),
        _buildCell("Protección", isHeader: true),
        _buildCell("Sección", isHeader: true),
        _buildCell("Longitud", isHeader: true),
        _buildCell("Caída Tensión", isHeader: true),
        _buildCell("Icc", isHeader: true),
      ],
    ));

    // Data - Traverse tree to flatten list
    final nodes = _flattenTree(rootNode);

    for (var i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      final isError = node.state.voltageDropPercent > 3.0; // Example rule
      final color = i % 2 == 0 ? PdfColors.white : PdfColors.grey100;
      final textColor = isError ? PdfColors.red : PdfColors.black;

      // Extract values same as in ExtractProperties
      final name = node.name;
      final protection = node.map(
        source: (_) => "-",
        panel: (_) => "-",
        protection: (n) => "${n.ratingAmps}A",
        load: (_) => "-",
      );
      final section = node.map(
        source: (_) => "-",
        panel: (n) => n.inputCable?.sectionMm2.toString() ?? "-",
        protection: (_) => "-", // Protection nodes don't have cable
        load: (n) => n.inputCable?.sectionMm2.toString() ?? "-",
      );
      // ... extract others

      rows.add(pw.TableRow(
        decoration: pw.BoxDecoration(color: color),
        children: [
          _buildCell(name, color: textColor),
          _buildCell(protection, color: textColor),
          _buildCell(section, color: textColor),
          _buildCell("-", color: textColor), // Length
          _buildCell("${node.state.voltageDropPercent.toStringAsFixed(2)}%",
              color: textColor),
          _buildCell("-", color: textColor), // Icc
        ],
      ));
    }

    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey),
      children: rows,
    );
  }

  List<ElectricalNode> _flattenTree(ElectricalNode node) {
    final list = [node];
    node.map(
      source: (n) {
        for (var c in n.children) {
          list.addAll(_flattenTree(c));
        }
      },
      panel: (n) {
        for (var c in n.children) {
          list.addAll(_flattenTree(c));
        }
      },
      protection: (n) {
        for (var c in n.children) {
          list.addAll(_flattenTree(c));
        }
      },
      load: (_) {},
    );
    return list;
  }

  pw.Widget _buildCell(String text,
      {bool isHeader = false, PdfColor color = PdfColors.black}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(5),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
          color: color,
          fontSize: 10,
        ),
      ),
    );
  }
}

// Temporary Offset class helper if not using dart:ui (which breaks pdf generation sometimes if mixed)
class Offset {
  final double dx;
  final double dy;
  const Offset(this.dx, this.dy);
  static const zero = Offset(0, 0);
}
