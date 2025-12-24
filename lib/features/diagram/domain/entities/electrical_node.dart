import 'package:freezed_annotation/freezed_annotation.dart';
import 'electrical_enums.dart';
import 'electrical_state.dart';
import 'measurement_state.dart';
import 'conductor_attributes.dart';
import 'calculation_result.dart';
import 'catalog_metadata.dart';
import '../../../health/domain/entities/asset_metadata.dart';

part 'electrical_node.freezed.dart';

@freezed
sealed class ElectricalNode with _$ElectricalNode {
  // Source (Transformer/Acometida) - Root
  const factory ElectricalNode.source({
    required String id,
    required String name,
    @Default(ElectricalState()) ElectricalState state,
    @Default(230) double nominalVoltage,
    @Default(10000) double shortCircuitCapacity, // Icc at source

    // Main feed cable (Acometida → Cuadro Principal)
    // Default: null (simulates starting directly at panel)
    ConductorAttributes? mainFeedCable,
    @Default([]) List<ElectricalNode> children,

    // Calculation result
    CalculationResult? result,

    // Real measurements
    MeasurementState? lastMeasurement,

    // Asset Management
    @Default(AssetMetadata()) AssetMetadata assetMetadata,
  }) = SourceNode;

  // Panel (Container)
  const factory ElectricalNode.panel({
    required String id,
    required String name,
    @Default(ElectricalState()) ElectricalState state,
    @Default(230) double nominalVoltage,

    // Connection from Parent
    ConductorAttributes? inputCable,
    @Default([]) List<ElectricalNode> children,

    // Calculation result
    CalculationResult? result,

    // Real measurements
    MeasurementState? lastMeasurement,

    // Asset Management
    @Default(AssetMetadata()) AssetMetadata assetMetadata,
  }) = PanelNode;

  // Protection (Breaker/Differential) - Device only, no cables
  const factory ElectricalNode.protection({
    required String id,
    required String name,
    @Default(ElectricalState()) ElectricalState state,
    @Default(ProtectionType.circuitBreaker) ProtectionType protectionType,
    @Default(16) double ratingAmps,
    double? pdc,
    @Default("C") String curve,
    @Default(30.0) double sensitivity,
    @Default(2) int poles,
    @Default([]) List<ElectricalNode> children,

    // Calculation result
    CalculationResult? result,

    // Real measurements
    MeasurementState? lastMeasurement,

    // Asset Management
    @Default(AssetMetadata()) AssetMetadata assetMetadata,

    // Catalog Metadata (Digital Twin)
    CatalogMetadata? catalogData,
    CatalogMetadata? cableCatalogData,
  }) = ProtectionNode;

  // Load (End of Line)
  const factory ElectricalNode.load({
    required String id,
    required String name,
    @Default(ElectricalState()) ElectricalState state,
    ConductorAttributes? inputCable,
    @Default(3000) double powerWatts,
    @Default(0.9) double cosPhi,
    @Default(LoadType.power) LoadType type,
    @Default(false) bool isThreePhase,

    // Calculation result
    CalculationResult? result,

    // Real measurements
    MeasurementState? lastMeasurement,

    // Asset Management
    @Default(AssetMetadata()) AssetMetadata assetMetadata,

    // Catalog Metadata for load's input cable
    CatalogMetadata? cableCatalogData,
  }) = LoadNode;
}
