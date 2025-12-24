import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../projects/domain/entities/project.dart';
import '../../../budget/data/repositories/mock_price_repository.dart';
import '../../../budget/domain/entities/budget_item.dart';
import '../../../budget/domain/services/pricing_engine.dart';
import '../../../budget/domain/services/material_aggregator_service.dart';

class BudgetPdfGenerator {
  Future<Uint8List> generate({
    required Project project,
    List<BudgetItem>? items,
    double? netTotal,
    double? marginAmount,
    double? subtotal,
    double? taxAmount,
    double? finalTotal,
  }) async {
    final pdf = pw.Document();
    await build(pdf, project,
        items: items,
        netTotal: netTotal,
        marginAmount: marginAmount,
        subtotal: subtotal,
        taxAmount: taxAmount,
        finalTotal: finalTotal);
    return pdf.save();
  }

  Future<void> build(
    pw.Document pdf,
    Project project, {
    List<BudgetItem>? items,
    double? netTotal,
    double? marginAmount,
    double? subtotal,
    double? taxAmount,
    double? finalTotal,
  }) async {
    List<BudgetItem> finalItems;
    double finalNetTotal;
    double finalMarginAmount;
    double finalSubtotal;
    double finalTaxAmount;
    double finalFinalTotal;

    if (items != null &&
        netTotal != null &&
        marginAmount != null &&
        subtotal != null &&
        taxAmount != null &&
        finalTotal != null) {
      finalItems = items;
      finalNetTotal = netTotal;
      finalMarginAmount = marginAmount;
      finalSubtotal = subtotal;
      finalTaxAmount = taxAmount;
      finalFinalTotal = finalTotal;
    } else {
      if (project.root == null) return;
      final repo = MockPriceRepository();
      final aggregator = MaterialAggregatorService();
      final engine = PricingEngine(repo, aggregator: aggregator);
      finalItems = await engine.calculateBudget(project.root!,
          config: project.budgetConfig);

      // Constants (Should match BudgetCubit defaults if possible)
      const marginPercent = 20.0;
      const taxPercent = 21.0; // Default if not passed

      finalNetTotal = finalItems.fold(0.0, (sum, item) => sum + item.total);
      finalMarginAmount = finalNetTotal * (marginPercent / 100);
      finalSubtotal = finalNetTotal + finalMarginAmount;
      finalTaxAmount = finalSubtotal * (taxPercent / 100);
      finalFinalTotal = finalSubtotal + finalTaxAmount;
    }

    // Corporate Color
    const PdfColor brandColor = PdfColors.blue800;
    const PdfColor headerBg = PdfColors.grey200;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => [
          _buildHeaderProforma(project, brandColor, headerBg),
          pw.SizedBox(height: 30),
          _buildSplitItemsTable(finalItems, brandColor),
          pw.SizedBox(height: 20),
          _buildFooterProforma(finalNetTotal, finalMarginAmount, finalSubtotal,
              finalTaxAmount, finalFinalTotal, brandColor),
          pw.Spacer(),
          _buildTermsAndConditions(),
        ],
      ),
    );
  }

  pw.Widget _buildSplitItemsTable(List<BudgetItem> items, PdfColor brandColor) {
    // Split items
    // Explicitly services are LABOR. Everything else = Material.
    // Or Small Material is Material.

    final laborItems =
        items.where((i) => i.category == BudgetCategory.labor).toList();
    final materialItems =
        items.where((i) => i.category != BudgetCategory.labor).toList();

    return pw.Column(children: [
      if (materialItems.isNotEmpty) ...[
        pw.Container(
            alignment: pw.Alignment.centerLeft,
            padding: const pw.EdgeInsets.only(bottom: 5),
            child: pw.Text("MATERIALES",
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold, color: brandColor))),
        _buildItemsTableProforma(materialItems, brandColor),
        pw.SizedBox(height: 15),
      ],
      if (laborItems.isNotEmpty) ...[
        pw.Container(
            alignment: pw.Alignment.centerLeft,
            padding: const pw.EdgeInsets.only(bottom: 5),
            child: pw.Text("SERVICIOS / MANO DE OBRA",
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold, color: brandColor))),
        _buildItemsTableProforma(laborItems, brandColor),
      ]
    ]);
  }

  pw.Widget _buildHeaderProforma(
      Project project, PdfColor brandColor, PdfColor bg) {
    // Generate Ref ID if missing
    final ref = (project.reference != null &&
            project.reference!.isNotEmpty &&
            project.reference != 'null')
        ? project.reference!
        : "P-${DateTime.now().year}-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}";

    final date = DateTime.now();
    final dateStr = "${date.day}/${date.month}/${date.year}";

    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Left: Issuer Data
        pw.Expanded(
          flex: 3,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Placeholder Logo
              pw.Container(
                  width: 50,
                  height: 50,
                  color: brandColor,
                  alignment: pw.Alignment.center,
                  child: pw.Text("LOGO",
                      style: const pw.TextStyle(color: PdfColors.white))),
              pw.SizedBox(height: 10),
              pw.Text("MI EMPRESA DE ELECTRICIDAD S.L.",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text("C/ Electricidad 123, Pol. Ind."),
              pw.Text("28000 Madrid, Espa\u00F1a"),
              pw.Text("CIF: B-12345678"),
              pw.Text("Tel: +34 912 345 678"),
              pw.Text("Email: info@miempresa.com"),
            ],
          ),
        ),

        pw.SizedBox(width: 20),

        // Right: Client & Budget Data
        pw.Expanded(
          flex: 4,
          child: pw.Container(
            padding: const pw.EdgeInsets.all(15),
            decoration: pw.BoxDecoration(
              color: bg,
              borderRadius: pw.BorderRadius.circular(8),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("PRESUPUESTO / PROFORMA",
                    style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                        color: brandColor)),
                pw.Divider(color: brandColor),
                pw.SizedBox(height: 5),
                _buildLabelValue("N\u00BA Referencia:", ref),
                _buildLabelValue("Fecha Emisi\u00F3n:", dateStr),
                _buildLabelValue("Validez:", "30 D\u00EDas"),
                pw.SizedBox(height: 15),
                pw.Text("CLIENTE:",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(project.client ?? "Cliente Desconocido",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 12)),
                pw.Text("Direcci\u00F3n del Proyecto:"),
                // Assuming project reference captures location or just placeholder
                pw.Text("Ubicaci\u00F3n de la obra pendiente de definir",
                    style: const pw.TextStyle(
                        fontSize: 10, color: PdfColors.grey700)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _buildLabelValue(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 2),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label,
              style:
                  const pw.TextStyle(fontSize: 10, color: PdfColors.grey700)),
          pw.Text(value,
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10)),
        ],
      ),
    );
  }

  pw.Widget _buildItemsTableProforma(
      List<BudgetItem> items, PdfColor brandColor) {
    // Header Row
    final tableHeaders = ["CONCEPTO", "CANTIDAD", "PRECIO UNIT.", "TOTAL"];

    return pw.TableHelper.fromTextArray(
      headers: tableHeaders,
      data: items
          .map((item) => [
                item.name,
                item.quantity.toStringAsFixed(1),
                "${item.unitPrice.toStringAsFixed(2)} \u20AC",
                "${item.total.toStringAsFixed(2)} \u20AC"
              ])
          .toList(),
      border: null,
      headerStyle: pw.TextStyle(
          color: PdfColors.white, fontWeight: pw.FontWeight.bold, fontSize: 10),
      headerDecoration: pw.BoxDecoration(color: brandColor),
      rowDecoration: const pw.BoxDecoration(
          border: pw.Border(
              bottom: pw.BorderSide(color: PdfColors.grey200, width: 0.5))),
      cellAlignment: pw.Alignment.centerLeft,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.center,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.centerRight,
      },
      cellStyle: const pw.TextStyle(fontSize: 10),
      cellPadding: const pw.EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      oddRowDecoration: const pw.BoxDecoration(color: PdfColors.grey100),
    );
  }

  pw.Widget _buildFooterProforma(double net, double margin, double subtotal,
      double tax, double finalTotal, PdfColor brandColor) {
    return pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
      // Spacer for Left side
      pw.Expanded(flex: 5, child: pw.SizedBox()),

      // Right Side: Totals
      pw.Expanded(
          flex: 4,
          child: pw.Column(children: [
            _buildFooterRow("Base Imponible", net),
            _buildFooterRow("Margen / Costes Ind. (20%)", margin),
            pw.Divider(),
            _buildFooterRow("Subtotal", subtotal, isBold: true),
            _buildFooterRow("IVA (21%)", tax),
            pw.SizedBox(height: 10),
            pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  color: PdfColor(
                      brandColor.red, brandColor.green, brandColor.blue, 0.1),
                  borderRadius: pw.BorderRadius.circular(5),
                ),
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("TOTAL PRESUPUESTO",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12,
                              color: brandColor)),
                      pw.Text("${finalTotal.toStringAsFixed(2)} \u20AC",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 16,
                              color: brandColor)),
                    ]))
          ]))
    ]);
  }

  pw.Widget _buildFooterRow(String label, double amount,
      {bool isBold = false}) {
    return pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 3),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(label,
                style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight:
                        isBold ? pw.FontWeight.bold : pw.FontWeight.normal)),
            pw.Text("${amount.toStringAsFixed(2)} \u20AC",
                style: pw.TextStyle(
                    fontSize: 10,
                    fontWeight:
                        isBold ? pw.FontWeight.bold : pw.FontWeight.normal)),
          ],
        ));
  }

  pw.Widget _buildTermsAndConditions() {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Divider(),
          pw.Text("T\u00E9rminos y Condiciones:",
              style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 2),
          pw.Text(
              "- La validez de este presupuesto es de 30 d\u00EDas a partir de la fecha de emisi\u00F3n.",
              style: const pw.TextStyle(fontSize: 7, color: PdfColors.grey700)),
          pw.Text(
              "- Forma de pago: 50% a la aceptaci\u00F3n y 50% a la finalizaci\u00F3n de los trabajos.",
              style: const pw.TextStyle(fontSize: 7, color: PdfColors.grey700)),
          pw.Text(
              "- No incluye tasas de licencias de obra ni visados colegiales salvo indicaci\u00F3n expresa.",
              style: const pw.TextStyle(fontSize: 7, color: PdfColors.grey700)),
          pw.SizedBox(height: 10),
          pw.Text("Documento generado por ElectricsApp Engineering Suite.",
              style: const pw.TextStyle(fontSize: 6, color: PdfColors.grey500)),
        ]);
  }
}
