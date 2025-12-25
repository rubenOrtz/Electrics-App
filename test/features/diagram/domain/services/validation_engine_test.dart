import 'package:flutter_test/flutter_test.dart';
import 'package:electrician_app/features/diagram/domain/services/validation_engine.dart';
import 'package:electrician_app/features/diagram/domain/entities/electrical_node.dart';
import 'package:electrician_app/features/diagram/domain/entities/calculation_result.dart';
import 'package:electrician_app/features/diagram/domain/entities/validation_status.dart';

void main() {
  group('ValidationEngine', () {
    test('validateGoldenRule - Ib > In returns Warning', () {
      final node = ElectricalNode.protection(
        id: 'p1',
        name: 'Prot 1',
        children: [],
        ratingAmps: 10, // In = 10A
        result: const CalculationResult(
          designCurrent: 11, // Ib = 11A (> 10A)
        ),
      );

      final resultNode = ValidationEngine.validateTree(node);

      final warnings = resultNode.result!.warnings;
      expect(warnings.length, greaterThan(0));
      expect(warnings.first.message, contains('excede el calibre'));
    });

    test('validateBreakingCapacity - IccMax > Pdc returns Error', () {
      final node = ElectricalNode.protection(
        id: 'p1',
        name: 'Prot 1',
        children: [],
        pdc: 6, // 6 kA
        result: const CalculationResult(
          maxShortCircuitCurrent: 7000, // 7 kA
        ),
      );

      final resultNode = ValidationEngine.validateTree(node);

      final errors = resultNode.result!.errors;
      expect(errors.isNotEmpty, true);
      final error = errors.first as ShortCircuitError;
      expect(error.shortCircuitCurrent, 7.0);
      expect(error.breakingCapacity, 6.0);
    });

    test('validateMagneticTrip - IccMin < Imag returns Error', () {
      // Curve C (10x) -> Imag = 10 * 10 = 100A
      final node = ElectricalNode.protection(
        id: 'p1',
        name: 'Prot 1',
        children: [],
        ratingAmps: 10,
        curve: 'C',
        result: const CalculationResult(
          minShortCircuitCurrent: 90, // < 100A
        ),
      );

      final resultNode = ValidationEngine.validateTree(node);

      final errors = resultNode.result!.errors;
      expect(errors.isNotEmpty, true);
      expect(errors.first, isA<UnderprotectionError>());
    });

    test('validateVoltageDrop - Drop > Limit returns Error', () {
      final node = ElectricalNode.load(
        id: 'l1',
        name: 'Load 1',
        result: const CalculationResult(
          voltageDrop: 6.0, // > 5% limit
        ),
      );

      final resultNode = ValidationEngine.validateTree(node);

      final errors = resultNode.result!.errors;
      expect(errors.isNotEmpty, true);
      expect(errors.first, isA<VoltageDropError>());
    });
  });
}
