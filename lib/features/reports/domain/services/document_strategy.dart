import 'dart:typed_data';
import '../../../projects/domain/entities/project.dart';

/// Strategy interface for a specific regional document pack
abstract class DocumentStrategy {
  String get regionName;

  /// Generates the complete "Pack Documental" as a list of PDFs (or a single merged PDF if preferred,
  /// but usually 4 separate docs are better for flexibility).
  /// Returns a Map where key is the document name and value is the PDF bytes.
  Future<Map<String, Uint8List>> generateDocumentPack(Project project);

  /// Generates a single unified PDF containing all documents
  Future<Uint8List> generateUnified(Project project);
}
