import 'dart:typed_data';
import '../repositories/report_repository.dart';
import '../../../projects/domain/entities/project.dart';

class GenerateTechnicalMemory {
  final ReportRepository repository;

  GenerateTechnicalMemory(this.repository);

  Future<Uint8List> call(Project project) {
    return repository.generateTechnicalMemory(project);
  }
}
