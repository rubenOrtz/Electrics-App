enum BudgetCategory {
  protection,
  cable,
  enclosure,
  generic,
  labor,
  smallMaterial
}

class BudgetItem {
  final String id;
  final String name;
  final String description;
  final double quantity;
  final double unitPrice;
  final BudgetCategory category;

  const BudgetItem({
    required this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.category,
  });

  double get total => quantity * unitPrice;
}
