import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:electrician_app/l10n/app_localizations.dart';
import '../../domain/entities/component_template.dart';
import '../../domain/repositories/component_repository.dart';
import '../bloc/component_library_cubit.dart';
import '../widgets/trip_curve_viewer.dart';

class ComponentDetailPage extends StatefulWidget {
  final ComponentTemplate? component;
  final bool isNewComponent;

  const ComponentDetailPage({
    super.key,
    this.component,
    this.isNewComponent = false,
  });

  @override
  State<ComponentDetailPage> createState() => _ComponentDetailPageState();
}

class _ComponentDetailPageState extends State<ComponentDetailPage> {
  final _formKey = GlobalKey<FormState>();

  // Common fields
  late TextEditingController _nameController;
  late TextEditingController _manufacturerController;
  late TextEditingController _seriesController;
  late TextEditingController _priceController;
  late bool _isFavorite;

  // Protection fields
  late TextEditingController _ratedCurrentController;
  late String _curveType;
  late TextEditingController _breakingCapacityController;
  late int _poles;
  late ProtectionDeviceType _deviceType;
  late TextEditingController _sensitivityController;

  // Cable fields
  late TextEditingController _sectionController;
  late CableMaterial _cableMaterial;
  late TextEditingController _insulationTypeController;
  late TextEditingController _maxTempController;
  late TextEditingController _installationMethodController;

  // Source fields
  late TextEditingController _voltageController;
  late TextEditingController _maxIccController;
  late TextEditingController _ratedPowerController;
  late SourceType _sourceType;

  ComponentType? _componentType;

  @override
  void initState() {
    super.initState();

    if (widget.component != null) {
      _initializeFromComponent(widget.component!);
    } else {
      _initializeEmpty();
    }
  }

  void _initializeFromComponent(ComponentTemplate component) {
    _nameController = TextEditingController(text: component.name);
    _manufacturerController =
        TextEditingController(text: component.manufacturer ?? '');
    _seriesController = TextEditingController(text: component.series ?? '');
    _priceController =
        TextEditingController(); // Initialized below based on type
    _isFavorite = component.isFavorite;

    // Initialize ALL controllers to prevent late initialization errors
    // Protection default controllers
    _ratedCurrentController = TextEditingController();
    _curveType = 'C';
    _breakingCapacityController = TextEditingController();
    _poles = 1;
    _deviceType = ProtectionDeviceType.circuitBreaker;
    _sensitivityController = TextEditingController();

    // Cable default controllers
    _sectionController = TextEditingController();
    _cableMaterial = CableMaterial.copper;
    _insulationTypeController = TextEditingController();
    _maxTempController = TextEditingController();
    _installationMethodController = TextEditingController();

    // Source default controllers
    _voltageController = TextEditingController();
    _maxIccController = TextEditingController();
    _ratedPowerController = TextEditingController();
    _sourceType = SourceType.grid;

    // Override with component-specific values
    component.when(
      protection: (id, name, manufacturer, series, isFavorite, ratedCurrent,
          curveType, breakingCapacity, poles, deviceType, sensitivity, price) {
        _componentType = ComponentType.protection;
        _priceController.text = price?.toString() ?? '';
        _ratedCurrentController =
            TextEditingController(text: ratedCurrent.toString());
        _curveType = curveType;
        _breakingCapacityController =
            TextEditingController(text: breakingCapacity.toString());
        _poles = poles;
        _deviceType = deviceType;
        _sensitivityController =
            TextEditingController(text: sensitivity?.toString() ?? '');
      },
      cable: (id, name, manufacturer, series, isFavorite, section, material,
          insulationType, maxOperatingTemp, installationMethod, price) {
        _componentType = ComponentType.cable;
        _priceController.text = price?.toString() ?? '';
        _sectionController = TextEditingController(text: section.toString());
        _cableMaterial = material;
        _insulationTypeController = TextEditingController(text: insulationType);
        _maxTempController =
            TextEditingController(text: maxOperatingTemp.toString());
        _installationMethodController =
            TextEditingController(text: installationMethod ?? '');
      },
      source: (id, name, manufacturer, series, isFavorite, voltage,
          maxShortCircuitCurrent, ratedPower, sourceType, price) {
        _componentType = ComponentType.source;
        _priceController.text = price?.toString() ?? '';
        _voltageController = TextEditingController(text: voltage.toString());
        _maxIccController =
            TextEditingController(text: maxShortCircuitCurrent.toString());
        _ratedPowerController =
            TextEditingController(text: ratedPower?.toString() ?? '');
        _sourceType = sourceType;
      },
    );
  }

  void _initializeEmpty() {
    _nameController = TextEditingController();
    _manufacturerController = TextEditingController();
    _manufacturerController = TextEditingController();
    _seriesController = TextEditingController();
    _priceController = TextEditingController();
    _isFavorite = false;

    // Default to protection
    _componentType = ComponentType.protection;
    _ratedCurrentController = TextEditingController();
    _curveType = 'C';
    _breakingCapacityController = TextEditingController();
    _poles = 1;
    _deviceType = ProtectionDeviceType.circuitBreaker;
    _sensitivityController = TextEditingController();

    // Initialize cable controllers to avoid dispose errors
    _sectionController = TextEditingController();
    _cableMaterial = CableMaterial.copper;
    _insulationTypeController = TextEditingController();
    _maxTempController = TextEditingController();
    _installationMethodController = TextEditingController();

    // Initialize source controllers to avoid dispose errors
    _voltageController = TextEditingController();
    _maxIccController = TextEditingController();
    _ratedPowerController = TextEditingController();
    _sourceType = SourceType.grid;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _manufacturerController.dispose();
    _seriesController.dispose();
    _priceController.dispose();
    _ratedCurrentController.dispose();
    _breakingCapacityController.dispose();
    _sensitivityController.dispose();
    _sectionController.dispose();
    _insulationTypeController.dispose();
    _maxTempController.dispose();
    _installationMethodController.dispose();
    _voltageController.dispose();
    _maxIccController.dispose();
    _ratedPowerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isNewComponent
            ? AppLocalizations.of(context)!.newComponent
            : widget.component?.name ??
                AppLocalizations.of(context)!.componentDetail),
        actions: [
          if (!widget.isNewComponent)
            IconButton(
              icon: Icon(_isFavorite ? Icons.star : Icons.star_border,
                  color: _isFavorite ? Colors.amber : null),
              onPressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
            ),
          if (!widget.isNewComponent)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: _confirmDelete,
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Trip Curve Viewer (only for protection)
              if (_componentType == ComponentType.protection &&
                  !widget.isNewComponent)
                _buildTripCurveSection(),

              const SizedBox(height: 24),

              // Component Type Selector (only for new components)
              if (widget.isNewComponent) _buildTypeSelector(),

              const SizedBox(height: 16),

              // Common Fields
              _buildCommonFields(),

              const SizedBox(height: 24),

              // Type-specific fields
              if (_componentType == ComponentType.protection)
                _buildProtectionFields(),
              if (_componentType == ComponentType.cable) _buildCableFields(),
              if (_componentType == ComponentType.source) _buildSourceFields(),

              const SizedBox(height: 32),

              // Save button
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _saveComponent,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save,
                          color: Theme.of(context).colorScheme.onPrimary),
                      const SizedBox(width: 8),
                      Text(
                        AppLocalizations.of(context)!.saveComponent,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTripCurveSection() {
    final protection = widget.component as ProtectionTemplate;
    return TripCurveViewer(
      protection: ProtectionTemplate(
        id: protection.id,
        name: _nameController.text,
        manufacturer: _manufacturerController.text.isEmpty
            ? null
            : _manufacturerController.text,
        series: _seriesController.text.isEmpty ? null : _seriesController.text,
        isFavorite: _isFavorite,
        ratedCurrent: double.tryParse(_ratedCurrentController.text) ?? 16,
        curveType: _curveType,
        breakingCapacity:
            double.tryParse(_breakingCapacityController.text) ?? 6,
        poles: _poles,
        deviceType: _deviceType,
        sensitivity: _sensitivityController.text.isEmpty
            ? null
            : double.tryParse(_sensitivityController.text),
      ),
      height: 350,
    );
  }

  Widget _buildTypeSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.componentType,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildTypeChip(
                  context,
                  AppLocalizations.of(context)!.filterProtection,
                  Icons.shield,
                  ComponentType.protection,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTypeChip(
                  context,
                  AppLocalizations.of(context)!.filterCable,
                  Icons.cable,
                  ComponentType.cable,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTypeChip(
                  context,
                  AppLocalizations.of(context)!.filterSource,
                  Icons.power,
                  ComponentType.source,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTypeChip(
      BuildContext context, String label, IconData icon, ComponentType type) {
    final isSelected = _componentType == type;
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        setState(() {
          _componentType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outlineVariant,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(icon,
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.primary),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceTypeChip(BuildContext context, String label, IconData icon,
      ProtectionDeviceType type) {
    final isSelected = _deviceType == type;
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        setState(() {
          _deviceType = type;
          // Set default curve based on new type
          if (type == ProtectionDeviceType.fuse) {
            _curveType = 'gG';
          } else {
            _curveType = 'C';
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outlineVariant,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(icon,
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.primary),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommonFields() {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.generalInfo,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _nameController,
            decoration: _buildInputDecoration(
              '${AppLocalizations.of(context)!.fullName} *',
              hint: 'Ej: Magnetotérmico 16A Curva C',
            ),
            validator: (value) => value?.isEmpty ?? true
                ? AppLocalizations.of(context)!.fieldRequired
                : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _manufacturerController,
            decoration: _buildInputDecoration(
              AppLocalizations.of(context)!.manufacturer,
              hint: 'Ej: Schneider Electric',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _seriesController,
            decoration: _buildInputDecoration(
              AppLocalizations.of(context)!.series,
              hint: 'Ej: iC60N',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _priceController,
            decoration: _buildInputDecoration(
              AppLocalizations.of(context)!.price,
              hint: 'Ej: 15.50',
              suffix: '€',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (value) {
              if (value == null || value.isEmpty) return null; // Optional
              if (double.tryParse(value) == null) {
                return AppLocalizations.of(context)!.invalidNumber;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProtectionFields() {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.protectionSpecs,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 16),
          // Device Type Selector (Chips)
          Row(
            children: [
              Expanded(
                child: _buildDeviceTypeChip(
                  context,
                  AppLocalizations.of(context)!.deviceTypeCircuitBreaker,
                  Icons.toggle_off,
                  ProtectionDeviceType.circuitBreaker,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDeviceTypeChip(
                  context,
                  AppLocalizations.of(context)!.deviceTypeFuse,
                  Icons.battery_std,
                  ProtectionDeviceType.fuse,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDeviceTypeChip(
                  context,
                  AppLocalizations.of(context)!.differential,
                  Icons.settings_input_component,
                  ProtectionDeviceType.differential,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _ratedCurrentController,
                  decoration: _buildInputDecoration(
                    '${AppLocalizations.of(context)!.ratedCurrent} *',
                    hint: '16',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => double.tryParse(value ?? '') == null
                      ? AppLocalizations.of(context)!.invalidNumber
                      : null,
                  onChanged: (_) => setState(() {}), // Refresh trip curve
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Builder(
                  builder: (context) {
                    // Determine available curves based on device type
                    List<String> validCurves;
                    if (_deviceType == ProtectionDeviceType.fuse) {
                      validCurves = ['gG', 'aM'];
                    } else if (_deviceType ==
                        ProtectionDeviceType.differential) {
                      validCurves = ['AC', 'A', 'F', 'B'];
                    } else {
                      // Circuit Breaker (Standard curves + others found in data)
                      validCurves = ['B', 'C', 'D', 'K', 'Z', 'MA'];
                    }

                    // Safety check: ensure current _curveType is in list
                    // If not, we might be viewing a specialized component or a Differential treated as Breaker
                    // We allow the current value to appear in the list to prevent crash
                    if (!validCurves.contains(_curveType) &&
                        _curveType.isNotEmpty) {
                      validCurves.add(_curveType);
                    }
                    // If empty/null (shouldn't be per logic), default to first
                    if (!validCurves.contains(_curveType) &&
                        validCurves.isNotEmpty) {
                      // We can't easily setState here during build, so this is a preventive fallback for the UI list
                      // Ideally we'd fix state in initState, but for now allow the dropdown to render
                      // by defaulting to 'C' or first item if not found?
                      // Actually, DropdownButton fails if value is not in items.
                      // So adding it above handles the "value not in items" crash.
                    }

                    return DropdownButtonFormField<String>(
                      initialValue:
                          validCurves.contains(_curveType) ? _curveType : null,
                      decoration: _buildInputDecoration(
                          '${AppLocalizations.of(context)!.curve} *'),
                      items: validCurves
                          .map(
                              (c) => DropdownMenuItem(value: c, child: Text(c)))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _curveType = value;
                          });
                        }
                      },
                      // Prevent crash if value is null
                      hint: validCurves.contains(_curveType)
                          ? null
                          : Text(_curveType),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _breakingCapacityController,
                  decoration: _buildInputDecoration(
                    '${AppLocalizations.of(context)!.breakingCapacity} *',
                    hint: '6',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => double.tryParse(value ?? '') == null
                      ? AppLocalizations.of(context)!.invalidNumber
                      : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<int>(
                  initialValue: _poles,
                  decoration: _buildInputDecoration(
                      '${AppLocalizations.of(context)!.poles} *'),
                  items: [1, 2, 3, 4]
                      .map((p) =>
                          DropdownMenuItem(value: p, child: Text('${p}P')))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _poles = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCableFields() {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.cableSpecs,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _sectionController,
                  decoration: _buildInputDecoration(
                    '${AppLocalizations.of(context)!.section} *',
                    hint: '2.5',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => double.tryParse(value ?? '') == null
                      ? AppLocalizations.of(context)!.invalidNumber
                      : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<CableMaterial>(
                  initialValue: _cableMaterial,
                  decoration: _buildInputDecoration(
                      '${AppLocalizations.of(context)!.material} *'),
                  items: CableMaterial.values
                      .map((m) => DropdownMenuItem(
                            value: m,
                            child: Text(m == CableMaterial.copper
                                ? AppLocalizations.of(context)!
                                    .cableMaterialCopper
                                : AppLocalizations.of(context)!
                                    .cableMaterialAluminum),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _cableMaterial = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _insulationTypeController,
                  decoration: _buildInputDecoration(
                    '${AppLocalizations.of(context)!.insulation} *',
                    hint: 'PVC, XLPE, EPR',
                  ),
                  validator: (value) => value?.isEmpty ?? true
                      ? AppLocalizations.of(context)!.fieldRequired
                      : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _maxTempController,
                  decoration: _buildInputDecoration(
                    '${AppLocalizations.of(context)!.maxTemp} *',
                    hint: '70',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => double.tryParse(value ?? '') == null
                      ? AppLocalizations.of(context)!.invalidNumber
                      : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _installationMethodController,
            decoration: _buildInputDecoration(
              AppLocalizations.of(context)!.installMethod,
              hint: 'B1, B2, C, D, E, F, G',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceFields() {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.sourceSpecs,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _voltageController,
                  decoration: _buildInputDecoration(
                    '${AppLocalizations.of(context)!.voltage} *',
                    hint: '230',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => double.tryParse(value ?? '') == null
                      ? AppLocalizations.of(context)!.invalidNumber
                      : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextFormField(
                  controller: _maxIccController,
                  decoration: _buildInputDecoration(
                    '${AppLocalizations.of(context)!.maxIcc} *',
                    hint: '6000',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => double.tryParse(value ?? '') == null
                      ? AppLocalizations.of(context)!.invalidNumber
                      : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _ratedPowerController,
                  decoration: _buildInputDecoration(
                    '${AppLocalizations.of(context)!.power} *',
                    hint: '5750',
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<SourceType>(
                  initialValue: _sourceType,
                  decoration: _buildInputDecoration(
                      '${AppLocalizations.of(context)!.type} *'),
                  items: SourceType.values
                      .map((t) => DropdownMenuItem(
                            value: t,
                            child: Text(_getSourceTypeName(t)),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _sourceType = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getSourceTypeName(SourceType type) {
    switch (type) {
      case SourceType.grid:
        return 'Red';
      case SourceType.transformer:
        return 'Transformador';
      case SourceType.generator:
        return 'Generador';
      case SourceType.ups:
        return 'SAI/UPS';
    }
  }

  InputDecoration _buildInputDecoration(String label,
      {String? hint, String? suffix}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
      ),
      hintText: hint,
      hintStyle: TextStyle(
        color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
      ),
      suffixText: suffix,
      suffixStyle: TextStyle(
        color: theme.textTheme.bodyMedium?.color,
      ),
      filled: true,
      fillColor: theme.colorScheme.surface, // Use surface for better contrast
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colorScheme.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
    );
  }

  void _saveComponent() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final id = widget.component?.id ?? const Uuid().v4();

    ComponentTemplate component;

    switch (_componentType!) {
      case ComponentType.protection:
        component = ComponentTemplate.protection(
          id: id,
          name: _nameController.text,
          manufacturer: _manufacturerController.text.isEmpty
              ? null
              : _manufacturerController.text,
          series:
              _seriesController.text.isEmpty ? null : _seriesController.text,
          isFavorite: _isFavorite,
          ratedCurrent: double.parse(_ratedCurrentController.text),
          curveType: _curveType,
          breakingCapacity: double.parse(_breakingCapacityController.text),
          poles: _poles,
          deviceType: _deviceType,
          sensitivity: _sensitivityController.text.isEmpty
              ? null
              : double.parse(_sensitivityController.text),
          price: double.tryParse(_priceController.text),
        );
        break;
      case ComponentType.cable:
        component = ComponentTemplate.cable(
          id: id,
          name: _nameController.text,
          manufacturer: _manufacturerController.text.isEmpty
              ? null
              : _manufacturerController.text,
          series:
              _seriesController.text.isEmpty ? null : _seriesController.text,
          isFavorite: _isFavorite,
          section: double.parse(_sectionController.text),
          material: _cableMaterial,
          insulationType: _insulationTypeController.text,
          maxOperatingTemp: double.parse(_maxTempController.text),
          installationMethod: _installationMethodController.text.isEmpty
              ? null
              : _installationMethodController.text,
          price: double.tryParse(_priceController.text),
        );
        break;
      case ComponentType.source:
        component = ComponentTemplate.source(
          id: id,
          name: _nameController.text,
          manufacturer: _manufacturerController.text.isEmpty
              ? null
              : _manufacturerController.text,
          series:
              _seriesController.text.isEmpty ? null : _seriesController.text,
          isFavorite: _isFavorite,
          voltage: double.parse(_voltageController.text),
          maxShortCircuitCurrent: double.parse(_maxIccController.text),
          ratedPower: _ratedPowerController.text.isEmpty
              ? null
              : double.parse(_ratedPowerController.text),
          sourceType: _sourceType,
          price: double.tryParse(_priceController.text),
        );
        break;
    }

    context.read<ComponentLibraryCubit>().saveComponent(component);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Componente guardado correctamente')),
    );

    Navigator.of(context).pop();
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Componente'),
        content:
            const Text('¿Estás seguro de que deseas eliminar este componente?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              context
                  .read<ComponentLibraryCubit>()
                  .deleteComponent(widget.component!.id);
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Close detail page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Componente eliminado')),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}
