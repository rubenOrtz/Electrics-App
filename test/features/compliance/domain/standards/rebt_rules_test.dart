import 'package:electrician_app/features/compliance/domain/entities/compliance_base.dart';
import 'package:electrician_app/features/compliance/domain/standards/rebt_rules.dart';
import 'package:electrician_app/features/diagram/domain/entities/electrical_node.dart';
import 'package:electrician_app/features/diagram/domain/entities/electrical_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('REBT Rules', () {
    group('ItcBt19 (Voltage Drop)', () {
      late RebtItcBt19Rule rule;

      setUp(() {
        rule = RebtItcBt19Rule();
      });

      test('validates compliant node (drop <= 5%)', () {
        // Use real instances with specific state
        final node = ElectricalNode.panel(
          id: '1',
          name: 'Panel',
          children: [],
          nominalVoltage: 230,
          state: const ElectricalState(voltageDropPercent: 3.0),
        );

        // Act
        final results = rule.validate(node);

        // Assert
        expect(results, isEmpty);
      });

      test('detects violation (drop > 5%)', () {
        final node = ElectricalNode.panel(
          id: '2',
          name: 'Panel Bad',
          children: [],
          nominalVoltage: 230,
          state: const ElectricalState(voltageDropPercent: 5.1),
        );

        final results = rule.validate(node);

        expect(results, isNotEmpty);
        expect(results.first.severity, ValidationSeverity.error);
        expect(results.first.message, contains('Caída de tensión excesiva'));
      });
    });
  });
}
