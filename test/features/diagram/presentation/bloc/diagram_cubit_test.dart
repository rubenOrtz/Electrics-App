import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:electrician_app/features/diagram/presentation/bloc/diagram_cubit.dart';
import 'package:electrician_app/features/diagram/presentation/bloc/diagram_state.dart';
import 'package:electrician_app/features/diagram/domain/use_cases/calculate_diagram.dart';
import 'package:electrician_app/features/diagram/domain/use_cases/validate_diagram.dart';
import 'package:electrician_app/features/diagram/domain/use_cases/add_child_node.dart';
import 'package:electrician_app/features/diagram/domain/use_cases/update_node.dart';
import 'package:electrician_app/features/diagram/domain/entities/electrical_node.dart';

class MockCalculateDiagramUseCase extends Mock
    implements CalculateDiagramUseCase {}

class MockValidateDiagramUseCase extends Mock
    implements ValidateDiagramUseCase {}

class MockAddChildNodeUseCase extends Mock implements AddChildNodeUseCase {}

class MockUpdateNodeUseCase extends Mock implements UpdateNodeUseCase {}

void main() {
  late DiagramCubit cubit;
  late MockCalculateDiagramUseCase mockCalculateUseCase;
  late MockValidateDiagramUseCase mockValidateUseCase;
  late MockAddChildNodeUseCase mockAddChildUseCase;
  late MockUpdateNodeUseCase mockUpdateNodeUseCase;

  // Use a simple mock node
  const mockNode = ElectricalNode.source(id: 'root', name: 'Root');
  const mockChild = ElectricalNode.load(id: 'child', name: 'Child');

  setUp(() {
    mockCalculateUseCase = MockCalculateDiagramUseCase();
    mockValidateUseCase = MockValidateDiagramUseCase();
    mockAddChildUseCase = MockAddChildNodeUseCase();
    mockUpdateNodeUseCase = MockUpdateNodeUseCase();

    cubit = DiagramCubit(
      calculateDiagramUseCase: mockCalculateUseCase,
      validateDiagramUseCase: mockValidateUseCase,
      addChildNodeUseCase: mockAddChildUseCase,
      updateNodeUseCase: mockUpdateNodeUseCase,
    );

    registerFallbackValue(CalculateDiagramParams(mockNode));
    registerFallbackValue(AddChildNodeParams(mockNode, 'root', mockChild));
  });

  group('DiagramCubit', () {
    test('initial state is correct', () {
      expect(cubit.state, const DiagramState());
    });

    test('setRoot updates state', () {
      cubit.setRoot(mockNode);
      expect(cubit.state.root, mockNode);
      expect(cubit.state.status, DiagramStatus.ready);
    });

    test('addChild calls use case and updates state', () async {
      // Arrange
      cubit.setRoot(mockNode);
      when(() => mockAddChildUseCase(params: any(named: 'params'))).thenAnswer(
          (_) async =>
              (mockNode as SourceNode).copyWith(children: [mockChild]));

      // Act
      await cubit.addChild('root', mockChild, Offset.zero);

      // Assert
      final root = cubit.state.root as SourceNode;
      expect(root.children.length, 1);
      expect(cubit.state.nodePositions['child'], Offset.zero);
      verify(() => mockAddChildUseCase(params: any(named: 'params'))).called(1);
    });

    // Note: validateDiagram involves more complex mocking due to CalculateResult return type
    // Skipping complex validateDiagram test for brevity here, focusing on CRUD/State.
  });
}
