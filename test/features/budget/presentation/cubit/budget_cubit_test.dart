import 'package:electrician_app/features/budget/domain/entities/budget_item.dart';
import 'package:electrician_app/features/budget/domain/services/pricing_engine.dart';
import 'package:electrician_app/features/budget/presentation/cubit/budget_cubit.dart';
import 'package:electrician_app/features/budget/presentation/cubit/budget_state.dart';
import 'package:electrician_app/features/diagram/domain/entities/electrical_node.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:electrician_app/features/projects/domain/entities/budget_config.dart';

class MockPricingEngine extends Mock implements PricingEngine {}

class FakeBudgetConfig extends Fake implements BudgetConfig {}

void main() {
  group('BudgetCubit', () {
    late MockPricingEngine mockEngine;

    setUp(() {
      mockEngine = MockPricingEngine();
      registerFallbackValue(ElectricalNode.panel(
          id: 'fb', name: '', children: [], nominalVoltage: 230));
      registerFallbackValue(FakeBudgetConfig());
    });

    test('initial state is empty', () {
      expect(BudgetCubit(mockEngine).state.items, isEmpty);
    });

    final dummyNode = ElectricalNode.panel(
        id: 'root', name: 'Root', children: [], nominalVoltage: 230);
    final dummyItems = [
      BudgetItem(
          id: '1',
          name: 'Item',
          description: '',
          quantity: 1,
          unitPrice: 10,
          category: BudgetCategory.generic)
    ];

    test('loadBudget updates state with items', () async {
      // Arrange
      final cubit = BudgetCubit(mockEngine);
      when(() =>
              mockEngine.calculateBudget(any(), config: any(named: 'config')))
          .thenAnswer((_) async => dummyItems);

      // Assert later
      expectLater(
        cubit.stream,
        emits(predicate<BudgetState>(
            (state) => state.items.length == 1 && state.items.first.id == '1')),
      );

      // Act
      await cubit.loadBudget(dummyNode);
      cubit.close();
    });
  });
}
