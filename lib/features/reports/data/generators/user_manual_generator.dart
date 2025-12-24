import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../projects/domain/entities/project.dart';
import '../../../diagram/domain/entities/electrical_node.dart';
import 'report_generator_interface.dart';

class UserManualGenerator implements ReportGenerator {
  @override
  Future<Uint8List> generate(Project project) async {
    final pdf = pw.Document();
    await build(pdf, project);
    return pdf.save();
  }

  @override
  Future<void> build(pw.Document pdf, Project project) async {
    final hasDifferential = _hasNode(
        project.root,
        (n) =>
            n is ProtectionNode &&
            n.protectionType.name.contains('differential'));

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Header(level: 1, text: "Manual de Usuario y Mantenimiento"),
          pw.Paragraph(
              text:
                  "Este manual contiene instrucciones para el uso seguro de su instalación eléctrica."),
          if (hasDifferential) ...[
            pw.Header(level: 2, text: "1. Elementos de Protección"),
            _buildProtectionAdvice(),
          ],
          if (true) ...[
            // Always add general maintenance
            pw.Header(level: 2, text: "2. Plan de Mantenimiento"),
            _buildMaintenanceTable(),
          ],
          pw.SizedBox(height: 20),
          pw.Text("En caso de emergencia, llame al 112.",
              style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold, color: PdfColors.red)),
        ],
      ),
    );
  }

  bool _hasNode(ElectricalNode? root, bool Function(ElectricalNode) predicate) {
    if (root == null) return false;
    if (predicate(root)) return true;

    bool found = false;
    root.map(
      source: (n) {
        for (var c in n.children) {
          if (_hasNode(c, predicate)) found = true;
        }
      },
      panel: (n) {
        for (var c in n.children) {
          if (_hasNode(c, predicate)) found = true;
        }
      },
      protection: (n) {
        for (var c in n.children) {
          if (_hasNode(c, predicate)) found = true;
        }
      },
      load: (_) {},
    );
    return found;
  }

  pw.Widget _buildProtectionAdvice() {
    return pw.Bullet(
        text:
            "Pulse el botón de prueba 'T' de los diferenciales mensualmente para asegurar su funcionamiento.");
  }

  pw.Widget _buildMaintenanceTable() {
    return pw.Table(border: pw.TableBorder.all(), children: [
      pw.TableRow(children: [
        _cell("Elemento"),
        _cell("Acción"),
        _cell("Periodicidad")
      ]),
      pw.TableRow(children: [
        _cell("Cuadro General"),
        _cell("Inspección Visual + Test Diferenciales"),
        _cell("Mensual")
      ]),
      pw.TableRow(children: [
        _cell("Tomas de Corriente"),
        _cell("Comprobación de apriete"),
        _cell("Anual")
      ]),
    ]);
  }

  pw.Widget _cell(String text) {
    return pw.Padding(
        padding: const pw.EdgeInsets.all(5), child: pw.Text(text));
  }
}
