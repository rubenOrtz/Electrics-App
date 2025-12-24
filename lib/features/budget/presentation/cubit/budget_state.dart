import '../../domain/entities/budget_item.dart';

class BudgetState {
  final List<BudgetItem> items;
  final double netTotal;
  final double marginPercent;
  final double taxPercent;
  final bool includeTax;

  // Computed
  double get marginAmount => netTotal * (marginPercent / 100);
  double get subtotalWithMargin => netTotal + marginAmount;
  double get taxAmount =>
      includeTax ? subtotalWithMargin * (taxPercent / 100) : 0.0;
  double get finalTotal => subtotalWithMargin + taxAmount;

  const BudgetState({
    required this.items,
    required this.netTotal,
    this.marginPercent = 20.0,
    this.taxPercent = 21.0,
    this.includeTax = true,
  });

  factory BudgetState.initial() {
    return const BudgetState(items: [], netTotal: 0.0);
  }

  BudgetState copyWith({
    List<BudgetItem>? items,
    double? netTotal,
    double? marginPercent,
    bool? includeTax,
  }) {
    return BudgetState(
      items: items ?? this.items,
      netTotal: netTotal ?? this.netTotal,
      marginPercent: marginPercent ?? this.marginPercent,
      taxPercent: taxPercent,
      includeTax: includeTax ?? this.includeTax,
    );
  }
}
