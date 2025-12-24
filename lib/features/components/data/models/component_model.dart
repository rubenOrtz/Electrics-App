import 'package:isar/isar.dart';
import '../../domain/entities/component_template.dart';

part 'component_model.g.dart';

/// Isar collection model for storing component templates
@collection
class ComponentModel {
  Id id = Isar.autoIncrement;

  // Common fields
  late String componentId; // UUID
  @Index()
  late String name;
  String? manufacturer;
  String? series;
  @Index()
  bool isFavorite = false;

  // Type discriminator
  @Index()
  @Enumerated(EnumType.name)
  late ComponentType type;

  // Protection fields (null for other types)
  double? ratedCurrent;
  String? curveType;
  double? breakingCapacity;
  int? poles;
  @Enumerated(EnumType.name)
  ProtectionDeviceType? protectionDeviceType;
  double? sensitivity;

  // Cable fields
  double? section;
  @Enumerated(EnumType.name)
  CableMaterial? cableMaterial;
  String? insulationType;
  double? maxOperatingTemp;
  String? installationMethod;

  // Source fields
  double? voltage;
  double? maxShortCircuitCurrent;
  double? ratedPower;
  @Enumerated(EnumType.name)
  SourceType? sourceType;

  // Price (common to all types)
  double? price; // Euro price

  // Timestamps
  late DateTime createdAt;
  DateTime? updatedAt;
}

enum ComponentType {
  protection,
  cable,
  source,
}

/// Extension to convert between domain entity and Isar model
extension ComponentModelMapper on ComponentModel {
  ComponentTemplate toDomain() {
    switch (type) {
      case ComponentType.protection:
        return ComponentTemplate.protection(
          id: componentId,
          name: name,
          manufacturer: manufacturer,
          series: series,
          isFavorite: isFavorite,
          ratedCurrent: ratedCurrent!,
          curveType: curveType!,
          breakingCapacity: breakingCapacity!,
          poles: poles!,
          deviceType:
              protectionDeviceType ?? ProtectionDeviceType.circuitBreaker,
          sensitivity: sensitivity,
          price: price,
        );
      case ComponentType.cable:
        return ComponentTemplate.cable(
          id: componentId,
          name: name,
          manufacturer: manufacturer,
          series: series,
          isFavorite: isFavorite,
          section: section!,
          material: cableMaterial!,
          insulationType: insulationType!,
          maxOperatingTemp: maxOperatingTemp!,
          installationMethod: installationMethod,
          price: price,
        );
      case ComponentType.source:
        return ComponentTemplate.source(
          id: componentId,
          name: name,
          manufacturer: manufacturer,
          series: series,
          isFavorite: isFavorite,
          voltage: voltage!,
          maxShortCircuitCurrent: maxShortCircuitCurrent!,
          ratedPower: ratedPower,
          sourceType: sourceType ?? SourceType.grid,
          price: price,
        );
    }
  }

  static ComponentModel fromDomain(ComponentTemplate template) {
    final model = ComponentModel()
      ..componentId = template.id
      ..name = template.name
      ..manufacturer = template.manufacturer
      ..series = template.series
      ..isFavorite = template.isFavorite
      ..createdAt = DateTime.now();

    template.when(
      protection: (id, name, manufacturer, series, isFavorite, ratedCurrent,
          curveType, breakingCapacity, poles, deviceType, sensitivity, price) {
        model
          ..type = ComponentType.protection
          ..ratedCurrent = ratedCurrent
          ..curveType = curveType
          ..breakingCapacity = breakingCapacity
          ..poles = poles
          ..protectionDeviceType = deviceType
          ..sensitivity = sensitivity
          ..price = price;
      },
      cable: (id, name, manufacturer, series, isFavorite, section, material,
          insulationType, maxOperatingTemp, installationMethod, price) {
        model
          ..type = ComponentType.cable
          ..section = section
          ..cableMaterial = material
          ..insulationType = insulationType
          ..maxOperatingTemp = maxOperatingTemp
          ..installationMethod = installationMethod
          ..price = price;
      },
      source: (id, name, manufacturer, series, isFavorite, voltage,
          maxShortCircuitCurrent, ratedPower, sourceType, price) {
        model
          ..type = ComponentType.source
          ..voltage = voltage
          ..maxShortCircuitCurrent = maxShortCircuitCurrent
          ..ratedPower = ratedPower
          ..sourceType = sourceType
          ..price = price;
      },
    );

    return model;
  }
}
