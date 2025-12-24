import 'package:equatable/equatable.dart';

enum LaborCostType { hourly, fixed }

class BudgetConfig extends Equatable {
  final LaborCostType laborCostType;
  final double laborRate;
  final double laborTime;
  final double fixedLaborCost;
  final double smallMaterialPercent;

  const BudgetConfig({
    this.laborCostType = LaborCostType.hourly,
    this.laborRate = 40.0,
    this.laborTime = 0.0,
    this.fixedLaborCost = 0.0,
    this.smallMaterialPercent = 3.0,
  });

  factory BudgetConfig.fromJson(Map<String, dynamic> json) {
    return BudgetConfig(
      laborCostType: LaborCostType.values.firstWhere(
          (e) => e.toString() == json['laborCostType'],
          orElse: () => LaborCostType.hourly),
      laborRate: (json['laborRate'] as num?)?.toDouble() ?? 40.0,
      laborTime: (json['laborTime'] as num?)?.toDouble() ?? 0.0,
      fixedLaborCost: (json['fixedLaborCost'] as num?)?.toDouble() ?? 0.0,
      smallMaterialPercent:
          (json['smallMaterialPercent'] as num?)?.toDouble() ?? 3.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'laborCostType': laborCostType.toString(),
      'laborRate': laborRate,
      'laborTime': laborTime,
      'fixedLaborCost': fixedLaborCost,
      'smallMaterialPercent': smallMaterialPercent,
    };
  }

  BudgetConfig copyWith({
    LaborCostType? laborCostType,
    double? laborRate,
    double? laborTime,
    double? fixedLaborCost,
    double? smallMaterialPercent,
  }) {
    return BudgetConfig(
      laborCostType: laborCostType ?? this.laborCostType,
      laborRate: laborRate ?? this.laborRate,
      laborTime: laborTime ?? this.laborTime,
      fixedLaborCost: fixedLaborCost ?? this.fixedLaborCost,
      smallMaterialPercent: smallMaterialPercent ?? this.smallMaterialPercent,
    );
  }

  @override
  List<Object?> get props => [
        laborCostType,
        laborRate,
        laborTime,
        fixedLaborCost,
        smallMaterialPercent
      ];
}
