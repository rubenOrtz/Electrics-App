import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/electrical_enums.dart';
import '../../domain/entities/electrical_state.dart';
import '../../domain/entities/conductor_attributes.dart';
import '../../domain/entities/catalog_metadata.dart';
import '../../domain/entities/electrical_node.dart';
import '../../domain/entities/measurement_state.dart';
import '../../../health/domain/entities/asset_metadata.dart';

part 'electrical_node_dto.freezed.dart';
part 'electrical_node_dto.g.dart';

@freezed
sealed class ElectricalNodeDto with _$ElectricalNodeDto {
  const factory ElectricalNodeDto.source({
    required String id,
    required String name,
    @Default(ElectricalState()) ElectricalState state,
    @Default(230) double nominalVoltage,
    @Default(10000) double shortCircuitCapacity,
    ConductorAttributes? mainFeedCable, // NEW: Acometida
    MeasurementState? lastMeasurement, // NEW: Forensic
    @Default(AssetMetadata()) AssetMetadata assetMetadata,
    @Default([]) List<ElectricalNodeDto> children,
  }) = SourceNodeDto;

  const factory ElectricalNodeDto.panel({
    required String id,
    required String name,
    @Default(ElectricalState()) ElectricalState state,
    @Default(230) double nominalVoltage,
    ConductorAttributes? inputCable,
    MeasurementState? lastMeasurement, // NEW: Forensic
    @Default(AssetMetadata()) AssetMetadata assetMetadata,
    @Default([]) List<ElectricalNodeDto> children,
  }) = PanelNodeDto;

  const factory ElectricalNodeDto.protection({
    required String id,
    required String name,
    @Default(ElectricalState()) ElectricalState state,
    // REMOVED: ConductorAttributes? inputCable,
    MeasurementState? lastMeasurement, // NEW: Forensic
    @Default(AssetMetadata()) AssetMetadata assetMetadata,
    @Default(ProtectionType.circuitBreaker) ProtectionType protectionType,
    @Default(16) double ratingAmps,
    double? pdc,
    @Default("C") String curve,
    @Default(30.0) double sensitivity,
    @Default(2) int poles,
    @Default([]) List<ElectricalNodeDto> children,
    CatalogMetadata? catalogData,
    CatalogMetadata? cableCatalogData,
  }) = ProtectionNodeDto;

  const factory ElectricalNodeDto.load({
    required String id,
    required String name,
    @Default(ElectricalState()) ElectricalState state,
    ConductorAttributes? inputCable,
    MeasurementState? lastMeasurement, // NEW: Forensic
    @Default(AssetMetadata()) AssetMetadata assetMetadata,
    @Default(3000) double powerWatts,
    @Default(0.9) double cosPhi,
    @Default(false) bool isThreePhase,
    CatalogMetadata? cableCatalogData,
  }) = LoadNodeDto;

  factory ElectricalNodeDto.fromJson(Map<String, dynamic> json) =>
      _$ElectricalNodeDtoFromJson(json);
}

extension ElectricalNodeDtoX on ElectricalNodeDto {
  ElectricalNode toDomain() {
    return map(
      source: (dto) => ElectricalNode.source(
        id: dto.id,
        name: dto.name,
        state: dto.state,
        nominalVoltage: dto.nominalVoltage,
        shortCircuitCapacity: dto.shortCircuitCapacity,
        mainFeedCable: dto.mainFeedCable,
        lastMeasurement: dto.lastMeasurement,
        assetMetadata: dto.assetMetadata,
        children: dto.children.map((e) => e.toDomain()).toList(),
      ),
      panel: (dto) => ElectricalNode.panel(
        id: dto.id,
        name: dto.name,
        state: dto.state,
        nominalVoltage: dto.nominalVoltage,
        inputCable: dto.inputCable,
        lastMeasurement: dto.lastMeasurement,
        assetMetadata: dto.assetMetadata,
        children: dto.children.map((e) => e.toDomain()).toList(),
      ),
      protection: (dto) => ElectricalNode.protection(
        id: dto.id,
        name: dto.name,
        state: dto.state,
        // No inputCable
        lastMeasurement: dto.lastMeasurement,
        assetMetadata: dto.assetMetadata,
        protectionType: dto.protectionType,
        ratingAmps: dto.ratingAmps,
        pdc: dto.pdc,
        curve: dto.curve,
        sensitivity: dto.sensitivity,
        poles: dto.poles,
        children: dto.children.map((e) => e.toDomain()).toList(),
        catalogData: dto.catalogData, // RESTORE catalog link
        cableCatalogData: dto.cableCatalogData, // RESTORE cable catalog link
      ),
      load: (dto) => ElectricalNode.load(
        id: dto.id,
        name: dto.name,
        state: dto.state,
        inputCable: dto.inputCable,
        powerWatts: dto.powerWatts,
        cosPhi: dto.cosPhi,
        lastMeasurement: dto.lastMeasurement,
        assetMetadata: dto.assetMetadata,
        isThreePhase: dto.isThreePhase,
        cableCatalogData: dto.cableCatalogData,
      ),
    );
  }
}

extension ElectricalNodeX on ElectricalNode {
  ElectricalNodeDto toDto() {
    return map(
      source: (e) => ElectricalNodeDto.source(
        id: e.id,
        name: e.name,
        state: e.state,
        nominalVoltage: e.nominalVoltage,
        shortCircuitCapacity: e.shortCircuitCapacity,
        mainFeedCable: e.mainFeedCable,
        lastMeasurement: e.lastMeasurement,
        assetMetadata: e.assetMetadata,
        children: e.children.map((c) => c.toDto()).toList(),
      ),
      panel: (e) => ElectricalNodeDto.panel(
        id: e.id,
        name: e.name,
        state: e.state,
        nominalVoltage: e.nominalVoltage,
        inputCable: e.inputCable,
        lastMeasurement: e.lastMeasurement,
        assetMetadata: e.assetMetadata,
        children: e.children.map((c) => c.toDto()).toList(),
      ),
      protection: (e) => ElectricalNodeDto.protection(
        id: e.id,
        name: e.name,
        state: e.state,
        // No inputCable
        lastMeasurement: e.lastMeasurement,
        assetMetadata: e.assetMetadata,
        protectionType: e.protectionType,
        ratingAmps: e.ratingAmps,
        pdc: e.pdc,
        curve: e.curve,
        sensitivity: e.sensitivity,
        poles: e.poles,
        children: e.children.map((c) => c.toDto()).toList(),
        catalogData: e.catalogData, // PERSIST catalog link
        cableCatalogData: e.cableCatalogData, // PERSIST cable catalog link
      ),
      load: (e) => ElectricalNodeDto.load(
        id: e.id,
        name: e.name,
        state: e.state,
        inputCable: e.inputCable,
        powerWatts: e.powerWatts,
        cosPhi: e.cosPhi,
        lastMeasurement: e.lastMeasurement,
        assetMetadata: e.assetMetadata,
        isThreePhase: e.isThreePhase,
        cableCatalogData: e.cableCatalogData,
      ),
    );
  }
}
