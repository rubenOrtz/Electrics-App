import 'package:equatable/equatable.dart';
import '../../../../features/diagram/domain/entities/electrical_node.dart';

import 'budget_config.dart';

class Project extends Equatable {
  final int? id;
  final String name;
  final String? reference;
  final String? client;
  final DateTime createdAt;
  final DateTime updatedAt;

  // New: Store the Tree Root
  final ElectricalNode? root;

  final String? electricalStandardId;

  // New: Owner Contact
  final String? ownerPhone;
  final String? ownerEmail;

  // New: Electrical Params
  final String? supplyVoltage;
  final String? installationUsage;
  final double? expectedPower;
  final double? powerFactor;
  final bool? requiresTechProject;
  final bool? isNewLink;

  // New: Budget Config
  final BudgetConfig? budgetConfig;

  const Project({
    this.id,
    required this.name,
    this.reference,
    this.client,
    this.ownerPhone,
    this.ownerEmail,
    required this.createdAt,
    required this.updatedAt,
    this.root,
    this.electricalStandardId,
    this.budgetConfig,
    this.supplyVoltage,
    this.installationUsage,
    this.expectedPower,
    this.powerFactor,
    this.requiresTechProject,
    this.isNewLink,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        reference,
        client,
        ownerPhone,
        ownerEmail,
        createdAt,
        updatedAt,
        root,
        electricalStandardId,
        budgetConfig,
        supplyVoltage,
        installationUsage,
        expectedPower,
        powerFactor,
        requiresTechProject,
        isNewLink,
      ];
}
