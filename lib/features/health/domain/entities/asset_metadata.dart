import 'field_measurement.dart';

/// Metadata de activo físico para un componente eléctrico.
/// Incluye información de instalación, mantenimiento y mediciones de campo.
class AssetMetadata {
  /// Código único del activo (ej: QR-ID-001, etiqueta NFC)
  final String? assetTag;

  /// Fecha de la última inspección realizada
  final DateTime? lastInspection;

  /// Fecha programada para el próximo mantenimiento preventivo
  final DateTime? nextMaintenance;

  /// Ubicación física del componente
  /// Ej: "Nave B, Sala de Máquinas", "Planta Baja, Cuadro Principal"
  final String? location;

  /// Técnico o empresa que realizó la instalación
  final String? installedBy;

  /// Fecha de instalación del componente
  final DateTime? installationDate;

  /// Historial de mediciones de campo realizadas
  final List<FieldMeasurement> fieldMeasurements;

  const AssetMetadata({
    this.assetTag,
    this.lastInspection,
    this.nextMaintenance,
    this.location,
    this.installedBy,
    this.installationDate,
    this.fieldMeasurements = const [],
  });

  /// Obtiene la última medición realizada, si existe
  FieldMeasurement? get latestMeasurement {
    if (fieldMeasurements.isEmpty) return null;
    return fieldMeasurements
        .reduce((a, b) => a.measuredAt.isAfter(b.measuredAt) ? a : b);
  }

  /// Indica si el componente tiene mediciones de campo
  bool get hasMeasurements => fieldMeasurements.isNotEmpty;

  /// Indica si requiere mantenimiento (fecha pasada)
  bool get requiresMaintenance {
    if (nextMaintenance == null) return false;
    return DateTime.now().isAfter(nextMaintenance!);
  }

  AssetMetadata copyWith({
    String? assetTag,
    DateTime? lastInspection,
    DateTime? nextMaintenance,
    String? location,
    String? installedBy,
    DateTime? installationDate,
    List<FieldMeasurement>? fieldMeasurements,
  }) {
    return AssetMetadata(
      assetTag: assetTag ?? this.assetTag,
      lastInspection: lastInspection ?? this.lastInspection,
      nextMaintenance: nextMaintenance ?? this.nextMaintenance,
      location: location ?? this.location,
      installedBy: installedBy ?? this.installedBy,
      installationDate: installationDate ?? this.installationDate,
      fieldMeasurements: fieldMeasurements ?? this.fieldMeasurements,
    );
  }

  /// Añade una nueva medición al historial
  AssetMetadata addMeasurement(FieldMeasurement measurement) {
    return copyWith(
      fieldMeasurements: [...fieldMeasurements, measurement],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'assetTag': assetTag,
      'lastInspection': lastInspection?.toIso8601String(),
      'nextMaintenance': nextMaintenance?.toIso8601String(),
      'location': location,
      'installedBy': installedBy,
      'installationDate': installationDate?.toIso8601String(),
      'fieldMeasurements': fieldMeasurements.map((m) => m.toJson()).toList(),
    };
  }

  factory AssetMetadata.fromJson(Map<String, dynamic> json) {
    return AssetMetadata(
      assetTag: json['assetTag'],
      lastInspection: json['lastInspection'] != null
          ? DateTime.parse(json['lastInspection'])
          : null,
      nextMaintenance: json['nextMaintenance'] != null
          ? DateTime.parse(json['nextMaintenance'])
          : null,
      location: json['location'],
      installedBy: json['installedBy'],
      installationDate: json['installationDate'] != null
          ? DateTime.parse(json['installationDate'])
          : null,
      fieldMeasurements: json['fieldMeasurements'] != null
          ? (json['fieldMeasurements'] as List)
              .map((m) => FieldMeasurement.fromJson(m))
              .toList()
          : const [],
    );
  }
}
