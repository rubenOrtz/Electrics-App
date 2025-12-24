import 'dart:typed_data';
import '../../../projects/domain/entities/project.dart';

abstract class ReportRepository {
  Future<Uint8List> generateTechnicalMemory(Project project);
  // Future<Uint8List> generateSingleLineDiagram(Project project); // Uncomment when integrating
}
