import 'package:flutter/material.dart';

import '../entities/electrical_node.dart'; // Import ElectricalNode

enum NodeType {
  breaker, // Magnetotérmico
  differential, // Díferencial
  cable, // Cableado
  load, // Carga generic (Bombilla, Motor)
  supply, // Acometida
  ground, // Toma tierra
  panel, // Subcuadro
  generic
}

class DiagramNode {
  final String id;
  final NodeType type;
  Offset position;
  Map<String, dynamic> properties;
  final ElectricalNode? relatedNode; // Link to domain node

  DiagramNode({
    required this.id,
    required this.type,
    required this.position,
    required this.properties,
    this.relatedNode,
  });

  // Helper for icons based on type
  IconData get icon {
    switch (type) {
      case NodeType.breaker:
        return Icons.toggle_off;
      case NodeType.differential:
        return Icons.safety_check;
      case NodeType.cable:
        return Icons.timeline;
      case NodeType.load:
        return Icons.lightbulb_outline;
      case NodeType.supply:
        return Icons.power;
      case NodeType.ground:
        return Icons.vertical_align_bottom;
      default:
        return Icons.check_box_outline_blank;
    }
  }

  // Label for UI
  String get label {
    switch (type) {
      case NodeType.breaker:
        return "Automático";
      case NodeType.differential:
        return "Diferencial";
      case NodeType.cable:
        return "Cable";
      case NodeType.load:
        return "Carga";
      case NodeType.supply:
        return "Red";
      case NodeType.ground:
        return "Tierra";
      default:
        return "Elemento";
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.index,
      'dx': position.dx,
      'dy': position.dy,
      'properties': properties,
    };
  }

  factory DiagramNode.fromMap(Map<String, dynamic> map) {
    return DiagramNode(
      id: map['id'] as String,
      type: NodeType.values[map['type'] as int],
      position:
          Offset((map['dx'] as num).toDouble(), (map['dy'] as num).toDouble()),
      properties: Map<String, dynamic>.from(map['properties'] as Map),
    );
  }
}
