import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../config/theme/app_themes.dart';
import '../../domain/entities/electrical_enums.dart';
import '../../domain/entities/catalog_metadata.dart';
import '../../../components/domain/entities/component_template.dart';
import 'cable_catalog_dialog.dart';
import 'dart:math';

class _CalcResult {
  final double section;
  final double dropPercent;
  final double amps;
  final bool isCompliant;
  final double dUVolts;

  _CalcResult({
    required this.section,
    required this.dropPercent,
    required this.amps,
    required this.isCompliant,
    required this.dUVolts,
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
  late String _installMethod;

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
    _installMethod = d?.installMethod ?? "Bajo Tubo (Pared Aislante)";

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

  final List<double> _standardSections = [1.5, 2.5, 4.0, 6.0, 10.0, 16.0, 25.0];

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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("1m",
                                style: TextStyle(
                                    color: theme.disabledColor, fontSize: 10)),
                            Text("100m",
                                style: TextStyle(
                                    color: theme.disabledColor, fontSize: 10)),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 4. Cable Type & Installation
                  _sectionTitle(l10n.cableType, theme),
                  const SizedBox(height: 10),
                  _buildCableSelector(theme),
                  const SizedBox(height: 20),

                  _sectionTitle(l10n.installationMethod, theme),
                  const SizedBox(height: 10),
                  _buildInstallationSelector(theme, l10n),
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
                  widget.onSave(CircuitConfigData(
                      type: _selectedType,
                      isThreePhase: _isThreePhase,
                      powerKw: _powerKw,
                      cosPhi: _cosPhi,
                      lengthMeters: _lengthMeters,
                      sectionMm2: _calculateValues().section,
                      installMethod: _installMethod,
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8)),
            child: Icon(Icons.grid_view, color: accent),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_installMethod,
                    style: TextStyle(
                        color: theme.textTheme.bodyMedium?.color,
                        fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: theme.disabledColor)
        ],
      ),
    );
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
          if (type == LoadType.lighting) {
            _cosPhi = 1.0;
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

      // Amps
      // Mono: P / (230 * Cos)
      // Tri: P / (1.732 * 400 * Cos)
      double iDenom =
          _isThreePhase ? (1.732 * 400.0 * cosVal) : (230.0 * cosVal);
      double amps = iDenom > 0 ? p / iDenom : 0.0;

      final limit = _selectedType == LoadType.lighting ? 3.0 : 5.0;
      final compliant = pct <= limit;

      final res = _CalcResult(
          section: s,
          dropPercent: pct,
          amps: amps,
          isCompliant: compliant,
          dUVolts: dU);

      if (_selectedSection != null) return res;

      if (compliant) {
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

    final statusColor = res.isCompliant ? Colors.green : Colors.red;

    final ampsStr = res.amps < 1.0
        ? "${(res.amps * 1000).toStringAsFixed(0)} mA"
        : "${res.amps.toStringAsFixed(1)} A";

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildResultValue(l10n.propCurrent, ampsStr, theme: theme),
              _buildResultValue(
                  l10n.propDrop, "${dropPercent.toStringAsFixed(2)} %",
                  color: statusColor, theme: theme),
              _buildResultValue(
                  l10n.propSection, "${displaySection.toStringAsFixed(1)} mm²",
                  theme: theme),
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
  final String installMethod;
  final CatalogMetadata? cableCatalogData;

  CircuitConfigData({
    required this.type,
    required this.isThreePhase,
    required this.powerKw,
    required this.cosPhi,
    required this.lengthMeters,
    this.sectionMm2,
    required this.installMethod,
    this.cableCatalogData,
  });
}
