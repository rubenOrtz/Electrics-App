import 'package:flutter/material.dart';
import '../../domain/entities/field_measurement.dart';
import '../../../../l10n/app_localizations.dart';

/// Extension on FieldMeasurement to provide UI-specific formatting utilities.
///
/// This extension separates the complex measurement-to-widget mapping logic
/// from the presentation layer, following Clean Architecture principles.
extension FieldMeasurementUI on FieldMeasurement {
  /// Builds a list of measurement detail rows for display in UI.
  ///
  /// Returns formatted widgets showing measurement values with appropriate
  /// labels, units, and status indicators based on the measurement type.
  List<Widget> buildDetailRows(
    Color textPrimary,
    Color textSecondary,
    AppLocalizations l10n,
    Widget Function(String label, String value, String unit, Color textPrimary,
            Color textSecondary,
            {String? status, Color? statusColor})
        buildRow,
  ) {
    // 1. Get specific rows based on measurement type
    final specificRows = map(
      source: (m) => [
        if (m.voltageLN != null)
          buildRow(l10n.voltageLN, '${m.voltageLN}', 'V', textPrimary,
              textSecondary),
        if (m.voltageLL != null)
          buildRow(l10n.voltageLL, '${m.voltageLL}', 'V', textPrimary,
              textSecondary),
        if (m.frequency != null)
          buildRow(l10n.frequency, '${m.frequency}', 'Hz', textPrimary,
              textSecondary),
        if (m.externalZe != null)
          buildRow(l10n.externalZe, '${m.externalZe}', 'Ω', textPrimary,
              textSecondary),
      ],
      rcd: (m) => [
        if (m.tripTimeMs != null)
          buildRow(
            l10n.tripTime,
            '${m.tripTimeMs}',
            'ms',
            textPrimary,
            textSecondary,
            status: (m.tripTimeMs! <= 300) ? 'OK' : 'FALLO',
            statusColor:
                (m.tripTimeMs! <= 300) ? Colors.greenAccent : Colors.redAccent,
          ),
        if (m.tripCurrentmA != null)
          buildRow(l10n.tripCurrent, '${m.tripCurrentmA}', 'mA', textPrimary,
              textSecondary),
        if (m.contactVoltage != null)
          buildRow(l10n.contactVoltage, '${m.contactVoltage}', 'V', textPrimary,
              textSecondary),
        buildRow(
          l10n.mechanicalTest,
          (m.mechanicalTestPassed ?? false) ? l10n.passed : l10n.failed,
          '',
          textPrimary,
          textSecondary,
          statusColor: (m.mechanicalTestPassed ?? false)
              ? Colors.greenAccent
              : Colors.redAccent,
        ),
      ],
      insulation: (m) => [
        if (m.resistancePhaseEarth != null)
          buildRow(
            l10n.phaseEarthR,
            '${m.resistancePhaseEarth}',
            'MΩ',
            textPrimary,
            textSecondary,
            status: (m.resistancePhaseEarth! >= 0.5) ? 'OK' : 'FALLO',
            statusColor: (m.resistancePhaseEarth! >= 0.5)
                ? Colors.greenAccent
                : Colors.redAccent,
          ),
        if (m.resistancePhaseNeutral != null)
          buildRow(l10n.phaseNeutralR, '${m.resistancePhaseNeutral}', 'MΩ',
              textPrimary, textSecondary),
        buildRow(
          l10n.continuityPE,
          (m.continuityPE ?? false) ? l10n.yes : l10n.no,
          '',
          textPrimary,
          textSecondary,
          statusColor: (m.continuityPE ?? false)
              ? Colors.greenAccent
              : Colors.orangeAccent,
        ),
      ],
      load: (m) => [
        if (m.loopImpedanceZs != null)
          buildRow(l10n.loopImpedance, '${m.loopImpedanceZs}', 'Ω', textPrimary,
              textSecondary),
        if (m.voltageAtLoad != null)
          buildRow(
            l10n.voltageLoad,
            '${m.voltageAtLoad}',
            'V',
            textPrimary,
            textSecondary,
            status: (m.voltageAtLoad! >= 207) ? 'OK' : 'BAJA',
            statusColor: (m.voltageAtLoad! >= 207)
                ? Colors.greenAccent
                : Colors.orangeAccent,
          ),
        buildRow(
          l10n.polarity,
          (m.polarityOk ?? false) ? l10n.correct : l10n.incorrect,
          '',
          textPrimary,
          textSecondary,
          statusColor:
              (m.polarityOk ?? false) ? Colors.greenAccent : Colors.redAccent,
        ),
      ],
      panel: (m) => [
        if (m.earthResistanceRa != null)
          buildRow(
            l10n.earthResistance,
            '${m.earthResistanceRa}',
            'Ω',
            textPrimary,
            textSecondary,
            status: (m.earthResistanceRa! <= 20) ? 'OK' : 'ALTA',
            statusColor: (m.earthResistanceRa! <= 20)
                ? Colors.greenAccent
                : Colors.orangeAccent,
          ),
      ],
      generic: (m) => [],
    );

    // 2. Combine specific rows with common "Notes" field
    return [
      ...specificRows,
      if (notes != null && notes!.isNotEmpty)
        buildRow(l10n.notes, notes!, '', textPrimary, textSecondary),
    ];
  }
}
