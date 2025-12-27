import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../projects/domain/entities/project.dart';
import '../../../diagram/domain/entities/electrical_node.dart';
import '../../../diagram/domain/entities/electrical_enums.dart';
import '../../../diagram/domain/services/tree_utilities.dart';
import 'report_generator_interface.dart';

class TechnicalMemoryGenerator implements ReportGenerator {
  @override
  Future<Uint8List> generate(Project project) async {
    final pdf = pw.Document();
    await build(pdf, project);
    return pdf.save();
  }

  @override
  Future<void> build(pw.Document pdf, Project project) async {
    // Attempt to load fonts asynchronously
    final fontRegular = await PdfGoogleFonts.robotoRegular();
    final fontBold = await PdfGoogleFonts.robotoBold();

    // Theme data
    final theme = pw.ThemeData.withFont(
      base: fontRegular,
      bold: fontBold,
    );

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          theme: theme,
          pageFormat: PdfPageFormat.a4.landscape,
          margin: const pw.EdgeInsets.all(20),
        ),
        header: (context) => _buildHeader(project, context),
        footer: (context) => _buildFooter(project, context),
        build: (context) => [
          // 1. Executive Summary Page content
          pw.Header(level: 1, text: "Memoria Técnica de Diseño (MTD)"),
          pw.SizedBox(height: 20),
          _buildExecutiveSummary(project),
          pw.SizedBox(height: 20),
          pw.Divider(color: PdfColors.blueGrey900, thickness: 2),
          pw.SizedBox(height: 20),

          // 2. Main Calculation Table
          _buildStyledTable(project.root),
        ],
      ),
    );
  }

  // --- Layout Components ---

  pw.Widget _buildHeader(Project project, pw.Context context) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 20),
      child: pw.Column(
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              // Logo Placeholder
              pw.Container(
                width: 100,
                height: 30,
                alignment: pw.Alignment.centerLeft,
                child: pw.Text("LOGO",
                    style: pw.TextStyle(
                        color: PdfColors.grey400,
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold)),
              ),
              // Project Data
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(project.name,
                      style: pw.TextStyle(
                          color: PdfColors.blueGrey900,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 14)),
                  pw.Text("Titular: ${project.client ?? 'N/A'}",
                      style: const pw.TextStyle(
                          color: PdfColors.grey700, fontSize: 10)),
                  pw.Text(
                      "Fecha: ${DateTime.now().toIso8601String().split('T')[0]}",
                      style: const pw.TextStyle(
                          color: PdfColors.grey700, fontSize: 10)),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 5),
          pw.Container(height: 2, color: PdfColors.blueGrey900),
        ],
      ),
    );
  }

  pw.Widget _buildFooter(Project project, pw.Context context) {
    return pw.Container(
      margin: const pw.EdgeInsets.only(top: 10),
      decoration: const pw.BoxDecoration(
        border:
            pw.Border(top: pw.BorderSide(color: PdfColors.grey300, width: 0.5)),
      ),
      padding: const pw.EdgeInsets.only(top: 5),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text("Generado automáticamente",
              style: const pw.TextStyle(color: PdfColors.grey500, fontSize: 8)),
          pw.Text("Página ${context.pageNumber} de ${context.pagesCount}",
              style:
                  const pw.TextStyle(color: PdfColors.grey700, fontSize: 10)),
        ],
      ),
    );
  }

  // --- Executive Summary ---

  pw.Widget _buildSummaryCard(String title, String value,
      {PdfColor? valueColor}) {
    return pw.Expanded(
      child: pw.Container(
        padding: const pw.EdgeInsets.all(12),
        decoration: pw.BoxDecoration(
          color: PdfColors.grey100,
          borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
          border: pw.Border.all(color: PdfColors.grey300),
        ),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(title,
                style: const pw.TextStyle(
                  fontSize: 10,
                  color: PdfColors.grey700,
                  // uppercase: true, // Not available in all versions, skipping
                )),
            pw.SizedBox(height: 4),
            pw.Text(value,
                style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    color: valueColor ?? PdfColors.blueGrey900)),
          ],
        ),
      ),
    );
  }

  pw.Widget _buildExecutiveSummary(Project project) {
    int totalCircuits = 0;
    double maxIcc = 0;
    String voltageText = "230 V";

    if (project.root != null) {
      final nodes = TreeUtilities.flattenElectricalNodes(project.root!);
      totalCircuits =
          nodes.where((n) => n.result != null).length; // Count calculated nodes

      // Basic voltage check
      project.root!.map(
          source: (s) =>
              voltageText = "${s.nominalVoltage.toStringAsFixed(0)} V",
          panel: (p) =>
              voltageText = "${p.nominalVoltage.toStringAsFixed(0)} V",
          protection: (_) {},
          load: (_) {});

      // Find max Icc
      for (var n in nodes) {
        final icc = n.result?.maxShortCircuitCurrent ?? 0;
        if (icc > maxIcc) maxIcc = icc;
      }
    }

    return pw.Row(
      children: [
        _buildSummaryCard("TENSIÓN DE SUMINISTRO", voltageText),
        pw.SizedBox(width: 10),
        _buildSummaryCard("TOTAL CIRCUITOS", "$totalCircuits"),
        pw.SizedBox(width: 10),
        _buildSummaryCard(
            "ICC MÁXIMA (TOTAL)", "${maxIcc.toStringAsFixed(2)} kA",
            valueColor: PdfColors.red700),
      ],
    );
  }

  // --- Styled Table & Grouping ---

  pw.Widget _buildStyledTable(ElectricalNode? root) {
    if (root == null) return pw.Text("No hay datos para mostrar.");

    final rows = <pw.TableRow>[];

    // Header Row
    rows.add(pw.TableRow(
      decoration: const pw.BoxDecoration(color: PdfColors.blueGrey900),
      children: [
        _buildTH("CIRCUITO", alignLeft: true),
        _buildTH("PROT\nIN"),
        _buildTH("CURVA\nPDC"),
        _buildTH("S\n(mm²)"),
        _buildTH("MAT\nL(m)"),
        _buildTH("Ib\n(A)"),
        _buildTH("Iz\n(A)"),
        _buildTH("CAIDA\n(%)"),
        _buildTH("ICC\n(kA)"),
        _buildTH("ESTADO"),
      ],
    ));

    final groups = _groupNodesByContainer(root);

    int rowIndex = 0;

    groups.forEach((groupName, nodes) {
      // Section Header
      rows.add(pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey300),
          children: [
            pw.Container(
                padding:
                    const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                child: pw.Row(children: [
                  pw.Text(groupName.toUpperCase(),
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 8))
                ])),
            for (int i = 0; i < 9; i++) pw.Container(),
          ]));

      // Circuit Rows
      for (var node in nodes) {
        final res = node.result;
        final isError = res?.hasErrors ?? false;
        final bgColor = rowIndex % 2 == 0
            ? PdfColors.white
            : const PdfColor.fromInt(0xFFF5F5F5);
        const errorBg = PdfColor.fromInt(0xFFFFEBEE);

        rows.add(pw.TableRow(
            decoration: pw.BoxDecoration(color: isError ? errorBg : bgColor),
            children: [
              _buildCell(_sanitize(node.name), alignLeft: true),

              // Protection: Rating + Curve/PDC in Column
              _buildStyledCell(_getProtectionType(node),
                  "${_getProtectionRating(node)}\n${_getProtectionCurveOrSens(node)} ${_getProtectionPDC(node)}"),

              _buildCell(_getCableSection(node), isNumber: true),

              // Material/Length in styled Column
              _buildStyledCell(_getCableMaterial(node), _getCableLength(node)),

              // Calcs
              _buildCell(res?.designCurrent.toStringAsFixed(2) ?? "-",
                  isNumber: true),
              _buildCell(res?.admissibleCurrent.toStringAsFixed(2) ?? "-",
                  isNumber: true),

              // Voltage Drop
              _buildCell(
                  (res?.voltageDrop ?? 0) > 0
                      ? "${res?.voltageDrop.toStringAsFixed(2)}%"
                      : "-",
                  isNumber: true,
                  color: (res?.voltageDrop ?? 0) > 3.0
                      ? PdfColors.red
                      : PdfColors.black),

              // Icc Max
              _buildCell(res?.maxShortCircuitCurrent.toStringAsFixed(2) ?? "-",
                  isNumber: true),

              _buildStatusBadge(isError),
            ]));
        rowIndex++;
      }
    });

    return pw.Table(
      columnWidths: {
        0: const pw.FixedColumnWidth(80), // Circuito
        1: const pw.FixedColumnWidth(55), // Prot+IN
        2: const pw.FixedColumnWidth(50), // Curva/PDC
        3: const pw.FixedColumnWidth(35), // Sección
        4: const pw.FixedColumnWidth(40), // Material/Long
        5: const pw.FixedColumnWidth(35), // Ib
        6: const pw.FixedColumnWidth(35), // Iz
        7: const pw.FixedColumnWidth(40), // V.Drop
        8: const pw.FixedColumnWidth(40), // Icc
        9: const pw.FixedColumnWidth(40), // Estado
      },
      border: pw.TableBorder.all(width: 0.5, color: PdfColors.grey300),
      children: rows,
    );
  }

  // --- Cell Builders ---

  pw.Widget _buildTH(String text, {bool alignLeft = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(4),
      child: pw.Text(text,
          textAlign: alignLeft ? pw.TextAlign.left : pw.TextAlign.center,
          style: pw.TextStyle(
              color: PdfColors.white,
              fontWeight: pw.FontWeight.bold,
              fontSize: 7)),
    );
  }

  pw.Widget _buildCell(String text,
      {bool isNumber = false,
      PdfColor color = PdfColors.black,
      bool alignLeft = false}) {
    final align = alignLeft
        ? pw.Alignment.centerLeft
        : (isNumber ? pw.Alignment.centerRight : pw.Alignment.centerLeft);

    final textAlign = alignLeft
        ? pw.TextAlign.left
        : (isNumber ? pw.TextAlign.right : pw.TextAlign.left);

    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      alignment: align,
      child: pw.Text(text,
          textAlign: textAlign, style: pw.TextStyle(color: color, fontSize: 8)),
    );
  }

  pw.Widget _buildStyledCell(String primaryText, String secondaryText) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      alignment: pw.Alignment.centerRight,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          pw.Text(primaryText,
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
          if (secondaryText != "-" && secondaryText.isNotEmpty)
            pw.Text(secondaryText,
                style:
                    const pw.TextStyle(fontSize: 7, color: PdfColors.grey700)),
        ],
      ),
    );
  }

  pw.Widget _buildStatusBadge(bool isError) {
    return pw.Container(
        alignment: pw.Alignment.center,
        padding: const pw.EdgeInsets.symmetric(vertical: 4),
        child: isError
            ? pw.Text("ERROR",
                style: pw.TextStyle(
                    color: PdfColors.red900,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 7))
            : pw.Text("OK",
                style: pw.TextStyle(
                    color: PdfColors.green700,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 7)));
  }

  // --- Data Helpers ---

  String _sanitize(String text) {
    return text.replaceAll(RegExp(r'[^\x00-\x7F]+'), '');
  }

  // Grouping logic
  Map<String, List<ElectricalNode>> _groupNodesByContainer(
      ElectricalNode root) {
    final Map<String, List<ElectricalNode>> groups = {};

    void recurse(ElectricalNode node, String currentGroup) {
      if (groups[currentGroup] == null) {
        groups[currentGroup] = [];
      }
      groups[currentGroup]!.add(node);

      String nextGroup = currentGroup;
      node.map(
          source: (s) {
            nextGroup = "Suministro Principal";
            for (var c in s.children) {
              recurse(c, nextGroup);
            }
          },
          panel: (p) {
            final myChildrenGroup = "Cuadro: ${p.name}";
            for (var c in p.children) {
              recurse(c, myChildrenGroup);
            }
          },
          protection: (p) {
            for (var c in p.children) {
              recurse(c, nextGroup);
            }
          },
          load: (_) {});
    }

    root.map(
        source: (s) {
          for (var c in s.children) {
            recurse(c, "Cuadro General");
          }
        },
        panel: (p) {
          for (var c in p.children) {
            recurse(c, "Cuadro ${p.name}");
          }
        },
        protection: (_) {},
        load: (_) {});

    return groups;
  }

  // --- Field Extractors ---

  String _getProtectionType(ElectricalNode node) {
    return node.map(
      source: (_) => "TRAFO",
      panel: (_) => "CUADRO",
      protection: (n) {
        if (n.protectionType == ProtectionType.circuitBreaker) return "IGA";
        if (n.protectionType == ProtectionType.differential) return "DIF";
        if (n.protectionType == ProtectionType.fuse) return "FUS";
        return "OTR";
      },
      load: (_) => "CARGA",
    );
  }

  String _getProtectionRating(ElectricalNode node) {
    return node.map(
      source: (_) => "-",
      panel: (_) => "-",
      protection: (n) => "${n.ratingAmps.toStringAsFixed(0)}A",
      load: (_) => "-",
    );
  }

  String _getProtectionCurveOrSens(ElectricalNode node) {
    return node.map(
      source: (_) => "-",
      panel: (_) => "-",
      protection: (n) {
        if (n.protectionType == ProtectionType.differential) {
          return "${n.sensitivity.toStringAsFixed(0)}mA";
        }
        return n.curve;
      },
      load: (_) => "-",
    );
  }

  String _getProtectionPDC(ElectricalNode node) {
    return node.map(
        source: (_) => "-",
        panel: (_) => "-",
        protection: (n) => n.pdc != null ? "${n.pdc}kA" : "-",
        load: (_) => "-");
  }

  String _getCableSection(ElectricalNode node) {
    return node.map(
        source: (_) => "-",
        panel: (n) =>
            n.inputCable != null ? "${n.inputCable!.sectionMm2}" : "-",
        protection: (_) => "-", // Protection nodes don't have cable
        load: (n) =>
            n.inputCable != null ? "${n.inputCable!.sectionMm2}" : "-");
  }

  String _getCableMaterial(ElectricalNode node) {
    final mat = node.map(
        source: (_) => null,
        panel: (n) => n.inputCable?.material,
        protection: (_) => null, // Protection nodes don't have cable
        load: (n) => n.inputCable?.material);
    if (mat == null) return "-";
    return mat == ConductorMaterial.copper ? "Cu" : "Al";
  }

  String _getCableLength(ElectricalNode node) {
    return node.map(
        source: (_) => "-",
        panel: (n) => n.inputCable?.lengthMeters != null
            ? "${n.inputCable!.lengthMeters.toStringAsFixed(0)}m"
            : "-",
        protection: (_) => "-", // Protection nodes don't have cable
        load: (n) => n.inputCable?.lengthMeters != null
            ? "${n.inputCable!.lengthMeters.toStringAsFixed(0)}m"
            : "-");
  }
}
