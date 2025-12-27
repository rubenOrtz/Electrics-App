import 'package:flutter/foundation.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/electrical_node.dart';
import '../services/electrical_calculator.dart';

class CalculateDiagramUseCase
    implements UseCase<CalculationResult, CalculateDiagramParams> {
  @override
  Future<CalculationResult> call({CalculateDiagramParams? params}) async {
    if (params == null) throw Exception("Params required");

    // Computation in Isolate - usando motor físico riguroso
    return await compute(_executeCalculation, _CalculationInput(params.root));
  }
}

class CalculateDiagramParams {
  final ElectricalNode root;
  CalculateDiagramParams(this.root);
}

class CalculationResult {
  final ElectricalNode root;
  final List<CalculationError> errors;

  CalculationResult(this.root, this.errors);
}

class CalculationError {
  final String nodeId;
  final String message;
  final String severity; // 'warning' or 'error'

  CalculationError({
    required this.nodeId,
    required this.message,
    required this.severity,
  });

  @override
  String toString() => '$severity on Node $nodeId: $message';
}

// Isolate Data
class _CalculationInput {
  final ElectricalNode root;
  _CalculationInput(this.root);
}

// --- Domain Logic (Pure Function) ---
// MOTOR FÍSICO COMPLETO: 3 Pasadas (Bottom-Up, Top-Down, Validation)
CalculationResult _executeCalculation(_CalculationInput input) {
  // Usar el motor de cálculo riguroso con física completa
  final calculatedRoot = ElectricalCalculator.recalculateTree(input.root);

  // Extraer errores y warnings de la validación
  final errors = _extractValidationErrors(calculatedRoot);

  return CalculationResult(calculatedRoot, errors);
}

/// Extrae errores y warnings del árbol validado
List<CalculationError> _extractValidationErrors(ElectricalNode node) {
  final errors = <CalculationError>[];

  // Obtener resultado de este nodo
  final result = node.map(
    source: (n) => n.result,
    panel: (n) => n.result,
    protection: (n) => n.result,
    load: (n) => n.result,
  );

  // Convertir ValidationErrors a CalculationErrors
  if (result != null) {
    errors.addAll(
      result.errors.map((error) => CalculationError(
        nodeId: node.id,
        message: error.message,
        severity: 'error',
      )),
    );

    errors.addAll(
      result.warnings.map((warning) => CalculationError(
        nodeId: node.id,
        message: warning.message,
        severity: 'warning',
      )),
    );
  }

  // Recursión para hijos usando expand para aplanar
  final children = node.map(
    source: (n) => n.children,
    panel: (n) => n.children,
    protection: (n) => n.children,
    load: (_) => <ElectricalNode>[],
  );

  errors.addAll(
    children.expand((child) => _extractValidationErrors(child)),
  );

  return errors;
}
