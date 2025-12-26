import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../config/theme/app_themes.dart';
import '../../domain/entities/electrical_enums.dart';
import '../../domain/entities/catalog_metadata.dart';
import '../../../components/domain/entities/component_template.dart';
import '../../domain/services/electrical_calculator.dart';

import 'cable_catalog_dialog.dart';
import 'dart:math';

class _CalcResult {
  final double section;
  final double dropPercent;
  final double amps;
  final bool isCompliant;
  final double dUVolts;
  final double iz;
  final bool izCompliant;

  _CalcResult({
    required this.section,
    required this.dropPercent,
    required this.amps,
    required this.isCompliant,
    required this.dUVolts,
    required this.iz,
    required this.izCompliant,
  });
}

class CircuitConfigSheet extends StatefulWidget {
  final Function(CircuitConfigData) onSave;
  final VoidCallback? onCancel;
  final CircuitConfigData? initialData;

  const CircuitConfigSheet({
    Key? key,
    required this.onSave,
    this.onCancel,
    this.initialData,
  }) : super(key: key);

  @override
  State<CircuitConfigSheet> createState() => _CircuitConfigSheetState();
}

class _CircuitConfigSheetState extends State<CircuitConfigSheet> {
  // Form State
  late LoadType _selectedType;
  late bool _isThreePhase;
  late double _powerKw;
  late double _cosPhi;
  late double _lengthMeters;
  late double? _selectedSection;

  // Iz Params
  late InstallationMethod _installMethod;
  late CableInsulation _insulation;
  late double _ambientTemp;
  late int _numCircuits;
  late double _soilResistivity;

  // UI State
  bool _powerUnitIsWatts = false;

  // Controllers for synchronization
  late TextEditingController _lengthController;

  // Catalog metadata
  CatalogMetadata? _cableCatalogData;

  @override
  void initState() {
    super.initState();
    final d = widget.initialData;
    _selectedType = d?.type ?? LoadType.lighting;
    _isThreePhase = d?.isThreePhase ?? false;
    _powerKw = d?.powerKw ?? 5.75;
    _cosPhi = d?.cosPhi ?? 0.9;
    _lengthMeters = d?.lengthMeters ?? 45;
    _selectedSection = d?.sectionMm2;

    _installMethod = d?.installMethod ?? InstallationMethod.b1;
    _insulation = d?.insulation ?? CableInsulation.pvc;
    _ambientTemp = d?.correctionFactors?.ambientTemperature ?? 30.0;
    _numCircuits = d?.correctionFactors?.numberOfCircuits ?? 1;
    _soilResistivity = d?.correctionFactors?.soilResistivity ?? 2.5;

    // Init Controller
    _lengthController =
        TextEditingController(text: _lengthMeters.toInt().toString());

    // Restore catalog metadata
    _cableCatalogData = d?.cableCatalogData;
  }

  @override
  void dispose() {
    _lengthController.dispose();
    super.dispose();
  }

  double _parseInput(String v) {
    return double.tryParse(v.replaceAll(',', '.')) ?? 0.0;
  }

  final List<double> _standardSections = [
    1.5,
    2.5,
    4.0,
    6.0,
    10.0,
    16.0,
    25.0,
    35.0,
    50.0
  ];

  @override
  Widget build(BuildContext context) {
    // Theme aware colors
    final theme = Theme.of(context);
    final diagramTheme = theme.extension<DiagramTheme>()!;
    final l10n = AppLocalizations.of(context)!;

    final bg = diagramTheme.panelBg;
    final cardBg = diagramTheme.nodeBg;
    final text = diagramTheme.textColor;
    final accent = diagramTheme.accentColor;
    final borderColor = diagramTheme.nodeBorder;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.circuitCalculation,
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w900, fontSize: 24)),
              TextButton(
                  onPressed: widget.onCancel,
                  child: Text(l10n.reset,
                      style: TextStyle(color: theme.disabledColor)))
            ],
          ),
          const SizedBox(height: 20),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Load Type
                  _sectionTitle(l10n.loadType, theme),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildTypeChip(
                          l10n.lighting,
                          Icons.lightbulb,
                          LoadType.lighting,
                          _selectedType == LoadType.lighting,
                          theme),
                      const SizedBox(width: 10),
                      _buildTypeChip(l10n.power, Icons.power, LoadType.power,
                          _selectedType == LoadType.power, theme),
                      const SizedBox(width: 10),
                      _buildTypeChip(l10n.motor, Icons.settings, LoadType.motor,
                          _selectedType == LoadType.motor, theme),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 2. Electrical params
                  _sectionTitle(l10n.electricalParams, theme),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: borderColor)),
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        Expanded(
                            child: _buildToggleBtn(
                                l10n.singlePhase,
                                !_isThreePhase,
                                () => setState(() => _isThreePhase = false),
                                theme)),
                        Expanded(
                            child: _buildToggleBtn(
                                l10n.threePhase,
                                _isThreePhase,
                                () => setState(() => _isThreePhase = true),
                                theme)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),

                  // 2.1 Cable Section
                  _sectionTitle(l10n.cableSection, theme),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: borderColor)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<double?>(
                        dropdownColor: cardBg,
                        value: _selectedSection,
                        isExpanded: true,
                        icon: Icon(Icons.arrow_drop_down, color: accent),
                        hint: Text(l10n.automaticOptimized,
                            style: TextStyle(
                                color: accent, fontWeight: FontWeight.bold)),
                        items: [
                          DropdownMenuItem<double?>(
                            value: null,
                            child: Text(l10n.automaticOptimized,
                                style: TextStyle(
                                    color: accent,
                                    fontWeight: FontWeight.bold)),
                          ),
                          ..._standardSections
                              .map((s) => DropdownMenuItem<double?>(
                                    value: s,
                                    child: Text("${s.toStringAsFixed(1)} mm²",
                                        style: TextStyle(color: text)),
                                  ))
                        ],
                        onChanged: (v) => setState(() => _selectedSection = v),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Power and Cos Phi
                  Row(
                    children: [
                      Expanded(
                        child: _buildEditableInput(
                          l10n.propPower.toUpperCase(),
                          _powerUnitIsWatts
                              ? (_powerKw * 1000).toStringAsFixed(1)
                              : _powerKw.toStringAsFixed(2),
                          (v) => setState(() {
                            final val = _parseInput(v);
                            _powerKw = _powerUnitIsWatts ? val / 1000 : val;
                          }),
                          theme,
                          suffixWidget: GestureDetector(
                            onTap: () => setState(
                                () => _powerUnitIsWatts = !_powerUnitIsWatts),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: accent.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                _powerUnitIsWatts ? "W" : "kW",
                                style: TextStyle(
                                    color: accent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildEditableInput(
                          l10n.propCosPhi.toUpperCase(),
                          _cosPhi.toString(),
                          (v) => setState(() => _cosPhi = _parseInput(v)),
                          theme,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 3. Length
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: cardBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: borderColor)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(l10n.lineLength,
                                style: TextStyle(
                                    color: theme.disabledColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              width: 100,
                              child: _buildEditableInput(
                                "",
                                _lengthMeters.toInt().toString(),
                                (v) {
                                  final val = double.tryParse(v);
                                  if (val != null) {
                                    setState(() => _lengthMeters = val);
                                  }
                                },
                                theme,
                                suffix: "m",
                                alignRight: true,
                                transparent: true,
                                controller: _lengthController,
                              ),
                            ),
                          ],
                        ),
                        Slider(
                          value: _lengthMeters.clamp(1.0, 100.0),
                          min: 1,
                          max: 100,
                          activeColor: accent,
                          inactiveColor: borderColor,
                          onChanged: (v) {
                            setState(() {
                              _lengthMeters = v;
                              _lengthController.text = v.toInt().toString();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 4. Cable Type & Installation
                  _sectionTitle(l10n.cableType, theme),
                  const SizedBox(height: 10),
                  _buildCableSelector(theme),

                  const SizedBox(height: 10),
                  // NEW: Insulation Selector
                  _buildInsulationSelector(theme),
                  const SizedBox(height: 20),

                  _sectionTitle(l10n.installationMethod, theme),
                  const SizedBox(height: 10),
                  _buildInstallationSelector(theme, l10n),

                  // NEW: Correction Factors
                  const SizedBox(height: 20),
                  _sectionTitle("Factores de Corrección", theme),
                  const SizedBox(height: 10),
                  _buildCorrectionFactors(theme),

                  const SizedBox(height: 20),

                  // 5. Results (Real-time Estimation)
                  _buildResultsSection(theme, l10n),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Action
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                onPressed: () {
                  final factors = CorrectionFactors(
                    ambientTemperature: _ambientTemp,
                    numberOfCircuits: _numCircuits,
                    soilResistivity: _soilResistivity,
                  );

                  widget.onSave(CircuitConfigData(
                      type: _selectedType,
                      isThreePhase: _isThreePhase,
                      powerKw: _powerKw,
                      cosPhi: _cosPhi,
                      lengthMeters: _lengthMeters,
                      sectionMm2: _calculateValues().section,
                      installMethod: _installMethod,
                      insulation: _insulation,
                      correctionFactors: factors,
                      cableCatalogData: _cableCatalogData));
                },
                icon: const Icon(Icons.check_circle, color: Colors.white),
                label: Text(l10n.validateDesign,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold))),
          ),
          // Safe area padding for device navbar
          SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
        ],
      ),
    );
  }

  // --- Widgets Helpers ---

  Widget _buildCableSelector(ThemeData theme) {
    final diagramTheme = theme.extension<DiagramTheme>()!;
    final activeColor = diagramTheme.accentColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Cable banner (if linked)
        if (_cableCatalogData != null)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: activeColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: activeColor.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.link, color: activeColor, size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text("Cable Vinculado",
                          style: TextStyle(
                              color: activeColor, fontWeight: FontWeight.bold)),
                    ),
                    GestureDetector(
                      onTap: _unlinkCableData,
                      child: Container(
                        decoration: BoxDecoration(
                          color: activeColor.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.close, size: 16, color: activeColor),
                      ),
                    )
                  ],
                ),
                if (_cableCatalogData != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4, left: 24),
                    child: Text(
                      "${_cableCatalogData!.brand} - ${_cableCatalogData!.reference ?? _cableCatalogData!.displayName}",
                      style:
                          TextStyle(color: theme.disabledColor, fontSize: 11),
                    ),
                  ),
              ],
            ),
          ),
        if (_cableCatalogData != null) const SizedBox(height: 16),

        // Library Button - Only show if no cable linked
        if (_cableCatalogData == null)
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                  color: diagramTheme.accentColor.withValues(alpha: 0.3)),
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  diagramTheme.accentColor.withValues(alpha: 0.05),
                  diagramTheme.accentColor.withValues(alpha: 0.02),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: TextButton.icon(
                onPressed: _openCableCatalog,
                icon:
                    Icon(Icons.library_books, color: diagramTheme.accentColor),
                label: Text("Abrir Librería de Cables",
                    style: TextStyle(
                        color: diagramTheme.accentColor,
                        fontWeight: FontWeight.w600))),
          ),
      ],
    );
  }

  Widget _buildInsulationSelector(ThemeData theme) {
    final diagramTheme = theme.extension<DiagramTheme>()!;
    final cardBg = diagramTheme.nodeBg;
    final borderColor = diagramTheme.nodeBorder;
    final accent = diagramTheme.accentColor;
    final text = diagramTheme.textColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor)),
      child: AbsorbPointer(
        absorbing: _cableCatalogData != null,
        child: Opacity(
          opacity: _cableCatalogData != null ? 0.6 : 1.0,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<CableInsulation>(
              dropdownColor: cardBg,
              value: _insulation,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: accent),
              hint: Text("Aislamiento",
                  style: TextStyle(color: accent, fontWeight: FontWeight.bold)),
              items: CableInsulation.values
                  .map((i) => DropdownMenuItem(
                        value: i,
                        child: Text(i.label,
                            style: TextStyle(
                                color: text, fontWeight: FontWeight.bold)),
                      ))
                  .toList(),
              onChanged: (v) => setState(() {
                if (v != null) _insulation = v;
              }),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openCableCatalog() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => const CableCatalogDialog(),
    );

    if (result != null) {
      final metadata = result['metadata'] as CatalogMetadata;
      final cable = result['cable'] as CableTemplate;

      setState(() {
        _cableCatalogData = metadata;
        _selectedSection = cable.section;

        // Map Insulation
        final insLower = cable.insulationType.toLowerCase();
        if (insLower.contains('pvc')) {
          _insulation = CableInsulation.pvc;
        } else if (insLower.contains('xlpe') || insLower.contains('z1')) {
          // Z1 acts as XLPE thermally usually, or mapped to Z1 if exists
          _insulation = (insLower.contains('z1'))
              ? CableInsulation.z1
              : CableInsulation.xlpe;
        }

        // Map Method if present (e.g. "F")
        if (cable.installationMethod != null) {
          final mLower = cable.installationMethod!.toLowerCase();
          for (var m in InstallationMethod.values) {
            if (m.name == mLower) {
              _installMethod = m;
              break;
            }
          }
        }
      });
    }
  }

  void _unlinkCableData() {
    setState(() {
      _cableCatalogData = null;
    });
  }

  Widget _buildInstallationSelector(ThemeData theme, AppLocalizations l10n) {
    final diagramTheme = theme.extension<DiagramTheme>()!;
    final accent = diagramTheme.accentColor;
    final cardBg = diagramTheme.nodeBg;
    final borderColor = diagramTheme.nodeBorder;
    final text = diagramTheme.textColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<InstallationMethod>(
          dropdownColor: cardBg,
          value: _installMethod,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down, color: accent),
          items: InstallationMethod.values
              .map((m) => DropdownMenuItem(
                    value: m,
                    child: Text(m.label,
                        style: TextStyle(
                            color: text,
                            fontSize: 13,
                            overflow: TextOverflow.ellipsis)),
                  ))
              .toList(),
          onChanged: (v) => setState(() {
            if (v != null) _installMethod = v;
            // Reset factors defaults if needed?
          }),
        ),
      ),
    );
  }

  Widget _buildCorrectionFactors(ThemeData theme) {
    final diagramTheme = theme.extension<DiagramTheme>()!;
    final cardBg = diagramTheme.nodeBg;
    final borderColor = diagramTheme.nodeBorder;
    final accent = diagramTheme.accentColor;

    final isBuried = _installMethod.isBuried;
    final tempLabel =
        isBuried ? "Temperatura Suelo (°C)" : "Temperatura Aire (°C)";

    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor)),
        child: Column(
          children: [
            // Temperature
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(tempLabel,
                    style: TextStyle(color: theme.disabledColor, fontSize: 12)),
                Text("${_ambientTemp.toStringAsFixed(0)}°C",
                    style:
                        TextStyle(color: accent, fontWeight: FontWeight.bold)),
              ],
            ),
            Slider(
              value: _ambientTemp.clamp(10.0, 60.0),
              min: 10,
              max: 60,
              divisions: 10,
              activeColor: accent,
              onChanged: (v) => setState(() => _ambientTemp = v),
            ),

            // Grouping
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Circuitos Agrupados",
                    style: TextStyle(color: theme.disabledColor, fontSize: 12)),
                Text("$_numCircuits",
                    style:
                        TextStyle(color: accent, fontWeight: FontWeight.bold)),
              ],
            ),
            Slider(
              value: _numCircuits.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              activeColor: accent,
              onChanged: (v) => setState(() => _numCircuits = v.toInt()),
            ),

            // Soil Resistivity (Conditional)
            if (isBuried) ...[
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Resistividad Térmica (K·m/W)",
                      style:
                          TextStyle(color: theme.disabledColor, fontSize: 12)),
                  Text(_soilResistivity.toStringAsFixed(1),
                      style: TextStyle(
                          color: accent, fontWeight: FontWeight.bold)),
                ],
              ),
              Slider(
                value: _soilResistivity,
                min: 0.5,
                max: 3.0,
                divisions: 5,
                activeColor: accent,
                onChanged: (v) => setState(() => _soilResistivity = v),
              ),
            ]
          ],
        ));
  }

  Widget _sectionTitle(String text, ThemeData theme) {
    return Text(text,
        style: TextStyle(
            color: theme.textTheme.bodyMedium?.color ?? Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5));
  }

  Widget _buildTypeChip(String label, IconData icon, LoadType type,
      bool isSelected, ThemeData theme) {
    final diagramTheme = theme.extension<DiagramTheme>()!;
    final activeColor = diagramTheme.accentColor;
    final cardBg = diagramTheme.nodeBg;
    final borderColor = diagramTheme.nodeBorder;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() {
          _selectedType = type;
          switch (type) {
            case LoadType.lighting:
              _cosPhi = 1.0;
              break;
            case LoadType.power:
              _cosPhi = 0.9;
              break;
            case LoadType.motor:
              _cosPhi = 0.8;
              break;
          }
        }),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? activeColor : cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? activeColor : borderColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 24,
                  color: isSelected ? Colors.white : theme.disabledColor),
              const SizedBox(width: 8),
              Flexible(
                child: Text(label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: isSelected ? Colors.white : theme.disabledColor,
                        fontSize: 13,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleBtn(
      String text, bool isActive, VoidCallback onTap, ThemeData theme) {
    final diagramTheme = theme.extension<DiagramTheme>()!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? diagramTheme.panelBg : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(text,
              style: TextStyle(
                  color: isActive
                      ? theme.textTheme.bodyMedium?.color
                      : theme.disabledColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  Widget _buildEditableInput(
      String label, String value, Function(String) onChanged, ThemeData theme,
      {String suffix = "",
      Widget? suffixWidget,
      bool alignRight = false,
      bool transparent = false,
      TextEditingController? controller}) {
    final diagramTheme = theme.extension<DiagramTheme>()!;
    final cardBg = diagramTheme.nodeBg;
    final borderColor = diagramTheme.nodeBorder;

    return Container(
      padding: EdgeInsets.all(transparent ? 0 : 12),
      decoration: BoxDecoration(
        color: transparent ? Colors.transparent : cardBg,
        borderRadius: BorderRadius.circular(12),
        border: transparent ? null : Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (label.isNotEmpty) ...[
            Text(label,
                style: TextStyle(
                    color: theme.disabledColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
          ],
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  initialValue: controller != null ? null : value,
                  cursorColor: theme.primaryColor,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  textAlign: alignRight ? TextAlign.end : TextAlign.start,
                  style: TextStyle(
                      color: theme.textTheme.bodyMedium?.color,
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                  decoration: const InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onChanged: onChanged,
                ),
              ),
              if (suffixWidget != null)
                suffixWidget
              else if (suffix.isNotEmpty) ...[
                const SizedBox(width: 4),
                Text(suffix,
                    style: TextStyle(
                        color: theme.disabledColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ]
            ],
          )
        ],
      ),
    );
  }

  Widget _buildResultValue(String label, String value,
      {Color? color, required ThemeData theme}) {
    final diagramTheme = theme.extension<DiagramTheme>()!;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: diagramTheme.panelBg.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: diagramTheme.nodeBorder.withValues(alpha: 0.2))),
      child: Column(
        children: [
          Text(label,
              style: TextStyle(color: theme.disabledColor, fontSize: 10)),
          Text(value,
              style: TextStyle(
                  color: color ?? theme.textTheme.bodyMedium?.color,
                  fontSize: 14,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  _CalcResult _calculateValues() {
    final p = _powerKw * 1000;
    // Protect acos domain
    final cosVal = _cosPhi.clamp(0.0, 1.0);
    final angle = acos(cosVal);
    final q = p * tan(angle);
    const conductivity = 56.0;

    List<double> sectionsToCheck =
        _selectedSection != null ? [_selectedSection!] : _standardSections;

    _CalcResult? best;

    // Create current correction factors
    final factors = CorrectionFactors(
      ambientTemperature: _ambientTemp,
      numberOfCircuits: _numCircuits,
      soilResistivity: _soilResistivity,
    );

    for (var s in sectionsToCheck) {
      // Impedance
      double r = (1.0 / conductivity) * _lengthMeters / s;
      double x = 0.00008 * _lengthMeters;

      // Drop Formula
      double baseV = _isThreePhase ? 400.0 : 230.0;
      double num = r * p + x * q;
      double dU = 0.0;

      if (_isThreePhase) {
        dU = (baseV > 0) ? num / baseV : 0.0; // V_LL drop
      } else {
        dU = (baseV > 0) ? 2 * num / baseV : 0.0; // Loop drop
      }

      double pct = (baseV > 0) ? (dU / baseV) * 100 : 0.0;

      // Amps (Ib)
      // Mono: P / (230 * Cos)
      // Tri: P / (1.732 * 400 * Cos)
      double iDenom =
          _isThreePhase ? (1.732 * 400.0 * cosVal) : (230.0 * cosVal);
      double amps = iDenom > 0 ? p / iDenom : 0.0;

      // Iz Calculation (Rigorous)
      final iz = ElectricalCalculator.calculateIz(
        sectionMm2: s,
        material: ConductorMaterial.copper, // Configurable later
        insulation: _insulation,
        method: _installMethod,
        factors: factors,
      );

      final dropLimit = _selectedType == LoadType.lighting ? 3.0 : 5.0;
      final dropCompliant = pct <= dropLimit;
      final izCompliant = amps <= iz; // Ib <= Iz

      final totalCompliant = dropCompliant && izCompliant;

      final res = _CalcResult(
          section: s,
          dropPercent: pct,
          amps: amps,
          isCompliant: totalCompliant,
          dUVolts: dU,
          iz: iz,
          izCompliant: izCompliant);

      if (_selectedSection != null) return res;

      if (totalCompliant) {
        return res;
      }
      best = res;
    }
    return best!;
  }

  Widget _buildResultsSection(ThemeData theme, AppLocalizations l10n) {
    final res = _calculateValues();

    // Alias for compatibility
    final dropPercent = res.dropPercent;
    final displaySection = res.section;
    final isCompliant = res.isCompliant;
    final iz = res.iz;

    final statusColor = res.isCompliant ? Colors.green : Colors.red;

    final ampsStr = res.amps < 1.0
        ? "${(res.amps * 1000).toStringAsFixed(0)} mA"
        : "${res.amps.toStringAsFixed(1)} A";

    final izStr = "${iz.toStringAsFixed(1)} A";

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Theme.of(context).extension<DiagramTheme>()!.nodeBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: Theme.of(context).extension<DiagramTheme>()!.nodeBorder)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Icon(Icons.bar_chart, color: theme.primaryColor, size: 20),
                SizedBox(width: 8),
                Text(l10n.resultsEstimated,
                    style: TextStyle(
                        color: theme.textTheme.bodyMedium?.color,
                        fontWeight: FontWeight.bold))
              ]),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(isCompliant ? l10n.compliant : l10n.notCompliant,
                    style: TextStyle(
                        color: statusColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold)),
              )
            ],
          ),
          const SizedBox(height: 16),
          // Grid for results
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            spacing: 8,
            children: [
              SizedBox(
                  width: 80,
                  child: _buildResultValue(l10n.propCurrent, ampsStr,
                      theme: theme)),
              SizedBox(
                  width: 80,
                  child: _buildResultValue("Iz (Max)", izStr,
                      color: res.izCompliant ? Colors.green : Colors.red,
                      theme: theme)),
              SizedBox(
                  width: 80,
                  child: _buildResultValue(
                      l10n.propDrop, "${dropPercent.toStringAsFixed(2)} %",
                      color: res.dropPercent <=
                              (_selectedType == LoadType.lighting ? 3 : 5)
                          ? Colors.green
                          : Colors.red,
                      theme: theme)),
              SizedBox(
                  width: 80,
                  child: _buildResultValue(l10n.propSection,
                      "${displaySection.toStringAsFixed(1)} mm²",
                      theme: theme)),
            ],
          )
        ],
      ),
    );
  }
}

class CircuitConfigData {
  final LoadType type;
  final bool isThreePhase;
  final double powerKw;
  final double cosPhi;
  final double lengthMeters;
  final double? sectionMm2;
  // Updates to persistent types
  final InstallationMethod installMethod;
  final CableInsulation insulation;
  final CorrectionFactors? correctionFactors;

  final CatalogMetadata? cableCatalogData;

  CircuitConfigData({
    required this.type,
    required this.isThreePhase,
    required this.powerKw,
    required this.cosPhi,
    required this.lengthMeters,
    this.sectionMm2,
    required this.installMethod,
    required this.insulation,
    this.correctionFactors,
    this.cableCatalogData,
  });
}
