import 'dart:typed_data';
import '../../../projects/domain/entities/project.dart';
import '../../../diagram/domain/services/electrical_calculator.dart';
import 'document_strategy.dart';
import 'strategies/andalucia_document_strategy.dart';

class DocumentService {
  final DocumentStrategy _strategy;

  // In a real app, we might inject this or choose it based on Project data.
  // For now, defaulting to Andalucia as requested.
  DocumentService({DocumentStrategy? strategy})
      : _strategy = strategy ?? AndaluciaDocumentStrategy();

  Future<Map<String, Uint8List>> generateProjectDocuments(
      Project project) async {
    final calculatedProject = _ensureCalculated(project);
    return _strategy.generateDocumentPack(calculatedProject);
  }

  Future<Uint8List> generateUnified(Project project) async {
    final calculatedProject = _ensureCalculated(project);
    return _strategy.generateUnified(calculatedProject);
  }

  Project _ensureCalculated(Project project) {
    if (project.root == null) return project;

    // Force a fresh calculation to ensure all results (Voltage Drop, Icc, Iz) are populated
    final calculatedRoot = ElectricalCalculator.recalculateTree(project.root!);

    // Return a new project instance with the calculated tree
    return Project(
      id: project.id,
      name: project.name,
      reference: project.reference,
      client: project.client,
      createdAt: project.createdAt,
      updatedAt: project.updatedAt,
      root: calculatedRoot,
      electricalStandardId: project.electricalStandardId,
    );
  }

  // Factory method if we need to switch strategies dynamically later
  static DocumentStrategy getStrategyForRegion(String regionCode) {
    switch (regionCode) {
      case 'AND':
        return AndaluciaDocumentStrategy();
      default:
        return AndaluciaDocumentStrategy(); // Default or throw
    }
  }
}
