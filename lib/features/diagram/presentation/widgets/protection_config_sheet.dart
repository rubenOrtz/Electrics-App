import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../injection_container.dart';
import '../../../../config/theme/app_themes.dart';
import '../../domain/entities/electrical_enums.dart';
import '../../domain/entities/cable_definition.dart';
import '../../domain/entities/protection_definition.dart';
import '../../domain/entities/catalog_metadata.dart';
import '../../data/data_sources/protection_presets_data_source.dart';
import '../../../components/domain/entities/component_template.dart';
import 'protection_catalog_dialog.dart';
import 'cable_catalog_dialog.dart';

class ProtectionConfigSheet extends StatefulWidget {
  final Function(ProtectionConfigData) onSave;
  final VoidCallback? onCancel;
  final ProtectionConfigData? initialData;

  const ProtectionConfigSheet({
    Key? key,
    required this.onSave,
    this.onCancel,
    this.initialData,
  }) : super(key: key);

  @override
  State<ProtectionConfigSheet> createState() => _ProtectionConfigSheetState();
}

class _ProtectionConfigSheetState extends State<ProtectionConfigSheet> {
  // Config State
  late ProtectionType _type;
  late double _rating; // Amps
  late int _poles;
  late String _curve;
  late double _sensitivity; // mA
  late double _pancoupe; // Poder de Corte (kA)

  // Cable State (Input)
  late double? _cableSection;
  late TextEditingController _cableSectionController;

  // Unit Toggles
  bool _sensitivityUnitIsA = false; // false = mA, true = A
  bool _pancoupeUnitIsA = false; // false = kA, true = A

  // Mode & Preset
  bool _isAdvancedMode = false;
  ProtectionDefinition? _selectedPreset;

  // Catalog Metadata (Digital Twin)
  CatalogMetadata? _catalogData;
  CatalogMetadata? _cableCatalogData;

  final List<String> _curves = ["A", "B", "C", "D", "K", "Z", "MA"];

  // Cache data ONCE to prevent repeated JSON parsing
  late List<ProtectionDefinition> _availablePresets;

  @override
  void initState() {
    super.initState();
    final d = widget.initialData;
    _type = d?.type ?? ProtectionType.circuitBreaker;
    _rating = d?.ratingAmps ?? 16.0;
    _poles = d?.poles ?? 2;
    _curve = (d?.curve != null && _curves.contains(d!.curve)) ? d.curve : "C";
    _sensitivity = d?.sensitivityMa ?? 30.0;
    _pancoupe = d?.breakingCapacityKa ?? 6.0;
    _cableSection = d?.inputCableSection;

    // Load and cache presets data ONCE
    _availablePresets = sl<ProtectionPresetsDataSource>().getProtections();

    // Restore catalog metadata
    _catalogData = d?.catalogData;
    _cableCatalogData = d?.cableCatalogData;

    // Initialize cable section controller
    _cableSectionController = TextEditingController(
      text: _cableSection?.toStringAsFixed(1) ?? "2.5",
    );

    // Match preset
    if (d == null) {
      _selectedPreset = _availablePresets.length > 1
          ? _availablePresets[1]
          : _availablePresets.first;
      _applyPreset(_selectedPreset!);
    } else {
      try {
        _selectedPreset = _availablePresets.firstWhere((p) =>
            p.type == _type &&
            p.ratingAmps == _rating &&
            p.curve == _curve &&
            p.sensitivityMa == _sensitivity);
      } catch (e) {
        _selectedPreset = null;
      }
      _isAdvancedMode = _selectedPreset == null;
    }
  }

  @override
  void dispose() {
    _cableSectionController.dispose();
    super.dispose();
  }

  void _applyPreset(ProtectionDefinition preset) {
    setState(() {
      _selectedPreset = preset;
      _type = preset.type;
      _rating = preset.ratingAmps;
      _poles = preset.poles;
      _curve = _curves.contains(preset.curve) ? preset.curve : "C";
      _sensitivity = preset.sensitivityMa;
      _pancoupe = preset.breakingCapacityKa;
      _catalogData = null;

      if (preset.defaultCableSection != null && !_isCableLocked) {
        _cableSection = preset.defaultCableSection;
        _cableSectionController.text =
            preset.defaultCableSection!.toStringAsFixed(1);
      }
    });
  }

  bool get _isLocked => _catalogData != null;
  bool get _isCableLocked => _cableCatalogData != null;

  @override
  Widget build(BuildContext context) {
    // Theme aware colors
    final theme = Theme.of(context);
    final diagramTheme = theme.extension<DiagramTheme>()!;
    final l10n = AppLocalizations.of(context)!;

    final bg = diagramTheme.panelBg;
    final cardBg = diagramTheme.nodeBg;
    final accent = diagramTheme.accentColor;
    final borderColor = diagramTheme.nodeBorder;

    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
      clipBehavior: Clip.antiAlias,
      padding:
          EdgeInsets.only(bottom: keyboardHeight, left: 24, right: 24, top: 24),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.configProtection,
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w900, fontSize: 24)),
              TextButton(
                  onPressed: widget.onCancel,
                  child: Text(l10n.cancel,
                      style: TextStyle(color: theme.disabledColor)))
            ],
          ),
          const SizedBox(height: 20),

          // Mode Toggle
          _buildModeToggle(theme, l10n),
          const SizedBox(height: 20),

          // Product Banner (if linked to catalog)
          if (_catalogData != null) _buildProductBanner(theme),
          if (_catalogData != null) const SizedBox(height: 20),

          // Quick Mode: Preset + Cable
          if (!_isAdvancedMode) ...[
            if (!_isLocked) ...[
              _sectionTitle(l10n.presetProtection, theme),
              const SizedBox(height: 10),
              _buildPresetSelector(theme),
              const SizedBox(height: 12),
              _buildLibraryButtonPlaceholder(theme),
              const SizedBox(height: 20),
            ],
            _sectionTitle(l10n.inputCable, theme),
            const SizedBox(height: 10),
            _buildCableSelector(theme),
          ],

          // Advanced Mode: All Fields
          if (_isAdvancedMode) ...[
            _sectionTitle(l10n.componentType, theme),
            const SizedBox(height: 10),
            Row(
              children: [
                _buildTypeChip(
                    l10n.switchType,
                    Icons.toggle_on,
                    ProtectionType.circuitBreaker,
                    _type == ProtectionType.circuitBreaker,
                    theme),
                const SizedBox(width: 8),
                _buildTypeChip(
                    l10n.elemDifferential,
                    Icons.health_and_safety,
                    ProtectionType.differential,
                    _type == ProtectionType.differential,
                    theme),
                const SizedBox(width: 8),
                _buildTypeChip(l10n.fuseType, Icons.flash_on,
                    ProtectionType.fuse, _type == ProtectionType.fuse, theme),
              ],
            ),
            const SizedBox(height: 20),

            // Rating & Poles
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle(l10n.calibre, theme),
                      const SizedBox(height: 8),
                      _buildEditableInput(
                        "",
                        _rating.toStringAsFixed(1),
                        (v) {
                          final normalized = v.replaceAll(',', '.');
                          setState(() =>
                              _rating = double.tryParse(normalized) ?? _rating);
                        },
                        theme,
                        suffix: "A",
                        lockable: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle(l10n.poles, theme),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                            color: cardBg,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: borderColor)),
                        child: Row(
                          children: [
                            _buildToggleOption("2P", _poles == 2,
                                () => setState(() => _poles = 2), theme),
                            _buildToggleOption("4P", _poles == 4,
                                () => setState(() => _poles = 4), theme),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Specific Properties
            if (_type == ProtectionType.circuitBreaker) ...[
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle(l10n.curveLabel, theme),
                        const SizedBox(height: 8),
                        _buildDropdown<String>(
                          value: _curve,
                          items: _curves,
                          labelBuilder: (v) => "${l10n.curveLabel} $v",
                          theme: theme,
                          onChanged: _isLocked
                              ? null
                              : (v) => setState(() => _curve = v!),
                          isLocked: _isLocked,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle(l10n.breakingCapacity, theme),
                        const SizedBox(height: 8),
                        _buildEditableInput(
                            "",
                            _pancoupeUnitIsA
                                ? (_pancoupe * 1000).toStringAsFixed(0)
                                : _pancoupe.toStringAsFixed(1), (v) {
                          final normalized = v.replaceAll(',', '.');
                          setState(() {
                            final val = double.tryParse(normalized) ?? 0.0;
                            _pancoupe = _pancoupeUnitIsA ? val / 1000 : val;
                          });
                        }, theme,
                            lockable: true,
                            suffixWidget: _buildUnitToggle(
                                "kA",
                                "A",
                                _pancoupeUnitIsA,
                                () => setState(
                                    () => _pancoupeUnitIsA = !_pancoupeUnitIsA),
                                theme)),
                      ],
                    ),
                  ),
                ],
              ),
            ] else if (_type == ProtectionType.differential) ...[
              _sectionTitle(l10n.sensitivityLabel, theme),
              const SizedBox(height: 8),
              _buildEditableInput(
                  "",
                  _sensitivityUnitIsA
                      ? (_sensitivity / 1000).toStringAsFixed(3)
                      : _sensitivity.toStringAsFixed(0), (v) {
                final normalized = v.replaceAll(',', '.');
                setState(() {
                  final val = double.tryParse(normalized) ?? 0.0;
                  _sensitivity = _sensitivityUnitIsA ? val * 1000 : val;
                });
              }, theme,
                  suffixWidget: _buildUnitToggle(
                      "mA",
                      "A",
                      _sensitivityUnitIsA,
                      () => setState(
                          () => _sensitivityUnitIsA = !_sensitivityUnitIsA),
                      theme)),
              const SizedBox(height: 8),
              _buildInfoCard(l10n.standardHousing, theme),
            ],

            const SizedBox(height: 20),
            _sectionTitle(l10n.inputCable, theme),
            const SizedBox(height: 10),
            _buildCableSelector(theme),
          ],

          const SizedBox(height: 30),

          // Save Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: accent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                onPressed: () {
                  widget.onSave(ProtectionConfigData(
                    type: _type,
                    ratingAmps: _rating,
                    poles: _poles,
                    curve: _curve,
                    sensitivityMa: _sensitivity,
                    breakingCapacityKa: _pancoupe,
                    inputCableSection: _cableSection,
                    catalogData: _catalogData,
                    cableCatalogData: _cableCatalogData,
                  ));
                },
                icon: const Icon(Icons.verified_user, color: Colors.white),
                label: Text(l10n.saveProtection,
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

  Widget _sectionTitle(String text, ThemeData theme) {
    return Text(text,
        style: TextStyle(
            color: theme.textTheme.bodyMedium?.color,
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5));
  }

  Widget _buildTypeChip(String label, IconData icon, ProtectionType type,
      bool isSelected, ThemeData theme) {
    final diagramTheme = theme.extension<DiagramTheme>()!;
    final activeColor = diagramTheme.accentColor;
    final borderColor = diagramTheme.nodeBorder;
    final cardBg = diagramTheme.nodeBg;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _type = type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? activeColor : cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? activeColor : borderColor),
          ),
          child: Column(
            children: [
              Icon(icon,
                  size: 28,
                  color: isSelected ? Colors.white : theme.disabledColor),
              const SizedBox(height: 6),
              Text(label,
                  style: TextStyle(
                      color: isSelected ? Colors.white : theme.disabledColor,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required T value,
    required List<T> items,
    required String Function(T) labelBuilder,
    required void Function(T?)? onChanged,
    required ThemeData theme,
    bool isLocked = false,
  }) {
    final diagramTheme = theme.extension<DiagramTheme>()!;
    final cardBg = diagramTheme.nodeBg;
    final borderColor = diagramTheme.nodeBorder;

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: isLocked ? cardBg.withValues(alpha: 0.5) : cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton<T>(
              value: value,
              items: items
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(labelBuilder(item)),
                      ))
                  .toList(),
              onChanged: onChanged,
              isExpanded: true,
              underline: const SizedBox.shrink(),
              dropdownColor: theme.cardColor,
              style: TextStyle(
                  color: isLocked
                      ? theme.disabledColor
                      : theme.textTheme.bodyMedium?.color,
                  fontSize: 15),
            ),
          ),
          if (isLocked) const Icon(Icons.lock, size: 16, color: Colors.orange),
        ],
      ),
    );
  }

  Widget _buildToggleOption(
      String text, bool isActive, VoidCallback onTap, ThemeData theme) {
    final diagramTheme = theme.extension<DiagramTheme>()!;
    final activeColor = diagramTheme.accentColor;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isActive
                ? activeColor.withValues(alpha: 0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isActive ? Border.all(color: activeColor) : null,
          ),
          child: Center(
            child: Text(text,
                style: TextStyle(
                    color: isActive ? activeColor : theme.disabledColor,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  Widget _buildModeToggle(ThemeData theme, AppLocalizations l10n) {
    final diagramTheme = theme.extension<DiagramTheme>()!;
    final activeColor = diagramTheme.accentColor;
    final cardBg = diagramTheme.nodeBg;
    final borderColor = diagramTheme.nodeBorder;

    return Container(
      decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor)),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isAdvancedMode = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: !_isAdvancedMode
                      ? activeColor.withValues(alpha: 0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border:
                      !_isAdvancedMode ? Border.all(color: activeColor) : null,
                ),
                child: Center(
                  child: Text(l10n.presetDefault,
                      style: TextStyle(
                          color: !_isAdvancedMode
                              ? activeColor
                              : theme.disabledColor,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _isAdvancedMode = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: _isAdvancedMode
                      ? activeColor.withValues(alpha: 0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border:
                      _isAdvancedMode ? Border.all(color: activeColor) : null,
                ),
                child: Center(
                  child: Text(l10n.presetCustom,
                      style: TextStyle(
                          color: _isAdvancedMode
                              ? activeColor
                              : theme.disabledColor,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPresetSelector(ThemeData theme) {
    final diagramTheme = theme.extension<DiagramTheme>()!;
    final cardBg = diagramTheme.nodeBg;
    final borderColor = diagramTheme.nodeBorder;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ProtectionDefinition>(
          dropdownColor: theme.cardColor,
          value: _selectedPreset,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down, color: theme.primaryColor),
          items: _availablePresets.map((preset) {
            return DropdownMenuItem(
              value: preset,
              child: Text(preset.name,
                  style: TextStyle(
                      color: theme.textTheme.bodyMedium?.color,
                      fontWeight: FontWeight.bold)),
            );
          }).toList(),
          onChanged: (v) {
            if (v != null) _applyPreset(v);
          },
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
      bool lockable = false,
      TextEditingController? controller}) {
    final isLocked = lockable && _isLocked;
    final diagramTheme = theme.extension<DiagramTheme>()!;
    final cardBg = diagramTheme.nodeBg;
    final borderColor = diagramTheme.nodeBorder;

    return Container(
      padding: EdgeInsets.all(transparent ? 0 : 12),
      decoration: BoxDecoration(
        color: transparent
            ? Colors.transparent
            : isLocked
                ? cardBg.withValues(alpha: 0.5)
                : cardBg,
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
                  enabled: !isLocked,
                  key: ValueKey(value),
                  initialValue: controller != null ? null : value,
                  cursorColor: theme.primaryColor,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  textAlign: alignRight ? TextAlign.end : TextAlign.start,
                  style: TextStyle(
                      color: isLocked
                          ? theme.disabledColor
                          : theme.textTheme.bodyMedium?.color,
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
                    disabledBorder: InputBorder.none,
                  ),
                  onChanged: onChanged,
                ),
              ),
              if (isLocked)
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(Icons.lock, size: 16, color: Colors.orange),
                )
              else if (suffixWidget != null)
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

  Widget _buildUnitToggle(String unit1, String unit2, bool isUnit2,
      VoidCallback onTap, ThemeData theme) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: theme.primaryColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          isUnit2 ? unit2 : unit1,
          style: TextStyle(
              color: theme.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String info, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: theme.primaryColor, size: 20),
          const SizedBox(width: 10),
          Text(info, style: TextStyle(color: theme.primaryColor)),
        ],
      ),
    );
  }

  Widget _buildProductBanner(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.link, color: Colors.amber, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text("Producto Vinculado",
                    style: TextStyle(
                        color: Colors.amber, fontWeight: FontWeight.bold)),
              ),
              GestureDetector(
                onTap: _unlinkProductData,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(Icons.close, size: 16, color: Colors.amber),
                ),
              )
            ],
          ),
          if (_catalogData != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 24),
              child: Text(
                "${_catalogData!.brand} - ${_catalogData!.reference ?? _catalogData!.displayName}",
                style: TextStyle(color: theme.disabledColor, fontSize: 11),
              ),
            ),
        ],
      ),
    );
  }

  void _unlinkProductData() {
    setState(() {
      _catalogData = null;
    });
  }

  Future<void> _openCatalog() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => ProtectionCatalogDialog(
        initialType: _type == ProtectionType.circuitBreaker
            ? ProtectionDeviceType.circuitBreaker
            : _type == ProtectionType.differential
                ? ProtectionDeviceType.differential
                : ProtectionDeviceType.fuse,
      ),
    );

    if (result != null) {
      final metadata = result['metadata'] as CatalogMetadata;
      final product = result['product'] as ProtectionTemplate;

      setState(() {
        _catalogData = metadata;

        // Parse and apply product specifications
        _rating = product.ratedCurrent;
        _curve = product.curveType;
        _poles = product.poles;
        _pancoupe = product.breakingCapacity;

        // If it's a differential, apply sensitivity
        if (product.sensitivity != null) {
          _sensitivity = product.sensitivity!;
        }
      });
    }
  }

  Widget _buildLibraryButtonPlaceholder(ThemeData theme) {
    final diagramTheme = theme.extension<DiagramTheme>()!;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border:
            Border.all(color: diagramTheme.accentColor.withValues(alpha: 0.3)),
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
          onPressed: _openCatalog,
          icon: Icon(Icons.library_books, color: diagramTheme.accentColor),
          label: Text("Abrir Librería",
              style: TextStyle(
                  color: diagramTheme.accentColor,
                  fontWeight: FontWeight.w600))),
    );
  }

  void _unlinkCableData() {
    setState(() {
      _cableCatalogData = null;
    });
  }

  Widget _buildCableSelector(ThemeData theme) {
    final diagramTheme = theme.extension<DiagramTheme>()!;
    final activeColor = diagramTheme.accentColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_cableCatalogData != null)
          Container(
            margin: const EdgeInsets.only(bottom: 12),
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
        _cableSection = cable.section;
      });
    }
  }
}

class ProtectionConfigData {
  final ProtectionType type;
  final double ratingAmps;
  final int poles;
  final String curve;
  final double sensitivityMa;
  final double breakingCapacityKa;
  final double? inputCableSection;
  final CableDefinition? cable;
  final CatalogMetadata? catalogData;
  final CatalogMetadata? cableCatalogData;

  ProtectionConfigData({
    required this.type,
    required this.ratingAmps,
    required this.poles,
    required this.curve,
    required this.sensitivityMa,
    required this.breakingCapacityKa,
    this.inputCableSection,
    this.cable,
    this.catalogData,
    this.cableCatalogData,
  });
}
