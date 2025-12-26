import 'dart:math';

import '../../../diagram/domain/entities/electrical_node.dart';
import '../entities/electrical_enums.dart';

import 'tree_cable_info.dart';

/// Pure utility functions for tree operations
/// NO Flutter dependencies - can be tested independently
class TreeUtilities {
  const TreeUtilities._();

  /// Extract cable info safely from any node type
  static CableInfo extractCableInfo(ElectricalNode node) {
    return node.map(
      source: (n) => CableInfo(cable: n.mainFeedCable, catalog: null),
      panel: (n) => CableInfo(cable: n.inputCable, catalog: null),
      protection: (n) => CableInfo(cable: null, catalog: n.catalogData),
      load: (n) => CableInfo(cable: n.inputCable, catalog: null),
    );
  }

  /// Find a node by ID in the tree
  static ElectricalNode? findNodeById(ElectricalNode? root, String id) {
    if (root == null) return null;
    if (root.id == id) return root;

    return root.map(
      source: (node) => _findInChildren(node.children, id),
      protection: (node) => _findInChildren(node.children, id),
      panel: (node) => _findInChildren(node.children, id),
      load: (_) => null,
    );
  }

  static ElectricalNode? _findInChildren(
      List<ElectricalNode> children, String id) {
    for (final child in children) {
      final found = findNodeById(child, id);
      if (found != null) return found;
    }
    return null;
  }

  /// Find parent of a node
  static ElectricalNode? findParentNode(
    ElectricalNode? root,
    String childId,
  ) {
    if (root == null) return null;

    return root.map(
      source: (node) => _findParentInChildren(node, node.children, childId),
      protection: (node) => _findParentInChildren(node, node.children, childId),
      panel: (node) => _findParentInChildren(node, node.children, childId),
      load: (_) => null,
    );
  }

  static ElectricalNode? _findParentInChildren(
    ElectricalNode parent,
    List<ElectricalNode> children,
    String childId,
  ) {
    for (final child in children) {
      if (child.id == childId) return parent;

      final found = findParentNode(child, childId);
      if (found != null) return found;
    }
    return null;
  }

  /// Flatten tree to list of nodes (depth-first)
  static List<ElectricalNode> flattenElectricalNodes(ElectricalNode? root) {
    if (root == null) return [];

    final List<ElectricalNode> nodes = [root];

    root.map(
      source: (node) => nodes.addAll(_flattenChildren(node.children)),
      protection: (node) => nodes.addAll(_flattenChildren(node.children)),
      panel: (node) => nodes.addAll(_flattenChildren(node.children)),
      load: (_) {}, // Load has no children
    );

    return nodes;
  }

  static List<ElectricalNode> _flattenChildren(List<ElectricalNode> children) {
    final List<ElectricalNode> result = [];
    for (final child in children) {
      result.addAll(flattenElectricalNodes(child));
    }
    return result;
  }

  /// Extract panel names from tree
  static Map<String, String> extractPanelNames(ElectricalNode? root) {
    final Map<String, String> names = {};
    if (root == null) return names;

    final allNodes = flattenElectricalNodes(root);
    for (final node in allNodes) {
      node.map(
        panel: (panel) {
          final panelName = panel.name.isNotEmpty ? panel.name : 'Cuadro';
          names[panel.id] = panelName;
        },
        source: (_) {},
        protection: (_) {},
        load: (_) {},
      );
    }
    return names;
  }

  /// Extract ALL properties from ElectricalNode for presentation layer display
  /// Transforms domain data -> presentation data (clean architecture)
  static Map<String, dynamic> extractProperties(ElectricalNode node) {
    // Base properties: name + electrical state (only available fields)
    final Map<String, dynamic> props = {
      'name': node.name,
      'voltage': node.state.voltageVolts.toStringAsFixed(1),
      'current': node.state.currentAmps.toStringAsFixed(2),
      'amps': node.state.currentAmps.toStringAsFixed(1), // Alias
      'active_power_kw':
          (node.state.activePowerWatts / 1000).toStringAsFixed(2),
      'reactive_power_kvar':
          (node.state.reactivePowerVars / 1000).toStringAsFixed(2),
    };

    // Calculate apparent power (S = sqrt(P² + Q²))
    final s = sqrt(node.state.activePowerWatts * node.state.activePowerWatts +
        node.state.reactivePowerVars * node.state.reactivePowerVars);
    props['apparent_power_kva'] = (s / 1000).toStringAsFixed(2);

    // Calculate power factor (cos φ = P/S)
    if (s > 0) {
      props['power_factor'] =
          (node.state.activePowerWatts / s).toStringAsFixed(2);
    } else {
      props['power_factor'] = '1.00';
    }

    // Calculation results (if available)
    if (node.result != null) {
      props['design_current'] = node.result!.designCurrent.toStringAsFixed(2);
      props['voltage_at_node'] = node.result!.voltageAtNode.toStringAsFixed(1);
      props['drop_percent'] = node.result!.voltageDrop.toStringAsFixed(2);
      props['drop_volts'] = node.result!.voltageDropVolts.toStringAsFixed(2);
      props['admissible_current'] =
          node.result!.admissibleCurrent.toStringAsFixed(1);
      props['is_compliant'] = node.result!.isCompliant;

      // Short circuit currents
      props['max_short_circuit_current'] =
          node.result!.maxShortCircuitCurrent.toStringAsFixed(0);
      props['min_short_circuit_current'] =
          node.result!.minShortCircuitCurrent.toStringAsFixed(0);

      // Loop impedance
      props['loop_impedance'] = node.result!.loopImpedance.toStringAsFixed(3);
    } else {
      props['drop_percent'] = node.state.voltageDropPercent.toStringAsFixed(2);
    }

    // Node-specific properties
    return node.map(
      source: (n) {
        props['type'] = 'source';
        props['nominal_voltage'] = n.nominalVoltage.toStringAsFixed(0);
        props['short_circuit_capacity'] =
            (n.shortCircuitCapacity / 1000).toStringAsFixed(1);
        return props;
      },
      panel: (n) {
        props['type'] = 'panel';
        if (n.inputCable != null) {
          props['section_mm2'] = n.inputCable!.sectionMm2.toStringAsFixed(1);
          props['length'] = n.inputCable!.lengthMeters.toStringAsFixed(0);
          props['material'] =
              n.inputCable!.material == ConductorMaterial.copper ? 'Cu' : 'Al';
        }
        return props;
      },
      protection: (n) {
        props['type'] = 'protection';
        props['rating'] = n.ratingAmps.toStringAsFixed(0);
        props['curve'] = n.curve;
        props['poles'] = n.poles.toString();
        props['protection_type'] = n.protectionType.toString().split('.').last;
        if (n.pdc != null) {
          props['breaking_capacity'] = n.pdc!.toStringAsFixed(1);
        }
        if (n.protectionType == ProtectionType.differential) {
          props['sensitivity'] = n.sensitivity.toStringAsFixed(0);
        }
        // No inputCable for protection
        return props;
      },
      load: (n) {
        props['type'] = 'load';
        props['power'] = (n.powerWatts / 1000).toStringAsFixed(2);
        props['power_watts'] = n.powerWatts.toStringAsFixed(0);
        props['cos_phi'] = n.cosPhi.toStringAsFixed(2);
        props['load_type'] = n.type.toString().split('.').last;
        props['is_three_phase'] = n.isThreePhase.toString();

        if (n.inputCable != null) {
          props['section_mm2'] = n.inputCable!.sectionMm2.toStringAsFixed(1);
          props['length'] = n.inputCable!.lengthMeters.toStringAsFixed(0);
          props['material'] =
              n.inputCable!.material == ConductorMaterial.copper ? 'Cu' : 'Al';
        }
        return props;
      },
    );
  }

  /// Get depth of a node in tree (root = 0)
  static int getNodeDepth(ElectricalNode? root, String nodeId) {
    if (root == null) return -1;
    if (root.id == nodeId) return 0;

    return root.map(
      source: (node) => _getDepthInChildren(node.children, nodeId, 1),
      protection: (node) => _getDepthInChildren(node.children, nodeId, 1),
      panel: (node) => _getDepthInChildren(node.children, nodeId, 1),
      load: (_) => -1,
    );
  }

  static int _getDepthInChildren(
    List<ElectricalNode> children,
    String nodeId,
    int currentDepth,
  ) {
    for (final child in children) {
      if (child.id == nodeId) return currentDepth;

      final depth = child.map(
        source: (node) =>
            _getDepthInChildren(node.children, nodeId, currentDepth + 1),
        protection: (node) =>
            _getDepthInChildren(node.children, nodeId, currentDepth + 1),
        panel: (node) =>
            _getDepthInChildren(node.children, nodeId, currentDepth + 1),
        load: (_) => -1,
      );

      if (depth != -1) return depth;
    }
    return -1;
  }

  /// Count total nodes in tree
  static int countNodes(ElectricalNode? root) {
    return flattenElectricalNodes(root).length;
  }

  /// Get all leaf nodes (loads without children)
  static List<ElectricalNode> getLeafNodes(ElectricalNode? root) {
    if (root == null) return [];

    final allNodes = flattenElectricalNodes(root);
    return allNodes.where((node) {
      return node.map(
        load: (_) => true,
        source: (n) => n.children.isEmpty,
        protection: (n) => n.children.isEmpty,
        panel: (n) => n.children.isEmpty,
      );
    }).toList();
  }

  /// Get immediate children of a node
  static List<ElectricalNode> getChildren(ElectricalNode node) {
    return node.map(
      source: (n) => n.children,
      protection: (n) => n.children,
      panel: (n) => n.children,
      load: (_) => <ElectricalNode>[],
    );
  }

  /// Remove a node from tree and return new tree root
  /// Returns null if root itself is removed
  static ElectricalNode? removeNodeFromTree(
      ElectricalNode root, String nodeIdToRemove) {
    if (root.id == nodeIdToRemove) return null;

    return root.map(
      source: (node) => node.copyWith(
          children: _removeNodeFromChildren(node.children, nodeIdToRemove)),
      protection: (node) => node.copyWith(
          children: _removeNodeFromChildren(node.children, nodeIdToRemove)),
      panel: (node) => node.copyWith(
          children: _removeNodeFromChildren(node.children, nodeIdToRemove)),
      load: (node) => node, // Loads have no children
    );
  }

  static List<ElectricalNode> _removeNodeFromChildren(
      List<ElectricalNode> children, String idToRemove) {
    final List<ElectricalNode> newChildren = [];
    for (final child in children) {
      if (child.id == idToRemove) {
        // Skip this child (remove it)
        continue;
      }

      // Recursively check children
      final newChild = removeNodeFromTree(child, idToRemove);
      if (newChild != null) {
        newChildren.add(newChild);
      }
    }
    return newChildren;
  }
}
