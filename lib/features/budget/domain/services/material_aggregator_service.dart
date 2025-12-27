import '../../../diagram/domain/entities/electrical_node.dart';
import '../../../diagram/domain/entities/electrical_enums.dart';
import '../../../diagram/domain/entities/conductor_attributes.dart';
import '../entities/budget_item.dart';
import '../../../../features/components/domain/repositories/component_repository.dart';
import '../../../../features/components/domain/entities/component_template.dart';

class MaterialAggregatorService {
  final ComponentRepository? componentRepository;

  MaterialAggregatorService({this.componentRepository});

  Future<List<BudgetItem>> aggregate(ElectricalNode root) async {
    final Map<String, double> cableQuantities = {};
    final Map<String, int> protectionQuantities = {};
    final Map<String, String> protectionNames = {};
    final Map<String, double> protectionRatings = {};
    int enclosureCount = 0;
    int enclosureModules = 0;

    // Helper to traverse tree
    void traverse(ElectricalNode node) {
      node.map(
        source: (_) {},
        panel: (n) {
          enclosureCount++;
          for (var child in n.children) {
            child.maybeMap(
              protection: (p) => enclosureModules += p.poles,
              orElse: () {},
            );
          }
          _processCable(n.inputCable, true, cableQuantities);
        },
        protection: (n) {
          String key;
          String name;

          if (n.catalogData != null) {
            key = n.catalogData!.componentId;
            name = "Ref: $key";
          } else {
            // Generic
            String typeShort = _getShortType(n.protectionType);
            String curve = n.curve;
            int amps = n.ratingAmps.toInt();
            key = 'GEN-$typeShort-$amps$curve';
            name = _buildGenericName(n);
          }

          protectionQuantities.update(key, (val) => val + 1, ifAbsent: () => 1);
          protectionRatings[key] = n.ratingAmps;

          if (!protectionNames.containsKey(key)) {
            protectionNames[key] = name;
          }
        },
        load: (n) {
          _processCable(n.inputCable, n.isThreePhase, cableQuantities);
        },
      );

      // Recursive
      node.maybeMap(
        source: (n) => n.children.forEach(traverse),
        panel: (n) => n.children.forEach(traverse),
        protection: (n) => n.children.forEach(traverse),
        orElse: () {},
      );
    }

    traverse(root);

    List<BudgetItem> items = [];

    // 0. Pre-fetch library cables for smart matching
    List<ComponentTemplate> libraryCables = [];
    if (componentRepository != null) {
      final result = await componentRepository!.getByType(ComponentType.cable);
      result.fold((l) => null, (r) => libraryCables = r);
    }

    // 1. Enclosures (First)
    if (enclosureCount > 0) {
      String sizeDesc =
          "Est. ${enclosureModules + (enclosureModules * 0.2).toInt()} módulos";

      items.add(BudgetItem(
        id: 'ENCLOSURE-STD',
        name: 'Cuadro Eléctrico / Envolvente',
        description: '$enclosureCount unidades ($sizeDesc)',
        quantity: enclosureCount.toDouble(),
        unitPrice: 150.0,
        category: BudgetCategory.enclosure,
      ));
    }

    // 2. Protections (Second, Sorted by Amperage)
    var protKeys = protectionQuantities.keys.toList();
    protKeys.sort((a, b) {
      double ratingA = protectionRatings[a] ?? 0;
      double ratingB = protectionRatings[b] ?? 0;
      return ratingA.compareTo(ratingB);
    });

    for (var key in protKeys) {
      final count = protectionQuantities[key]!;
      var name = protectionNames[key] ?? key;
      double price = 0.0;

      // Lookup real name if it's a catalog ID
      if (!key.startsWith('GEN-') && componentRepository != null) {
        try {
          final result = await componentRepository!.getById(key);
          result.fold(
            (l) => null,
            (comp) {
              final manu = comp.manufacturer ?? "";
              final model = comp.name;
              name = "$manu $model".trim();

              // Capture price from library
              comp.maybeMap(
                protection: (p) => price = p.price ?? 0.0,
                orElse: () {},
              );
            },
          );
        } catch (_) {
          // Ignore errors when fetching component details
        }
      }

      items.add(BudgetItem(
        id: key,
        name: name,
        description: '$count unidades',
        quantity: count.toDouble(),
        unitPrice: price,
        category: BudgetCategory.protection,
      ));
    }

    // 3. Cables (Third, Sorted by Section)
    var cableKeys = cableQuantities.keys.toList();
    cableKeys.sort((a, b) {
      try {
        double secA = double.parse(a.split('-')[2]);
        double secB = double.parse(b.split('-')[2]);
        return secA.compareTo(secB);
      } catch (e) {
        return 0;
      }
    });

    for (var key in cableKeys) {
      final length = cableQuantities[key]!;

      final parts = key.split('-');

      String materialCode = parts[1];
      String sectionStr = parts[2];
      String polesNum = parts[3];

      String wiresStr = "${polesNum}G";
      // 3 -> 3G (F+N+T), 5 -> 5G (3F+N+T)

      String matName = materialCode == 'CU' ? 'Manguera' : 'Manguera Al';
      String name = "$matName $wiresStr$sectionStr mm²";
      double price = 0.0;

      try {
        final targetMat = materialCode == 'CU'
            ? CableMaterial.copper
            : CableMaterial.aluminum;
        final targetSec = double.tryParse(sectionStr) ?? 0.0;

        final match = libraryCables.firstWhere(
          (c) => c.maybeMap(
            cable: (cab) =>
                cab.material == targetMat && cab.section == targetSec,
            orElse: () => false,
          ),
          orElse: () => const ComponentTemplate.cable(
              id: '',
              name: '',
              section: 0,
              material: CableMaterial.copper,
              insulationType: '',
              maxOperatingTemp: 0),
        );

        if (match.id.isNotEmpty) {
          match.mapOrNull(cable: (c) {
            name = "${c.name} ($wiresStr)";
            price = c.price ?? 0.0;
          });
        }
      } catch (e) {
        // Ignore errors during sorting or lookup
      }

      name = _cleanName(name);

      items.add(BudgetItem(
        id: key,
        name: name,
        description: 'Total: ${length.toStringAsFixed(1)} m',
        quantity: length,
        unitPrice: price,
        category: BudgetCategory.cable,
      ));
    }

    return items;
  }

  void _processCable(ConductorAttributes? cable, bool isThreePhase,
      Map<String, double> quantityMap) {
    if (cable == null) return;

    String mat = cable.material == ConductorMaterial.copper ? 'CU' : 'AL';
    String section = cable.sectionMm2.toStringAsFixed(1).replaceAll('.0', '');

    String wires = isThreePhase ? '5' : '3';

    String key = 'CABLE-$mat-$section-$wires';

    quantityMap.update(key, (val) => val + cable.lengthMeters,
        ifAbsent: () => cable.lengthMeters);
  }

  String _getShortType(ProtectionType type) {
    switch (type) {
      case ProtectionType.circuitBreaker:
        return 'PIA';
      case ProtectionType.differential:
        return 'DIFF';
      case ProtectionType.fuse:
        return 'FUSE';
      default:
        return 'PROT';
    }
  }

  String _buildGenericName(dynamic node) {
    var n = node;
    String typeStr;
    switch (n.protectionType as ProtectionType) {
      case ProtectionType.circuitBreaker:
        typeStr = "Automático";
        break;
      case ProtectionType.differential:
        typeStr = "Diferencial";
        break;
      case ProtectionType.fuse:
        typeStr = "Fusible";
        break;
      case ProtectionType.surgeProtection:
        typeStr = "Sobretensiones";
        break;
    }

    String curve = "";
    if (n.protectionType == ProtectionType.circuitBreaker) {
      curve = " Curva ${n.curve ?? 'C'}";
    }

    return "$typeStr ${n.ratingAmps.toInt()}A$curve (Genérico)";
  }

  String _cleanName(String input) {
    var output = input.replaceAll(RegExp(r'[\$\{\}]'), '');
    output = output.replaceAll('~', ' ');
    output = output.replaceAll(RegExp(r'\^2'), '²');

    return output;
  }
}
