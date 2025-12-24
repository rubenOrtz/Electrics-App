import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/electrical_node.dart';
import '../../../compliance/domain/entities/compliance_base.dart';
import '../../domain/use_cases/calculate_diagram.dart';
import '../../domain/use_cases/validate_diagram.dart';
import '../../domain/use_cases/add_child_node.dart';
import '../../domain/use_cases/update_node.dart';
import '../../domain/services/tree_utilities.dart';
import 'diagram_state.dart';

class DiagramCubit extends Cubit<DiagramState> {
  // Fields
  final CalculateDiagramUseCase _calculateDiagramUseCase;
  final ValidateDiagramUseCase _validateDiagramUseCase;
  final AddChildNodeUseCase _addChildNodeUseCase;
  final UpdateNodeUseCase _updateNodeUseCase;

  // --- Undo/Redo History ---
  final List<DiagramState> _undoStack = [];
  final List<DiagramState> _redoStack = [];

  // Constructor
  DiagramCubit({
    required CalculateDiagramUseCase calculateDiagramUseCase,
    required ValidateDiagramUseCase validateDiagramUseCase,
    required AddChildNodeUseCase addChildNodeUseCase,
    required UpdateNodeUseCase updateNodeUseCase,
  })  : _calculateDiagramUseCase = calculateDiagramUseCase,
        _validateDiagramUseCase = validateDiagramUseCase,
        _addChildNodeUseCase = addChildNodeUseCase,
        _updateNodeUseCase = updateNodeUseCase,
        super(const DiagramState());

  // Private Helper Methods
  void _saveToHistory() {
    // Store current state
    _undoStack.add(state.copyWith());
    _redoStack.clear();
    // Limit stack size
    if (_undoStack.length > 50) {
      _undoStack.removeAt(0);
    }
  }

  // Public Methods
  void undo() {
    if (_undoStack.isNotEmpty) {
      final previousState = _undoStack.removeLast();
      _redoStack.add(state.copyWith());

      emit(previousState.copyWith(
        canUndo: _undoStack.isNotEmpty,
        canRedo: true,
        status: DiagramStatus.ready,
      ));
    }
  }

  void redo() {
    if (_redoStack.isNotEmpty) {
      final nextState = _redoStack.removeLast();
      _undoStack.add(state.copyWith());

      emit(nextState.copyWith(
        canUndo: true,
        canRedo: _redoStack.isNotEmpty,
        status: DiagramStatus.ready,
      ));
    }
  }

  /// Sets the Root Node of the diagram (e.g. initial load or new project)
  void setRoot(ElectricalNode root) {
    emit(state.copyWith(
      root: root,
      status: DiagramStatus.ready,
      nodePositions: {},
      canUndo: false,
      canRedo: false,
    ));
    _undoStack.clear();
    _redoStack.clear();

    // Trigger initial calculation to show values immediately
    Future.microtask(() => validateDiagram());
  }

  /// Removes a node by ID and validates diagram
  void removeNode(String nodeId) {
    final root = state.root;
    if (root == null) return;
    if (root.id == nodeId) {
      // Cannot remove root directly this way without resetting project
      return;
    }

    _saveToHistory();

    final newRoot = TreeUtilities.removeNodeFromTree(root, nodeId);

    // Also remove from positions map to cleanup
    final newPositions = Map<String, Offset>.from(state.nodePositions)
      ..remove(nodeId);

    if (newRoot != null) {
      emit(state.copyWith(
        root: newRoot,
        nodePositions: newPositions,
        status: DiagramStatus.ready,
        canUndo: true,
        canRedo: false,
      ));
      validateDiagram();
    }
  }

  /// Triggers calculation and validation
  Future<void> validateDiagram({RegulatoryStandard? standard}) async {
    final root = state.root;
    if (root == null) {
      emit(state.copyWith(
          status: DiagramStatus.error, errorMessage: "No root defined"));
      return;
    }

    emit(state.copyWith(status: DiagramStatus.calculating));

    try {
      // 1. Calculate Engine
      final calcResult = await _calculateDiagramUseCase(
        params: CalculateDiagramParams(root),
      );

      final calculatedRoot = calcResult.root;

      // 2. Standard Validation
      if (standard != null) {
        await _validateDiagramUseCase(
          params: ValidateDiagramParams(calculatedRoot, standard),
        );
        // Map ValidationResult to Error/Warning in state if needed
      }

      emit(state.copyWith(
        status: DiagramStatus.validated,
        root: calculatedRoot,
        validationErrors: calcResult.errors,
      ));
    } catch (e) {
      emit(state.copyWith(
          status: DiagramStatus.error, errorMessage: "Calculation Failed: $e"));
    }
  }

  /// Add a child node to a specific parent
  Future<void> addChild(
      String parentId, ElectricalNode childNode, Offset childPosition) async {
    final root = state.root;
    if (root == null) return;

    _saveToHistory();

    try {
      final newRoot = await _addChildNodeUseCase(
          params: AddChildNodeParams(root, parentId, childNode));

      final newPositions = Map<String, Offset>.from(state.nodePositions)
        ..[childNode.id] = childPosition;

      emit(state.copyWith(
          root: newRoot,
          nodePositions: newPositions,
          status: DiagramStatus.ready,
          canUndo: true,
          canRedo: false));

      // Auto-calculate after adding nodes
      validateDiagram();
    } catch (e) {
      emit(state.copyWith(errorMessage: "Failed to add child: $e"));
    }
  }

  void updateNodePosition(String id, Offset newPos, {bool saveState = true}) {
    // Assuming this is called on drag end or similar final interaction
    if (saveState) {
      _saveToHistory();
    }

    final updatedPositions = Map<String, Offset>.from(state.nodePositions)
      ..[id] = newPos;
    emit(state.copyWith(
      nodePositions: updatedPositions,
      canUndo: true,
      canRedo: saveState ? false : state.canRedo,
    ));
  }

  /// Updates a node's properties ensuring immutability
  Future<void> updateNodeProperties(
      String nodeId, ElectricalNode Function(ElectricalNode) updateFn) async {
    final root = state.root;
    if (root == null) return;

    _saveToHistory();

    try {
      final newRoot = await _updateNodeUseCase(
          params: UpdateNodeParams(root, nodeId, updateFn));

      emit(state.copyWith(
          root: newRoot,
          status: DiagramStatus.ready,
          canUndo: true,
          canRedo: false));

      // Re-validate immediately
      await validateDiagram();
    } catch (e) {
      emit(state.copyWith(errorMessage: "Failed to update node: $e"));
    }
  }
}
