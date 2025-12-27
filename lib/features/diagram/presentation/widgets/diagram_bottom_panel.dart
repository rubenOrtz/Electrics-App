import 'package:flutter/material.dart';
import '../../../../config/theme/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/diagram_models.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../config/theme/app_themes.dart';
import 'package:electrician_app/features/settings/domain/entities/app_theme_mode.dart';

class DiagramBottomPanel extends StatelessWidget {
  final DiagramNode? selectedNode;
  final Function(NodeType) onAddNode;
  final VoidCallback? onEditAdvanced;

  const DiagramBottomPanel({
    super.key,
    this.selectedNode,
    required this.onAddNode,
    this.onEditAdvanced,
  });

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final isHighContrast = themeState.mode == AppThemeMode.highContrastLight ||
        themeState.mode == AppThemeMode.highContrastDark;
    final isLightMode = themeState.mode == AppThemeMode.light ||
        themeState.mode == AppThemeMode.highContrastLight;
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final diagramTheme = theme.extension<DiagramTheme>()!;
    final topBg = diagramTheme.panelBg;
    final bottomBg = diagramTheme.nodeBg;

    return Container(
      decoration: BoxDecoration(
        color: topBg,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        border: Border(
          top: BorderSide(
            color: diagramTheme.nodeBorder.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Properties Section (Contextual) - On Dark Background
          // No padding at top to be flush with container
          if (selectedNode != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: _buildPropertiesStrip(
                  context, isHighContrast, isLightMode, theme, l10n),
            ),

          // 2. Palette Section (Always visible) - On Lighter Background
          // Includes the Drag Handle at its top
          Container(
            decoration: BoxDecoration(
              color: bottomBg,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Drag handle (Separador flotante)
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: diagramTheme.nodeBorder.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // Palette Content
                _buildPalette(
                    context, isHighContrast, isLightMode, theme, l10n),
                // Bottom safe area spacer
                SizedBox(height: isHighContrast ? 30 : 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertiesStrip(BuildContext context, bool isHighContrast,
      bool isLightMode, ThemeData theme, AppLocalizations l10n) {
    final diagramTheme = theme.extension<DiagramTheme>()!;
    final title = selectedNode!.properties['name'] ?? l10n.selectedElement;
    final accentColor = diagramTheme.accentColor;
    final textColor = diagramTheme.textColor;
    final borderWidth = isHighContrast ? 3.0 : 0.0;
    final borderColor =
        isHighContrast ? diagramTheme.nodeBorder : Colors.transparent;

    // Determine icon based on node type
    IconData nodeIcon = Icons.settings;
    switch (selectedNode!.type) {
      case NodeType.supply:
        nodeIcon = Icons.electrical_services;
        break;
      case NodeType.breaker:
        nodeIcon = Icons.toggle_on;
        break;
      case NodeType.differential:
        nodeIcon = Icons.toggle_off_outlined;
        break;
      case NodeType.load:
        nodeIcon = Icons.lightbulb;
        break;
      case NodeType.panel:
        nodeIcon = Icons.table_restaurant;
        break;
      default:
        nodeIcon = Icons.settings;
    }

    return Container(
      padding: EdgeInsets.fromLTRB(
        isHighContrast ? 20 : 16,
        0,
        isHighContrast ? 20 : 16,
        isHighContrast ? 20 : 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize
            .min, // Ensure it doesn't try to take infinite height unnecessarily
        children: [
          // Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(isHighContrast ? 10 : 8),
                      decoration: BoxDecoration(
                        border: isHighContrast
                            ? Border.all(color: borderColor, width: borderWidth)
                            : null,
                        borderRadius:
                            BorderRadius.circular(isHighContrast ? 12 : 8),
                        color: accentColor.withValues(alpha: 0.1),
                      ),
                      child: Icon(
                        nodeIcon,
                        color: accentColor,
                        size: isHighContrast ? 28 : 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isHighContrast ? title.toUpperCase() : title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: isHighContrast ? 20 : 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (selectedNode!.properties.containsKey('source'))
                            Flexible(
                              child: Text(
                                '${l10n.fromLabel}${selectedNode!.properties['source']}',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: textColor.withValues(alpha: 0.7),
                                  fontSize: isHighContrast ? 14 : 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Action buttons (Only Edit advanced here, delete is in Top/Floating)
              if (onEditAdvanced != null)
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    color: accentColor,
                    border: isHighContrast
                        ? Border.all(color: Colors.black, width: 2)
                        : null,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons
                          .settings, // Also updating action button to settings if that was the target
                      color: Colors.white,
                      size: isHighContrast ? 28 : 20,
                    ),
                    onPressed: onEditAdvanced,
                    padding: EdgeInsets.all(isHighContrast ? 12 : 8),
                    constraints: const BoxConstraints(),
                  ),
                ),
            ],
          ),
          SizedBox(height: isHighContrast ? 20 : 16),
          // Property Cards Row with more height
          SizedBox(
            height: isHighContrast ? 130 : 100, // Increased height
            child: ListView(
              scrollDirection: Axis.horizontal,
              children:
                  _buildPropertyCards(isHighContrast, isLightMode, theme, l10n),
            ),
          )
        ],
      ),
    );
  }

  /// Builds property cards with ALL backend data
  List<Widget> _buildPropertyCards(bool isHighContrast, bool isLightMode,
      ThemeData theme, AppLocalizations l10n) {
    if (selectedNode == null) return [];
    final props = selectedNode!.properties;
    final list = <Widget>[];

    // Helper to add spacing
    void addCard(Widget card) {
      list.add(card);
    }

    // ===== COMMON ELECTRICAL VALUES (All nodes) =====

    // 1. Voltage
    if (props.containsKey('voltage')) {
      addCard(_buildInfoCard(
        l10n.propVoltage,
        props['voltage'].toString(),
        "V",
        isHighContrast,
        theme,
        icon: Icons.electric_bolt,
      ));
    }

    // 2. Current (skip for protection nodes usually, but shown if present)
    final nodeType = props['type'] ?? '';
    if (props.containsKey('current') && nodeType != 'protection') {
      addCard(_buildInfoCard(
        l10n.propCurrent,
        props['current'].toString(),
        "A",
        isHighContrast,
        theme,
        icon: Icons.flash_on,
      ));
    }

    // 3. Voltage Drop
    if (props.containsKey('drop_percent') && nodeType != 'protection') {
      final drop = double.tryParse(props['drop_percent'].toString()) ?? 0.0;
      addCard(_buildInfoCard(
        l10n.propDrop,
        drop.toStringAsFixed(2),
        "%",
        isHighContrast,
        theme,
        icon: Icons.trending_down,
        isWarning: drop > 3.0,
      ));
    }

    // 4. Active Power
    if (props.containsKey('active_power_kw')) {
      addCard(_buildInfoCard(
        l10n.propPower,
        props['active_power_kw'].toString(),
        "kW",
        isHighContrast,
        theme,
        icon: Icons.power,
      ));
    }

    // 5. Power Factor
    if (props.containsKey('power_factor')) {
      final pf = double.tryParse(props['power_factor'].toString()) ?? 1.0;
      addCard(_buildInfoCard(
        l10n.propCosPhi,
        pf.toStringAsFixed(2),
        "",
        isHighContrast,
        theme,
        icon: Icons.analytics,
        isWarning: pf < 0.85,
      ));
    }

    // ===== CALCULATION RESULTS =====

    // 6. Design Current
    if (props.containsKey('design_current')) {
      addCard(_buildInfoCard(
        l10n.propDesignCurrent,
        props['design_current'].toString(),
        "A",
        isHighContrast,
        theme,
        icon: Icons.calculate,
      ));
    }

    // 7. Voltage at Node
    if (props.containsKey('voltage_at_node')) {
      addCard(_buildInfoCard(
        l10n.propVoltageNode,
        props['voltage_at_node'].toString(),
        "V",
        isHighContrast,
        theme,
        icon: Icons.location_on,
      ));
    }

    // 8. Drop Volts
    if (props.containsKey('drop_volts')) {
      final dropV = double.tryParse(props['drop_volts'].toString()) ?? 0.0;
      addCard(_buildInfoCard(
        l10n.propDropVolts,
        dropV.toStringAsFixed(1),
        "V",
        isHighContrast,
        theme,
        icon: Icons.arrow_downward,
        isWarning: dropV > 11.5,
      ));
    }

    // ===== NODE-SPECIFIC DETAILS =====

    switch (nodeType) {
      case 'source':
        if (props.containsKey('short_circuit_capacity')) {
          addCard(_buildInfoCard(
            l10n.propIcc,
            props['short_circuit_capacity'].toString(),
            "kA",
            isHighContrast,
            theme,
            icon: Icons.flash_auto,
          ));
        }
        break;

      case 'protection':
        if (props.containsKey('rating')) {
          addCard(_buildInfoCard(
            l10n.propRating,
            props['rating'].toString(),
            "A",
            isHighContrast,
            theme,
            icon: Icons.shield,
            isHighlight: true,
          ));
        }
        if (props.containsKey('curve')) {
          addCard(_buildInfoCard(
            l10n.propCurve,
            props['curve'].toString(),
            "",
            isHighContrast,
            theme,
            icon: Icons.show_chart,
          ));
        }
        if (props.containsKey('poles')) {
          addCard(_buildInfoCard(
            l10n.propPoles,
            props['poles'].toString(),
            "P",
            isHighContrast,
            theme,
            icon: Icons.apps,
          ));
        }
        if (props.containsKey('breaking_capacity')) {
          addCard(_buildInfoCard(
            l10n.propBreakingCap,
            props['breaking_capacity'].toString(),
            "kA",
            isHighContrast,
            theme,
            icon: Icons.security,
          ));
        }
        if (props.containsKey('sensitivity')) {
          addCard(_buildInfoCard(
            l10n.propSensitivity,
            props['sensitivity'].toString(),
            "mA",
            isHighContrast,
            theme,
            icon: Icons.sensors,
          ));
        }
        break;

      case 'load':
        // cos phi handled above if present
        break;
    }

    // ===== CABLE INFO =====
    if (props.containsKey('section_mm2')) {
      addCard(_buildInfoCard(
        l10n.propSection,
        props['section_mm2'].toString(),
        "mm²",
        isHighContrast,
        theme,
        icon: Icons.fiber_manual_record,
        isHighlight: true,
      ));
    }
    if (props.containsKey('length')) {
      addCard(_buildInfoCard(
        l10n.propLength,
        props['length'].toString(),
        "m",
        isHighContrast,
        theme,
        icon: Icons.straighten,
      ));
    }
    if (props.containsKey('material')) {
      addCard(_buildInfoCard(
        l10n.propMaterial,
        props['material'].toString(),
        "",
        isHighContrast,
        theme,
        icon: Icons.build,
      ));
    }

    // ===== ADVANCED =====
    if (props.containsKey('max_short_circuit_current')) {
      try {
        final iccAmps =
            double.parse(props['max_short_circuit_current'].toString());
        final iccKa = iccAmps / 1000;
        addCard(_buildInfoCard(
          l10n.propCalculateIcc,
          iccKa.toStringAsFixed(2),
          "kA",
          isHighContrast,
          theme,
          icon: Icons.bolt,
        ));
      } catch (_) {
        // Ignore parsing errors
      }
    }

    if (props.containsKey('loop_impedance')) {
      try {
        final zs = double.parse(props['loop_impedance'].toString());
        addCard(_buildInfoCard(
          l10n.propLoopImp,
          zs.toStringAsFixed(3),
          "Ω",
          isHighContrast,
          theme,
          icon: Icons.route,
        ));
      } catch (_) {
        // Ignore parsing errors
      }
    }

    if (props.containsKey('admissible_current')) {
      try {
        final iz = double.parse(props['admissible_current'].toString());
        addCard(_buildInfoCard(
          l10n.propAdmissibleI,
          iz.toStringAsFixed(1),
          "A",
          isHighContrast,
          theme,
          icon: Icons.check_circle_outline,
        ));
      } catch (_) {
        // Ignore parsing errors
      }
    }

    return list;
  }

  Widget _buildInfoCard(
    String label,
    String value,
    String unit,
    bool isHighContrast,
    ThemeData theme, {
    IconData? icon,
    bool isHighlight = false,
    bool isWarning = false,
  }) {
    final diagramTheme = theme.extension<DiagramTheme>()!;
    final borderColor = isHighContrast
        ? Colors.white
        : diagramTheme.nodeBorder.withValues(alpha: 0.5);
    final borderWidth = isHighContrast ? 3.0 : 1.0;

    // Background color logic
    Color bgColor = diagramTheme.nodeBg;
    if (isWarning) {
      bgColor = Colors.orange.withValues(alpha: 0.1);
    } else if (isHighlight) {
      bgColor = diagramTheme.accentColor.withValues(alpha: 0.1);
    }

    final labelColor = diagramTheme.textColor.withValues(alpha: 0.7);
    final valueColor = isWarning
        ? Colors.orange
        : (isHighlight ? diagramTheme.accentColor : diagramTheme.textColor);

    final iconColor = isWarning
        ? Colors.orange
        : (isHighlight
            ? diagramTheme.accentColor
            : diagramTheme.textColor.withValues(alpha: 0.7));

    return Container(
      constraints: BoxConstraints(minWidth: isHighContrast ? 120 : 100),
      margin: const EdgeInsets.only(right: 12),
      padding: EdgeInsets.all(isHighContrast ? 16 : 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(isHighContrast ? 16 : 12),
        border: Border.all(
          color: (isHighlight || isWarning) && !isHighContrast
              ? valueColor.withValues(alpha: 0.5)
              : borderColor,
          width: borderWidth,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: isHighContrast ? 20 : 16,
                color: iconColor,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: labelColor,
                    fontWeight: FontWeight.w600,
                    fontSize: isHighContrast ? 14 : 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: isHighContrast ? 8 : 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Flexible(
                flex: 3,
                child: Text(
                  value,
                  style: TextStyle(
                    color: valueColor,
                    fontWeight: FontWeight.w900,
                    fontSize: isHighContrast ? 34 : 26,
                    height: 1.0,
                    fontFamily: theme.textTheme.displayLarge?.fontFamily,
                    letterSpacing: -1.0,
                  ),
                  softWrap: true,
                ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  unit,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: diagramTheme.textColor.withValues(alpha: 0.5),
                    fontSize: isHighContrast ? 16 : 12,
                  ),
                  softWrap: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPalette(BuildContext context, bool isHighContrast,
      bool isLightMode, ThemeData theme, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Divider if properties were shown

        // Tabs
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
          child: Row(
            children: [
              _buildPaletteTab(l10n.paletteProtections, true, theme),
              _buildPaletteTab(l10n.paletteWiring, false, theme),
              _buildPaletteTab(l10n.paletteReceivers, false, theme),
              _buildPaletteTab(l10n.paletteMeasurement, false, theme),
            ],
          ),
        ),

        // Separator Line
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Divider(
            color: theme
                .extension<DiagramTheme>()!
                .nodeBorder
                .withValues(alpha: 0.3),
            thickness: 1,
            height: 1,
          ),
        ),

        // Grid Layout for Palette Items
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          // We use a responsive LayoutBuilder for grid calculation
          child: LayoutBuilder(builder: (context, constraints) {
            final width = constraints.maxWidth;
            const crossAxisCount = 5;
            // Calculate item width based on available width and spacing (12.0)
            final itemWidth =
                (width - ((crossAxisCount - 1) * 12)) / crossAxisCount;

            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildDraggableItem(context, NodeType.supply,
                    Icons.electrical_services, l10n.elemGrid, theme, itemWidth),
                _buildDraggableItem(context, NodeType.breaker, Icons.toggle_on,
                    l10n.elemBreaker, theme, itemWidth),
                _buildDraggableItem(
                    context,
                    NodeType.differential,
                    Icons.toggle_off_outlined,
                    l10n.elemDifferential,
                    theme,
                    itemWidth),
                _buildDraggableItem(context, NodeType.load, Icons.lightbulb,
                    l10n.elemLoad, theme, itemWidth),
                _buildDraggableItem(
                    context,
                    NodeType.panel,
                    Icons.table_restaurant,
                    l10n.elemSubpanel,
                    theme,
                    itemWidth),
              ],
            );
          }),
        ),
      ],
    );
  }

  Widget _buildPaletteTab(String label, bool isActive, ThemeData theme) {
    final diagramTheme = theme.extension<DiagramTheme>()!;
    final accent = diagramTheme.accentColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: isActive ? accent : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isActive ? accent : diagramTheme.nodeBorder),
      ),
      child: Text(label,
          style: TextStyle(
            color: isActive
                ? Colors.white
                : diagramTheme.textColor.withValues(alpha: 0.7),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          )),
    );
  }

  Widget _buildDraggableItem(BuildContext context, NodeType type, IconData icon,
      String label, ThemeData theme, double width) {
    // Premium Draggable Item
    final diagramTheme = theme.extension<DiagramTheme>()!;
    final accent = diagramTheme.accentColor;
    final isDark = theme.brightness == Brightness.dark;

    // Darker/Lighter background for the item to pop from the panel
    // If panel is 111722, item should be slightly lighter 1E293B
    // Darker/Lighter background for the item to pop from the panel
    // Use scaffold background for items to contrast against the card background of the panel
    final itemBg = diagramTheme.canvasBg;

    Widget buildBox(bool isDragInfo) {
      return Container(
        width: width,
        height: width, // Square aspect ratio
        decoration: BoxDecoration(
          color: itemBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: isDragInfo ? accent : Colors.transparent,
              width: isDragInfo ? 2 : 0),
          boxShadow: isDragInfo
              ? [
                  BoxShadow(
                      color: accent.withValues(alpha: 0.3), blurRadius: 12)
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: isDark
                  ? null
                  : BoxDecoration(
                      color: diagramTheme.nodeBg,
                      shape: BoxShape.circle,
                    ), // Simplify icon background for chubbier look in dark mode
              child: Icon(icon,
                  color: isDragInfo ? accent : diagramTheme.textColor,
                  size: 24),
            ),
            // Minimal gap
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: diagramTheme.textColor.withValues(alpha: 0.7),
                      fontSize: 9,
                      height: 1.1,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: () => onAddNode(type),
      child: Draggable<NodeType>(
        data: type,
        feedback: Material(
          color: Colors.transparent,
          child: SizedBox(width: width, height: width, child: buildBox(true)),
        ),
        child: buildBox(false),
      ),
    );
  }
}
