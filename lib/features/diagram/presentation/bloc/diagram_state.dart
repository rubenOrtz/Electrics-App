import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/electrical_node.dart';
import '../../domain/use_cases/calculate_diagram.dart'; // CalculationError

part 'diagram_state.freezed.dart';

@freezed
class DiagramState with _$DiagramState {
  const factory DiagramState({
    // Root of the Single Tree (e.g. Acometida or Main Panel)
    ElectricalNode? root,
    @Default(DiagramStatus.initial) DiagramStatus status,
    @Default([]) List<CalculationError> validationErrors,
    String? errorMessage,

    // Visual Position Map (ID -> Offset)
    // Kept separate from Entity for pure layout logic
    // Visual Position Map (ID -> Offset)
    // Kept separate from Entity for pure layout logic
    @Default({}) Map<String, Offset> nodePositions,

    // Undo/Redo State
    @Default(false) bool canUndo,
    @Default(false) bool canRedo,
  }) = _DiagramState;
}

enum DiagramStatus {
  initial,
  loading,
  ready,
  calculating,
  validated,
  error,
}
