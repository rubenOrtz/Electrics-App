import 'dart:typed_data';
import '../../../../projects/domain/entities/project.dart';
import '../document_strategy.dart';
import '../../../data/generators/single_line_diagram_generator.dart';
import '../../../data/generators/technical_memory_generator.dart';
import '../../../data/generators/budget_pdf_generator.dart';
import '../../../data/generators/user_manual_generator.dart';
import 'package:pdf/widgets.dart' as pw;

class AndaluciaDocumentStrategy implements DocumentStrategy {
  @override
  String get regionName => "Andalucía";

  @override
  Future<Map<String, Uint8List>> generateDocumentPack(Project project) async {
    // Instantiate specific generators
    final singleLineGen = SingleLineDiagramGenerator();
    final memoryGen = TechnicalMemoryGenerator();
    final budgetGen = BudgetPdfGenerator();
    final manualGen = UserManualGenerator();

    return {
      "1_Esquema_Unifilar.pdf": await singleLineGen.generate(project),
      "2_Memoria_Tecnica.pdf": await memoryGen.generate(project),
      "3_Presupuesto_Materiales.pdf":
          await budgetGen.generate(project: project),
      "4_Manual_Usuario.pdf": await manualGen.generate(project),
    };
  }

  @override
  Future<Uint8List> generateUnified(Project project) async {
    final pdf = pw.Document();

    // Order matters for unified doc
    final singleLineGen = SingleLineDiagramGenerator();
    final memoryGen = TechnicalMemoryGenerator();
    final budgetGen = BudgetPdfGenerator();
    final manualGen = UserManualGenerator();

    await memoryGen.build(pdf, project);
    await singleLineGen.build(pdf, project);
    await budgetGen.build(pdf, project);
    await manualGen.build(pdf, project);

    return pdf.save();
  }
}
