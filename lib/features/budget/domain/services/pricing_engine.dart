import '../../../diagram/domain/entities/electrical_node.dart';
import '../../domain/entities/budget_item.dart';
import '../../domain/repositories/price_repository.dart';
import 'material_aggregator_service.dart';
import '../../../projects/domain/entities/budget_config.dart';

class PricingEngine {
  final PriceRepository repository;
  final MaterialAggregatorService aggregator;

  PricingEngine(this.repository, {MaterialAggregatorService? aggregator})
      : aggregator = aggregator ?? MaterialAggregatorService();

  Future<List<BudgetItem>> calculateBudget(ElectricalNode root,
      {BudgetConfig? config}) async {
    // 1. Aggregate Items (raw without price)
    final rawItems = await aggregator.aggregate(root);
    final effectiveConfig = config ?? const BudgetConfig();

    // 2. Apply Prices
    List<BudgetItem> pricedItems = [];
    double materialSubtotal = 0;

    for (var item in rawItems) {
      double price = await repository.getPrice(item.id) ?? 0.0;

      // Use price from aggregator (Library Resolution) if repository didn't return one
      if (price == 0.0 && item.unitPrice > 0) {
        price = item.unitPrice;
      }

      // Fallback/Smart Pricing if still 0.0
      if (price == 0.0) {
        price = _estimatePrice(item);
      }

      final budgetItem = BudgetItem(
        id: item.id,
        name: item.name,
        description: item.description,
        quantity: item.quantity,
        unitPrice: price,
        category: item.category,
      );

      pricedItems.add(budgetItem);
      materialSubtotal += budgetItem.total;
    }

    // 3. Add Extras (Small Material)
    if (effectiveConfig.smallMaterialPercent > 0) {
      final smallMatCost =
          materialSubtotal * (effectiveConfig.smallMaterialPercent / 100);
      pricedItems.add(BudgetItem(
        id: 'SMALL-MAT',
        name: 'Peque\u00F1o Material',
        description:
            '${effectiveConfig.smallMaterialPercent}% sobre materiales (Torniller\u00EDa, etc.)',
        quantity: 1,
        unitPrice: smallMatCost,
        category: BudgetCategory.smallMaterial,
      ));
    }

    // 4. Add Labor
    double laborCost = 0;
    String laborDesc = "";
    if (effectiveConfig.laborCostType == LaborCostType.hourly) {
      laborCost = effectiveConfig.laborRate * effectiveConfig.laborTime;
      laborDesc =
          "${effectiveConfig.laborTime}h x ${effectiveConfig.laborRate} \u20AC/h";
    } else {
      laborCost = effectiveConfig.fixedLaborCost;
      laborDesc = "Coste fijo acordado";
    }

    if (laborCost > 0) {
      pricedItems.add(BudgetItem(
        id: 'LABOR',
        name: 'Mano de Obra y Servicios',
        description: laborDesc,
        quantity: 1,
        unitPrice: laborCost,
        category: BudgetCategory.labor,
      ));
    }

    return pricedItems;
  }

  double _estimatePrice(BudgetItem item) {
    // Fallback strategy per category/id
    if (item.category == BudgetCategory.cable) {
      if (item.id.contains('1.5')) return 0.90;
      if (item.id.contains('2.5')) return 1.30;
      if (item.id.contains('4.0')) return 2.10;
      if (item.id.contains('6.0')) return 3.00;
      if (item.id.contains('10.0')) return 5.50;
      return 2.00;
    }

    if (item.category == BudgetCategory.enclosure) return 150.0;

    if (item.category == BudgetCategory.protection) {
      // Simple heuristic based on Amps could be added here if ID contains it
      return 15.0;
    }

    return 10.0;
  }
}
