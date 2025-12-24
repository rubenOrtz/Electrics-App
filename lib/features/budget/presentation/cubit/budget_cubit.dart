import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/services/pricing_engine.dart';
import '../../../diagram/domain/entities/electrical_node.dart';
import '../../../projects/domain/entities/budget_config.dart';
import 'budget_state.dart';

class BudgetCubit extends Cubit<BudgetState> {
  final PricingEngine pricingEngine;

  BudgetCubit(this.pricingEngine) : super(BudgetState.initial());

  Future<void> loadBudget(ElectricalNode? root, {BudgetConfig? config}) async {
    if (root == null) return;

    // Calculate items
    final items = await pricingEngine.calculateBudget(root, config: config);

    // Calculate net total
    double total = 0;
    for (var item in items) {
      total += item.total;
    }

    emit(state.copyWith(items: items, netTotal: total));
  }

  void updateMargin(double newMargin) {
    emit(state.copyWith(marginPercent: newMargin));
  }

  void toggleTax(bool include) {
    emit(state.copyWith(includeTax: include));
  }
}
