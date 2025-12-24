import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../diagram/domain/entities/diagram_models.dart';

class PdfService {
  Future<Uint8List> generateTechnicalMemory(
      String projectName, List<DiagramNode> nodes) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            _buildHeader(projectName),
            pw.SizedBox(height: 20),
            _buildSectionTitle("1. Objeto"),
            pw.Paragraph(
              text:
                  "El presente documento tiene por objeto describir las características técnicas de la instalación eléctrica de Baja Tensión situada en el emplazamiento indicado, garantizando el cumplimiento del Reglamento Electrotécnico para Baja Tensión (REBT).",
            ),
            pw.SizedBox(height: 10),
            _buildSectionTitle("2. Titular"),
            _buildInfoRow("Nombre / Razón Social:", "Zara España S.A."),
            _buildInfoRow("NIF:", "A-81234567"),
            pw.SizedBox(height: 10),
            _buildSectionTitle("3. Características Técnicas"),
            _buildInfoRow("Tensión:", "400V III + N"),
            _buildInfoRow("Potencia Prevista:", "15.0 kW"),
            _buildInfoRow("Uso:", "Local de Pública Concurrencia"),
            pw.SizedBox(height: 20),
            _buildSectionTitle("4. Componentes del Esquema"),
            if (nodes.isEmpty)
              pw.Text("No hay componentes definidos en el esquema.",
                  style: const pw.TextStyle(color: PdfColors.grey))
            else
              pw.TableHelper.fromTextArray(
                headerDecoration:
                    const pw.BoxDecoration(color: PdfColors.grey300),
                headerHeight: 25,
                cellHeight: 30,
                cellAlignments: {
                  0: pw.Alignment.centerLeft,
                  1: pw.Alignment.centerLeft,
                  2: pw.Alignment.centerLeft,
                },
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                headers: ['Componente', 'Tipo', 'Detalles'],
                data: nodes.map((node) {
                  String details = "";
                  if (node.type == NodeType.load) {
                    details =
                        "${node.properties['power_kw']} kW | ${node.properties['amps']} A";
                  } else if (node.type == NodeType.cable) {
                    details =
                        "${node.properties['length_m']} m | ${node.properties['section_mm2']} mm2";
                  } else if (node.type == NodeType.breaker) {
                    details = "${node.properties['rating_a']} A";
                  } else {
                    details = "-";
                  }

                  return [
                    node.properties['name'] ?? node.label,
                    node.type.name.toUpperCase(),
                    details,
                  ];
                }).toList(),
              ),
            pw.SizedBox(height: 20),
            pw.Divider(),
            pw.SizedBox(height: 10),
            pw.Center(
                child: pw.Text("Generado automáticamente por ElectricianApp",
                    style: const pw.TextStyle(
                        fontSize: 10, color: PdfColors.grey))),
          ];
        },
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildHeader(String title) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text("MEMORIA TÉCNICA DE DISEÑO (MTD)",
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 8),
        pw.Text("Proyecto: $title",
            style: const pw.TextStyle(fontSize: 14, color: PdfColors.grey700)),
        pw.Divider(thickness: 2),
      ],
    );
  }

  pw.Widget _buildSectionTitle(String title) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8, top: 8),
      child: pw.Text(title,
          style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
    );
  }

  pw.Widget _buildInfoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: const pw.TextStyle(fontSize: 12)),
          pw.Text(value,
              style:
                  pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
        ],
      ),
    );
  }
}
