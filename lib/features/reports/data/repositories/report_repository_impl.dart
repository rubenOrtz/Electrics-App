import 'dart:typed_data';
import '../../domain/repositories/report_repository.dart';
import '../../../projects/domain/entities/project.dart';
import '../generators/technical_memory_generator.dart';

class ReportRepositoryImpl implements ReportRepository {
  final TechnicalMemoryGenerator technicalMemoryGenerator;

  ReportRepositoryImpl({required this.technicalMemoryGenerator});

  @override
  Future<Uint8List> generateTechnicalMemory(Project project) async {
    return technicalMemoryGenerator.generate(project);
  }
}
