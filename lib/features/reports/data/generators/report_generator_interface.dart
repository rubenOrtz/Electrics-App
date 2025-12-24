import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import '../../../projects/domain/entities/project.dart';

/// Interface for a single document generator
abstract class ReportGenerator {
  /// Generates the specific PDF document
  Future<Uint8List> generate(Project project);

  /// Appends the specific PDF content to an existing document
  Future<void> build(pw.Document pdf, Project project);
}
