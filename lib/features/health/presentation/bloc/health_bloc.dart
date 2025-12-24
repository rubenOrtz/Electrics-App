import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/installation_health.dart';
import '../../domain/entities/insight.dart';
import '../../domain/entities/field_measurement.dart';
import '../../domain/services/health_scoring_service.dart';
import '../../domain/services/insight_generator_service.dart';
import '../../../diagram/presentation/bloc/diagram_cubit.dart';
import '../../../diagram/domain/entities/electrical_node.dart';
// Removed unused DiagramState import

// Events
sealed class HealthEvent {}

class RecalculateHealth extends HealthEvent {}

class AddFieldMeasurement extends HealthEvent {
  final String nodeId;
  final FieldMeasurement measurement;

  AddFieldMeasurement(this.nodeId, this.measurement);
}

class RemoveMeasurement extends HealthEvent {
  final String nodeId;
  final String measurementId;

  RemoveMeasurement(this.nodeId, this.measurementId);
}

// States
sealed class HealthState {}

class HealthInitial extends HealthState {}

class HealthLoading extends HealthState {}

class HealthLoaded extends HealthState {
  final InstallationHealth health;
  final List<Insight> insights;
  final Map<String, List<FieldMeasurement>> measurements;
  final List<ElectricalNode>
      components; // Lista de todos los componentes del diagrama

  HealthLoaded({
    required this.health,
    required this.insights,
    required this.measurements,
    required this.components,
  });
}

class HealthError extends HealthState {
  final String message;

  HealthError(this.message);
}

// Bloc
class HealthBloc extends Bloc<HealthEvent, HealthState> {
  final DiagramCubit diagramCubit;
  final HealthScoringService _scoringService = HealthScoringService();
  final InsightGeneratorService _insightService = InsightGeneratorService();

  HealthBloc({required this.diagramCubit}) : super(HealthInitial()) {
    // Escuchar cambios del DiagramCubit para recalcular automáticamente
    diagramCubit.stream.listen((diagramState) {
      if (diagramState.root != null) {
        add(RecalculateHealth());
      }
    });

    on<RecalculateHealth>(_onRecalculateHealth);
    on<AddFieldMeasurement>(_onAddFieldMeasurement);
    on<RemoveMeasurement>(_onRemoveMeasurement);

    // Calcular health inicial si el diagrama ya está cargado
    if (diagramCubit.state.root != null) {
      add(RecalculateHealth());
    }
  }

  void _onRecalculateHealth(
    RecalculateHealth event,
    Emitter<HealthState> emit,
  ) {
    try {
      emit(HealthLoading());

      final diagramState = diagramCubit.state;
      if (diagramState.root == null) {
        emit(HealthInitial());
        return;
      }

      final root = diagramState.root!;

      // Obtener mediciones DEL ÁRBOL
      final currentMeasurements = _extractMeasurements(root);

      // Aplanar mediciones para scoring (última medición por nodo)
      final flatMeasurements = <String, FieldMeasurement>{};
      for (var entry in currentMeasurements.entries) {
        if (entry.value.isNotEmpty) {
          flatMeasurements[entry.key] = entry.value.last;
        }
      }

      // Calcular health
      final health = _scoringService.calculateHealth(root, flatMeasurements);

      // Generar insights
      final insights = _insightService.generateInsights(root, flatMeasurements);

      // Extraer lista de todos los componentes (nodos) del diagrama
      final components = _extractAllComponents(root);

      emit(HealthLoaded(
        health: health,
        insights: insights,
        measurements: currentMeasurements,
        components: components,
      ));
    } catch (e) {
      emit(HealthError('Error al calcular salud: $e'));
    }
  }

  Future<void> _onAddFieldMeasurement(
    AddFieldMeasurement event,
    Emitter<HealthState> emit,
  ) async {
    // Update persists to DiagramCubit, which triggers stream -> Recalculate
    await diagramCubit.updateNodeProperties(event.nodeId, (node) {
      final newMeta = node.assetMetadata.addMeasurement(event.measurement);

      return node.map(
        source: (n) => n.copyWith(assetMetadata: newMeta),
        panel: (n) => n.copyWith(assetMetadata: newMeta),
        protection: (n) => n.copyWith(assetMetadata: newMeta),
        load: (n) => n.copyWith(assetMetadata: newMeta),
      );
    });
  }

  Future<void> _onRemoveMeasurement(
    RemoveMeasurement event,
    Emitter<HealthState> emit,
  ) async {
    // Update persists to DiagramCubit, which triggers stream -> Recalculate
    await diagramCubit.updateNodeProperties(event.nodeId, (node) {
      final newMeasurements = node.assetMetadata.fieldMeasurements
          .where((m) => m.id != event.measurementId)
          .toList();
      final newMeta =
          node.assetMetadata.copyWith(fieldMeasurements: newMeasurements);

      return node.map(
        source: (n) => n.copyWith(assetMetadata: newMeta),
        panel: (n) => n.copyWith(assetMetadata: newMeta),
        protection: (n) => n.copyWith(assetMetadata: newMeta),
        load: (n) => n.copyWith(assetMetadata: newMeta),
      );
    });
  }

  Map<String, List<FieldMeasurement>> _extractMeasurements(
      ElectricalNode root) {
    final Map<String, List<FieldMeasurement>> result = {};

    void traverse(ElectricalNode node) {
      if (node.assetMetadata.fieldMeasurements.isNotEmpty) {
        result[node.id] = node.assetMetadata.fieldMeasurements;
      }

      node.maybeMap(
        source: (n) => n.children.forEach(traverse),
        panel: (n) => n.children.forEach(traverse),
        protection: (n) => n.children.forEach(traverse),
        orElse: () {},
      );
    }

    traverse(root);
    return result;
  }

  /// Extrae todos los componentes (nodos) del árbol en una lista plana
  List<ElectricalNode> _extractAllComponents(ElectricalNode root) {
    final List<ElectricalNode> components = [];

    void traverse(ElectricalNode node) {
      components.add(node);

      node.maybeMap(
        source: (n) => n.children.forEach(traverse),
        panel: (n) => n.children.forEach(traverse),
        protection: (n) => n.children.forEach(traverse),
        orElse: () {},
      );
    }

    traverse(root);
    return components;
  }
}
