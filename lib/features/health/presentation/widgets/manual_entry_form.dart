import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../diagram/domain/entities/electrical_node.dart';
import '../../../diagram/domain/entities/electrical_enums.dart';
import '../../domain/entities/field_measurement.dart';
import '../../domain/services/electrical_validation_service.dart';

/// Manual measurement entry form for electrical components
class ManualEntryForm extends StatefulWidget {
  final ElectricalNode node;
  final Function(FieldMeasurement) onSave;

  const ManualEntryForm({
    Key? key,
    required this.node,
    required this.onSave,
  }) : super(key: key);

  @override
  State<ManualEntryForm> createState() => _ManualEntryFormState();
}

enum _FormType { source, rcd, insulation, load, panel, generic }

class _ManualEntryFormState extends State<ManualEntryForm> {
  final _uuid = const Uuid();
  final _validationService = ElectricalValidationService();
  late _FormType _currentFormType;
  List<_FormType> _availableTypes = [];

  // Controllers - Source
  final _voltageLNCtrl = TextEditingController();
  final _voltageLLCtrl = TextEditingController();
  final _frequencyCtrl = TextEditingController(text: '50.0');
  final _externalZeCtrl = TextEditingController();

  // Controllers - RCD
  final _tripTimeCtrl = TextEditingController();
  final _tripCurrentCtrl = TextEditingController();
  final _contactUbCtrl = TextEditingController();
  bool _mechTestPassed = false;

  // Controllers - Insulation
  final _insResPhPECtrl = TextEditingController();
  final _insResPhNCtrl = TextEditingController();
  bool _continuityPE = false;

  // Controllers - Load (Zs)
  final _zsCtrl = TextEditingController();
  final _vLoadCtrl = TextEditingController();
  bool _polarityOk = false;

  // Controllers - Panel (Earth)
  final _raCtrl = TextEditingController();

  // Metadata
  final _instrumentCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _determineAvailableTypes();
  }

  void _determineAvailableTypes() {
    widget.node.map(
      source: (_) => _availableTypes = [_FormType.source],
      panel: (_) => _availableTypes = [
        _FormType.panel,
        _FormType.insulation
      ], // Panels can have insulation tests too
      protection: (p) {
        if (p.protectionType == ProtectionType.differential) {
          _availableTypes = [_FormType.rcd];
        } else {
          _availableTypes = [_FormType.generic];
        }
      },
      load: (_) => _availableTypes = [_FormType.load, _FormType.insulation],
    );
    _currentFormType = _availableTypes.first;
  }

  @override
  void dispose() {
    _voltageLNCtrl.dispose();
    _voltageLLCtrl.dispose();
    _frequencyCtrl.dispose();
    _externalZeCtrl.dispose();
    _tripTimeCtrl.dispose();
    _tripCurrentCtrl.dispose();
    _contactUbCtrl.dispose();
    _insResPhPECtrl.dispose();
    _insResPhNCtrl.dispose();
    _zsCtrl.dispose();
    _vLoadCtrl.dispose();
    _raCtrl.dispose();
    _instrumentCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  void _handleSave() {
    FieldMeasurement measurement;
    final commonId = _uuid.v4();
    final commonNodeId = widget.node.id;
    final commonDate = DateTime.now();
    final l10n = AppLocalizations.of(context)!;
    final commonUser = l10n.user;
    final commonNotes = _notesCtrl.text;

    switch (_currentFormType) {
      case _FormType.source:
        measurement = FieldMeasurement.source(
          id: commonId,
          nodeId: commonNodeId,
          measuredAt: commonDate,
          measuredBy: commonUser,
          notes: commonNotes,
          voltageLN: double.tryParse(_voltageLNCtrl.text),
          voltageLL: double.tryParse(_voltageLLCtrl.text),
          frequency: double.tryParse(_frequencyCtrl.text),
          externalZe: double.tryParse(_externalZeCtrl.text),
        );
        break;
      case _FormType.rcd:
        measurement = FieldMeasurement.rcd(
          id: commonId,
          nodeId: commonNodeId,
          measuredAt: commonDate,
          measuredBy: commonUser,
          notes: commonNotes,
          tripTimeMs: double.tryParse(_tripTimeCtrl.text),
          tripCurrentmA: double.tryParse(_tripCurrentCtrl.text),
          contactVoltage: double.tryParse(_contactUbCtrl.text),
          mechanicalTestPassed: _mechTestPassed,
        );
        break;
      case _FormType.insulation:
        measurement = FieldMeasurement.insulation(
          id: commonId,
          nodeId: commonNodeId,
          measuredAt: commonDate,
          measuredBy: commonUser,
          notes: commonNotes,
          resistancePhaseEarth: double.tryParse(_insResPhPECtrl.text),
          resistancePhaseNeutral: double.tryParse(_insResPhNCtrl.text),
          continuityPE: _continuityPE,
        );
        break;
      case _FormType.load:
        measurement = FieldMeasurement.load(
          id: commonId,
          nodeId: commonNodeId,
          measuredAt: commonDate,
          measuredBy: commonUser,
          notes: commonNotes,
          loopImpedanceZs: double.tryParse(_zsCtrl.text),
          voltageAtLoad: double.tryParse(_vLoadCtrl.text),
          polarityOk: _polarityOk,
        );
        break;
      case _FormType.panel:
        measurement = FieldMeasurement.panel(
            id: commonId,
            nodeId: commonNodeId,
            measuredAt: commonDate,
            measuredBy: commonUser,
            notes: commonNotes,
            earthResistanceRa: double.tryParse(_raCtrl.text));
        break;
      case _FormType.generic:
        measurement = FieldMeasurement.generic(
            id: commonId,
            nodeId: commonNodeId,
            measuredAt: commonDate,
            measuredBy: commonUser,
            notes: commonNotes);
        break;
    }

    widget.onSave(measurement);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final bgApp = theme.scaffoldBackgroundColor;
    final bgCard = colorScheme.surfaceContainerHighest;

    final textPrimary = colorScheme.onSurface;
    final textSecondary = colorScheme.onSurfaceVariant;
    final accentColor = theme.primaryColor;

    return Scaffold(
      backgroundColor: bgApp,
      appBar: AppBar(
        backgroundColor: bgApp,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nueva Medición',
                style: TextStyle(fontSize: 16, color: textPrimary)),
            Text(
              "${widget.node.id.substring(0, 4)}... - ${_getNodeTypeLabel()}",
              style: TextStyle(fontSize: 12, color: textSecondary),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: accentColor),
            onPressed: _handleSave,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Type Selector (if multiple available)
            if (_availableTypes.length > 1) ...[
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _availableTypes.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (ctx, index) {
                    final type = _availableTypes[index];
                    final isSelected = type == _currentFormType;
                    return ChoiceChip(
                      label: Text(_getFormTypeLabel(type)),
                      selected: isSelected,
                      onSelected: (val) {
                        if (val) setState(() => _currentFormType = type);
                      },
                      selectedColor: accentColor,
                      backgroundColor: bgCard,
                      labelStyle: TextStyle(
                          color: isSelected ? Colors.white : textSecondary),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Active Form
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildFormBody(
                  bgCard, textPrimary, textSecondary, accentColor),
            ),

            const SizedBox(height: 24),
            // Common Notes
            // Common Notes
            _buildInputCard(
                label: 'Notas Observaciones',
                controller: _notesCtrl,
                suffix: '',
                cardBg: bgCard,
                textMain: textPrimary,
                textSub: textSecondary,
                maxLines: 3,
                allowText: true,
                keyboardType: TextInputType.multiline),
          ],
        ),
      ),
    );
  }

  String _getNodeTypeLabel() {
    return widget.node.map(
      source: (_) => "Acometida/Fuente",
      panel: (_) => "Cuadro",
      protection: (p) => "Protección ${p.protectionType.name}",
      load: (_) => "Circuito/Carga",
    );
  }

  String _getFormTypeLabel(_FormType type) {
    switch (type) {
      case _FormType.source:
        return "Fuente";
      case _FormType.rcd:
        return "Diferencial";
      case _FormType.insulation:
        return "Aislamiento";
      case _FormType.load:
        return "Carga (Zs)";
      case _FormType.panel:
        return "Tierra/Panel";
      case _FormType.generic:
        return "General";
    }
  }

  Widget _buildFormBody(
      Color cardBg, Color textMain, Color textSub, Color accent) {
    switch (_currentFormType) {
      case _FormType.source:
        return _buildSourceForm(cardBg, textMain, textSub);
      case _FormType.rcd:
        return _buildRcdForm(cardBg, textMain, textSub);
      case _FormType.insulation:
        return _buildInsulationForm(cardBg, textMain, textSub);
      case _FormType.load:
        return _buildLoadForm(cardBg, textMain, textSub);
      case _FormType.panel:
        return _buildPanelForm(cardBg, textMain, textSub);
      case _FormType.generic:
        return Center(
            child: Text("Sin formulario específico",
                style: TextStyle(color: textSub)));
    }
  }

  // --- Specific Forms ---

  Widget _buildSourceForm(Color bg, Color txt, Color sub) {
    return Column(
      children: [
        _buildSectionTitle("Parámetros de Acometida", Icons.input, txt),
        _buildInputCard(
            label: "Tensión L-N",
            controller: _voltageLNCtrl,
            suffix: "V",
            cardBg: bg,
            textMain: txt,
            textSub: sub,
            validator: (val) =>
                (double.tryParse(val) ?? 0) < 207 ? "Baja Tensión" : null),
        const SizedBox(height: 12),
        _buildInputCard(
            label: "Frecuencia",
            controller: _frequencyCtrl,
            suffix: "Hz",
            cardBg: bg,
            textMain: txt,
            textSub: sub),
      ],
    );
  }

  Widget _buildRcdForm(Color bg, Color txt, Color sub) {
    final sensitivity = widget.node.maybeMap(
      protection: (p) => p.sensitivity,
      orElse: () => 30.0,
    );

    return Column(
      children: [
        _buildSectionTitle(
            "Prueba Disparo Diferencial", Icons.access_time, txt),
        _buildInputCard(
            label: "Tiempo Disparo",
            controller: _tripTimeCtrl,
            suffix: "ms",
            cardBg: bg,
            textMain: txt,
            textSub: sub,
            validator: (val) {
              final time = double.tryParse(val) ?? 0;
              return _validationService.validateRcdTripTime(time);
            }),
        _buildInputCard(
            label:
                "Corriente Disparo (IΔn: ${sensitivity.toStringAsFixed(0)}mA)",
            controller: _tripCurrentCtrl,
            suffix: "mA",
            cardBg: bg,
            textMain: txt,
            textSub: sub,
            validator: (val) {
              final measured = double.tryParse(val) ?? 0;
              return _validationService.validateRcdTripCurrent(
                tripCurrent: measured,
                sensitivity: sensitivity,
              );
            }),
        _buildInputCard(
          label: "Tensión Contacto (Uc)",
          controller: _contactUbCtrl,
          suffix: "V",
          cardBg: bg,
          textMain: txt,
          textSub: sub,
          validator: (val) {
            final voltage = double.tryParse(val) ?? 0;
            return _validationService.validateContactVoltage(voltage);
          },
        ),
        const SizedBox(height: 12),
        SwitchListTile(
          title: Text("Test Mecánico (Botón T)", style: TextStyle(color: txt)),
          subtitle: Text("¿Dispara al pulsar?", style: TextStyle(color: sub)),
          value: _mechTestPassed,
          onChanged: (v) => setState(() => _mechTestPassed = v),
          activeThumbColor: Colors.green,
          contentPadding: EdgeInsets.zero,
        )
      ],
    );
  }

  Widget _buildInsulationForm(Color bg, Color txt, Color sub) {
    return Column(
      children: [
        _buildSectionTitle("Resistencia Aislamiento", Icons.shield, txt),
        _buildInputCard(
            label: "R (Fase-Tierra)",
            controller: _insResPhPECtrl,
            suffix: "MΩ",
            cardBg: bg,
            textMain: txt,
            textSub: sub,
            validator: (val) =>
                (double.tryParse(val) ?? 100) < 0.5 ? "Fallo <0.5MΩ" : null),
        const SizedBox(height: 12),
        SwitchListTile(
          title: Text("Continuidad PE", style: TextStyle(color: txt)),
          subtitle: Text("¿Tierra continua garantizada?",
              style: TextStyle(color: sub)),
          value: _continuityPE,
          onChanged: (v) => setState(() => _continuityPE = v),
          activeThumbColor: Colors.green,
          contentPadding: EdgeInsets.zero,
        )
      ],
    );
  }

  Widget _buildLoadForm(Color bg, Color txt, Color sub) {
    final loadType = widget.node.maybeMap(
      load: (l) => l.type,
      orElse: () => LoadType.power,
    );

    return Column(
      children: [
        _buildSectionTitle("Impedancia Bucle (Zs)", Icons.loop, txt),
        _buildInputCard(
            label: "Zloop (L-PE)",
            controller: _zsCtrl,
            suffix: "Ω",
            cardBg: bg,
            textMain: txt,
            textSub: sub,
            validator: (val) {
              final zs = double.tryParse(val) ?? 0;
              return _validationService.validateLoopImpedance(zs);
            }),
        const SizedBox(height: 12),
        _buildInputCard(
            label: "Tensión en Carga",
            controller: _vLoadCtrl,
            suffix: "V",
            cardBg: bg,
            textMain: txt,
            textSub: sub,
            validator: (val) {
              final v = double.tryParse(val) ?? 230;
              return _validationService.validateVoltageDrop(
                measuredVoltage: v,
                loadType: loadType,
              );
            }),
        const SizedBox(height: 12),
        SwitchListTile(
          title: Text("Polaridad Correcta", style: TextStyle(color: txt)),
          subtitle: Text("¿Fase en Fase, Neutro en Neutro?",
              style: TextStyle(color: sub)),
          value: _polarityOk,
          onChanged: (v) => setState(() => _polarityOk = v),
          activeThumbColor: Colors.green,
          contentPadding: EdgeInsets.zero,
        )
      ],
    );
  }

  Widget _buildPanelForm(Color bg, Color txt, Color sub) {
    return Column(
      children: [
        _buildSectionTitle("Medición Tierra", Icons.terrain, txt),
        _buildInputCard(
            label: "Resistencia Tierra (Ra)",
            controller: _raCtrl,
            suffix: "Ω",
            cardBg: bg,
            textMain: txt,
            textSub: sub,
            validator: (val) =>
                (double.tryParse(val) ?? 0) > 20 ? "Alta Resistencia" : null),
      ],
    );
  }

  Widget _buildSectionTitle(String title, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(children: [
        Icon(icon, color: Colors.blueAccent, size: 20),
        const SizedBox(width: 8),
        Text(title,
            style: TextStyle(
                color: color, fontSize: 16, fontWeight: FontWeight.bold))
      ]),
    );
  }

  Widget _buildInputCard({
    required String label,
    required TextEditingController controller,
    required String suffix,
    required Color cardBg,
    required Color textMain,
    required Color textSub,
    String? Function(String)? validator,
    int maxLines = 1,
    TextInputType keyboardType =
        const TextInputType.numberWithOptions(decimal: true),
    bool allowText = false,
  }) {
    final val = controller.text;
    String? validationMsg;
    if (validator != null && val.isNotEmpty) {
      validationMsg = validator(val);
    }
    bool isValid = validationMsg == null && val.isNotEmpty;
    bool isError = validationMsg != null;

    final theme = Theme.of(context);
    // Dynamic Border Color based on validation state or theme
    final borderColor = isError
        ? theme.colorScheme.error
        : (isValid ? Colors.green : theme.dividerColor.withValues(alpha: 0.3));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: TextStyle(
                    color: textSub, fontSize: 13, fontWeight: FontWeight.w600)),
            if (isError)
              Text(validationMsg,
                  style: TextStyle(
                      color: theme.colorScheme.error,
                      fontSize: 11,
                      fontWeight: FontWeight.bold)),
            if (isValid && !isError)
              const Text("OK",
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 11,
                      fontWeight: FontWeight.bold))
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: borderColor, width: isError || isValid ? 1.5 : 1.0),
          ),
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            style: TextStyle(
                color: textMain, fontSize: 16, fontWeight: FontWeight.normal),
            keyboardType: keyboardType,
            inputFormatters: [
              if (!allowText)
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              TextInputFormatter.withFunction((oldValue, newValue) {
                final text = newValue.text.replaceAll(',', '.');
                return TextEditingValue(
                  text: text,
                  selection: newValue.selection,
                );
              }),
            ],
            onChanged: (v) {
              setState(() {});
            },
            decoration: InputDecoration(
              filled: false,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: InputBorder.none,
              suffixIcon: suffix.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(suffix,
                              style: TextStyle(
                                  color: textSub.withValues(alpha: 0.7),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ],
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
