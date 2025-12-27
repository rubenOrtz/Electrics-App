import 'package:flutter/material.dart';
import '../../../diagram/domain/entities/electrical_node.dart';
import '../../../diagram/domain/services/tree_utilities.dart';
import '../../domain/entities/field_measurement.dart';
import '../extensions/field_measurement_ui_extension.dart';
import '../../../../core/presentation/widgets/app_button.dart';
import '../../../../core/presentation/widgets/coming_soon_dialog.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../config/theme/app_themes.dart';

/// Premier Component Detail Sheet
/// improved with Clean Architecture UI components and Localization
class ComponentDetailSheet extends StatelessWidget {
  final ElectricalNode node;
  final List<FieldMeasurement> measurements;

  const ComponentDetailSheet({
    super.key,
    required this.node,
    this.measurements = const [],
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    // Attempt to get the DiagramTheme extension, fallback if needed
    final diagramTheme = theme.extension<DiagramTheme>() ??
        DiagramTheme(
          canvasBg: const Color(0xFF111827),
          panelBg: const Color(0xFF1E293B),
          gridLine: Colors.white10,
          nodeBg: const Color(0xFF1E293B),
          nodeBorder: Colors.white24,
          textColor: Colors.white,
          accentColor: theme.primaryColor,
          isDark: true,
        );

    final bgColor = diagramTheme.panelBg;
    final textPrimary = diagramTheme.textColor;
    final textSecondary = diagramTheme.textColor.withValues(alpha: 0.7);

    final properties = TreeUtilities.extractProperties(node);

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, -5),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 20),
              width: 48,
              height: 5,
              decoration: BoxDecoration(
                color: textSecondary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2.5),
              ),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        node.name,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getNodeType(node, l10n),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: textSecondary, size: 28),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  style: IconButton.styleFrom(
                    backgroundColor: textSecondary.withValues(alpha: 0.1),
                    padding: const EdgeInsets.all(8),
                    shape: const CircleBorder(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          Divider(color: textSecondary.withValues(alpha: 0.1), height: 1),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Configuration Section
                  _buildSectionHeader(
                      l10n.componentConfig, Icons.settings_outlined, theme),
                  const SizedBox(height: 16),
                  _buildPropertiesGrid(properties, theme, diagramTheme,
                      textPrimary, textSecondary, l10n),

                  const SizedBox(height: 32),

                  // Measurements Section
                  _buildSectionHeader(l10n.measurementsRegistered,
                      Icons.science_outlined, theme),
                  const SizedBox(height: 16),
                  measurements.isEmpty
                      ? _buildNoMeasurements(diagramTheme, textSecondary, l10n)
                      : _buildMeasurementsList(measurements, diagramTheme,
                          textPrimary, textSecondary, l10n),

                  const SizedBox(height: 40),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          text: l10n.delete,
                          isSecondary: true,
                          icon: Icons.delete_outline,
                          textColor: Colors.redAccent,
                          onPressed: () => showComingSoon(context,
                              featureName: "Eliminar Componente"),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AppButton(
                          text: l10n.editDetail,
                          icon: Icons.edit_outlined,
                          onPressed: () => showComingSoon(context,
                              featureName: "Editar Componente"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, ThemeData theme) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: theme.primaryColor, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            color: theme.primaryColor, // Matching accent color
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildPropertiesGrid(
    Map<String, dynamic> properties,
    ThemeData theme,
    DiagramTheme diagramTheme,
    Color textPrimary,
    Color textSecondary,
    AppLocalizations l10n,
  ) {
    if (properties.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: diagramTheme.nodeBg.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
          border:
              Border.all(color: diagramTheme.nodeBorder.withValues(alpha: 0.3)),
        ),
        child: Center(
          child: Text(
            l10n.noProperties,
            style: TextStyle(color: textSecondary, fontSize: 15),
          ),
        ),
      );
    }

    return Column(
      children: properties.entries.map((entry) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: diagramTheme.nodeBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: diagramTheme.nodeBorder.withValues(alpha: 0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  _formatPropertyName(entry.key),
                  style: TextStyle(
                    color: textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 4,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _formatPropertyValueWithUnit(entry.key, entry.value),
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily:
                          'RobotoMono', // Monospace for numbers looks techy
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNoMeasurements(
      DiagramTheme diagramTheme, Color textSecondary, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: diagramTheme.nodeBg.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: diagramTheme.nodeBorder.withValues(alpha: 0.3),
            style: BorderStyle.solid),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.science_outlined,
              color: textSecondary.withValues(alpha: 0.4),
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.noMeasurements,
              style: TextStyle(
                color: textSecondary,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeasurementsList(
      List<FieldMeasurement> measurements,
      DiagramTheme diagramTheme,
      Color textPrimary,
      Color textSecondary,
      AppLocalizations l10n) {
    return Column(
      children: measurements.take(10).map((measurement) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: diagramTheme.nodeBg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: diagramTheme.nodeBorder.withValues(alpha: 0.2)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4))
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          diagramTheme.accentColor.withValues(alpha: 0.2),
                          diagramTheme.accentColor.withValues(alpha: 0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getMeasurementIcon(measurement),
                      color: diagramTheme.accentColor,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getMeasurementType(measurement, l10n),
                          style: TextStyle(
                            color: textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatDate(measurement.measuredAt),
                          style: TextStyle(
                            color: textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Divider(color: textSecondary.withValues(alpha: 0.1), height: 1),
              const SizedBox(height: 20),

              // Details
              ..._buildMeasurementDetails(
                  measurement, textPrimary, textSecondary, l10n),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// Builds formatted measurement detail rows using the FieldMeasurementUI extension.
  ///
  /// This method delegates to the extension to keep the presentation logic clean
  /// and maintainable. See [FieldMeasurementUI.buildDetailRows] for implementation.
  List<Widget> _buildMeasurementDetails(
    FieldMeasurement measurement,
    Color textPrimary,
    Color textSecondary,
    AppLocalizations l10n,
  ) {
    return measurement.buildDetailRows(
      textPrimary,
      textSecondary,
      l10n,
      _buildMeasurementRow,
    );
  }

  Widget _buildMeasurementRow(
    String label,
    String value,
    String unit,
    Color textPrimary,
    Color textSecondary, {
    String? status,
    Color? statusColor,
  }) {
    final isLongValue = value.length > 30;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: isLongValue
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: textPrimary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: textSecondary.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          value,
                          style: TextStyle(
                            color: textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true,
                        ),
                      ),
                      if (unit.isNotEmpty) ...[
                        const SizedBox(width: 4),
                        Text(
                          unit,
                          style: TextStyle(
                            color: textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    label,
                    style: TextStyle(
                      color: textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          value,
                          style: TextStyle(
                            color: textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          softWrap: true,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      if (unit.isNotEmpty) ...[
                        const SizedBox(width: 4),
                        Text(
                          unit,
                          style: TextStyle(
                            color: textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  String _formatPropertyName(String key) {
    return key
        .split('_')
        .map((word) =>
            word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String _formatPropertyValueWithUnit(String key, dynamic value) {
    if (value == null) return 'N/A';
    if (value is bool) return value ? 'Sí' : 'No';

    final String valueStr = value.toString();

    if (key.contains('voltage') || key.contains('nominal_voltage')) {
      return '$valueStr V';
    } else if (key.contains('current') || key.contains('rating')) {
      return '$valueStr A';
    } else if (key.contains('power')) {
      return '$valueStr W';
    } else if (key.contains('length')) {
      return '$valueStr m';
    } else if (key.contains('section') || key.contains('cross_section')) {
      return '$valueStr mm²';
    } else if (key.contains('impedance') || key.contains('resistance')) {
      return '$valueStr Ω';
    } else if (key.contains('drop_percent')) {
      return '$valueStr %';
    } else if (key.contains('capacity')) {
      return '$valueStr kA';
    }

    return valueStr;
  }

  String _getNodeType(ElectricalNode node, AppLocalizations l10n) {
    return node.map(
      source: (_) => l10n.sourceInput,
      panel: (_) => l10n.panel,
      protection: (_) => l10n.protection,
      load: (_) => l10n.loadCircuit,
    );
  }

  IconData _getMeasurementIcon(FieldMeasurement measurement) {
    return measurement.map(
      source: (_) => Icons.power_input,
      rcd: (_) => Icons.add_moderator,
      insulation: (_) => Icons.health_and_safety,
      load: (_) => Icons.electric_bolt,
      panel: (_) => Icons.landscape,
      generic: (_) => Icons.note_alt,
    );
  }

  String _getMeasurementType(
      FieldMeasurement measurement, AppLocalizations l10n) {
    return measurement.map(
      source: (_) => l10n.measurementSource,
      rcd: (_) => l10n.measurementRcd,
      insulation: (_) => l10n.measurementInsulation,
      load: (_) => l10n.measurementLoad,
      panel: (_) => l10n.measurementPanel,
      generic: (_) => l10n.measurementGeneric,
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
