import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:electrician_app/features/diagram/presentation/widgets/diagram_node_widget.dart';

import 'package:electrician_app/features/diagram/domain/entities/diagram_models.dart';

void main() {
  testWidgets('DiagramNodeWidget renders load correctly',
      (WidgetTester tester) async {
    // Arrange
    final loadNode = DiagramNode(
      id: 'n1',
      position: Offset.zero,
      type: NodeType.load,
      properties: {
        'name': 'Light 1',
        'limit': 3.0,
        'drop_percent': 1.5,
      },
    );

    // Act
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DiagramNodeWidget(
          node: loadNode,
          isSelected: false,
          onSelect: (_) {},
          onAddChild: (_, __) {},
        ),
      ),
    ));

    // Assert
    expect(find.text('Light 1'), findsOneWidget);
    expect(find.byIcon(Icons.lightbulb_outline), findsOneWidget);
    // Finds green dot for compliance
  });

  testWidgets('DiagramNodeWidget shows red for non-compliant load',
      (WidgetTester tester) async {
    // Arrange
    final loadNode = DiagramNode(
      id: 'n1',
      position: Offset.zero,
      type: NodeType.load,
      properties: {
        'name': 'Bad Light',
        'limit': 3.0,
        'drop_percent': 4.5,
      },
    );

    // Act
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DiagramNodeWidget(
          node: loadNode,
          isSelected: false,
          onSelect: (_) {},
          onAddChild: (_, __) {},
        ),
      ),
    ));

    // Assert
    expect(find.text('Bad Light'), findsOneWidget);
    // To verify color, we'd need to find the specific Container/Decoration, which is harder in widget tests without keys.
    // For now, verifying it renders without error is good.
    final complianceContainer = find.descendant(
      of: find.byType(Stack),
      matching: find.byWidgetPredicate((widget) =>
          widget is Container &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).color == Colors.red),
    );
    expect(complianceContainer, findsOneWidget);
  });
}
