import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:electrician_app/features/diagram/domain/entities/electrical_node.dart';
import 'package:electrician_app/features/diagram/domain/entities/conductor_attributes.dart';
import 'package:electrician_app/features/diagram/domain/entities/electrical_enums.dart';
import 'package:electrician_app/features/budget/domain/services/material_aggregator_service.dart';
import 'package:electrician_app/features/budget/domain/services/pricing_engine.dart';
import 'package:electrician_app/features/budget/domain/repositories/price_repository.dart';
import 'package:electrician_app/features/budget/domain/entities/budget_item.dart';
import 'package:electrician_app/features/components/domain/repositories/component_repository.dart';

class MockPriceRepository extends Mock implements PriceRepository {}

class MockComponentRepository extends Mock implements ComponentRepository {}

void main() {
  group('Budget Services', () {
    late MockPriceRepository mockPriceRepo;
    late MockComponentRepository mockComponentRepo;

    setUp(() {
      mockPriceRepo = MockPriceRepository();
      mockComponentRepo = MockComponentRepository();
      registerFallbackValue(ComponentType.cable);
      // Stub getByType for ComponentRepository
      when(() => mockComponentRepo.getByType(any()))
          .thenAnswer((_) async => const Right([]));
    });

    test('MaterialAggregator aggregates simple tree components', () async {
      final aggregator =
          MaterialAggregatorService(componentRepository: mockComponentRepo);

      final cable = ConductorAttributes(
        sectionMm2: 2.5,
        lengthMeters: 50,
        material: ConductorMaterial.copper,
        insulation: CableInsulation.pvc,
      );

      final load = ElectricalNode.load(
        id: 'l1',
        name: 'Load',
        inputCable: cable,
        powerWatts: 1000,
        cosPhi: 0.9,
      );

      final root = ElectricalNode.panel(
        id: 'pan1',
        name: 'Panel',
        children: [load],
        nominalVoltage: 230,
      );

      final items = await aggregator.aggregate(root);

      // Expect:
      // 1. Enclosure (Panel)
      // 2. Cable (2.5mm2, 50m)

      expect(items.any((i) => i.category == BudgetCategory.enclosure), true);

      final cableItem =
          items.firstWhere((i) => i.category == BudgetCategory.cable);
      expect(cableItem.quantity, 50.0);
      expect(cableItem.name, contains('2.5 mm²'));
    });

    test('PricingEngine applies prices from repository', () async {
      final aggregator =
          MaterialAggregatorService(componentRepository: mockComponentRepo);
      final engine = PricingEngine(mockPriceRepo, aggregator: aggregator);

      // Setup Price Repo
      when(() => mockPriceRepo.getPrice(any())).thenAnswer((invocation) async {
        final id = invocation.positionalArguments[0] as String;
        if (id.contains('CABLE')) return 1.5; // 1.5 per meter
        if (id.contains('ENCLOSURE')) return 200.0;
        return 0.0;
      });

      final cable = ConductorAttributes(
        sectionMm2: 2.5,
        lengthMeters: 10,
        material: ConductorMaterial.copper,
        insulation: CableInsulation.pvc,
      );

      final root = ElectricalNode.load(
        id: 'l1',
        name: 'Load',
        inputCable: cable,
        powerWatts: 1000,
        cosPhi: 0.9,
      );

      final items = await engine.calculateBudget(root);

      final cableItem =
          items.firstWhere((i) => i.category == BudgetCategory.cable);
      expect(cableItem.unitPrice, 1.5);
      expect(cableItem.total, 1.5 * 10);
    });
  });
}
