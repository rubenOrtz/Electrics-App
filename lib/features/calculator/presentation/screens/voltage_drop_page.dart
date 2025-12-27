import 'package:flutter/material.dart';

import '../../domain/entities/conductor.dart';
import '../../domain/usecases/electrical_math.dart';
import 'package:electrician_app/l10n/app_localizations.dart';

class VoltageDropPage extends StatefulWidget {
  const VoltageDropPage({super.key});

  @override
  State<VoltageDropPage> createState() => _VoltageDropPageState();
}

class _VoltageDropPageState extends State<VoltageDropPage> {
  // Input Controllers
  final _powerController = TextEditingController();
  final _lengthController = TextEditingController();
  final _voltageController = TextEditingController(text: '400');

  // State Variables
  VoltageSystem _system = VoltageSystem.threePhase;
  ConductorMaterial _material = ConductorMaterial.copper;
  double _section = 6.0;

  // Results
  double? _resultVolts;
  double? _resultPercentage;

  final List<double> _standardSections = [
    1.5,
    2.5,
    4,
    6,
    10,
    16,
    25,
    35,
    50,
    70,
    95,
    120,
    150,
    185,
    240
  ];

  void _calculate() {
    final powerKw = double.tryParse(_powerController.text);
    final length = double.tryParse(_lengthController.text);
    final voltage = double.tryParse(_voltageController.text);

    if (powerKw == null || length == null || voltage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid numbers')),
      );
      return;
    }

    // Convert kW to Amperes roughly for calculation (assuming cosPhi 0.85 for typical motor/load)
    // Or assume input IS Current? Usually inputs are Power (kW).
    // Let's assume input is Power in kW.

    // I = P(W) / (K * V * cosPhi)
    const cosPhi = 0.85;
    final current = ElectricalMath.calculateCurrent(
        powerWatts: powerKw * 1000,
        voltage: voltage,
        system: _system,
        powerFactor: cosPhi);

    final drop = ElectricalMath.calculateVoltageDrop(
      length: length,
      current: current,
      section: _section,
      material: _material,
      insulation: ConductorInsulation.xlpe, // Defaulting to XLPE for industry
      system: _system,
    );

    final percentage = ElectricalMath.calculateVoltageDropPercentage(
      dropVolts: drop,
      nominalVoltage: voltage,
    );

    setState(() {
      _resultVolts = drop;
      _resultPercentage = percentage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.voltageDrop),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Inputs
            _buildSectionHeader('Parámetros', theme),
            const SizedBox(height: 16),
            TextField(
              controller: _powerController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: theme.textTheme.bodyLarge?.color),
              decoration: InputDecoration(
                labelText: 'Potencia (kW)',
                suffixText: 'kW',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor:
                    colorScheme.surfaceContainerHighest.withValues(alpha: 0.1),
                labelStyle: TextStyle(color: theme.textTheme.bodyMedium?.color),
                suffixStyle:
                    TextStyle(color: theme.textTheme.bodyMedium?.color),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _lengthController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: theme.textTheme.bodyLarge?.color),
              decoration: InputDecoration(
                labelText: 'Longitud (m)',
                suffixText: 'm',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor:
                    colorScheme.surfaceContainerHighest.withValues(alpha: 0.1),
                labelStyle: TextStyle(color: theme.textTheme.bodyMedium?.color),
                suffixStyle:
                    TextStyle(color: theme.textTheme.bodyMedium?.color),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _voltageController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: theme.textTheme.bodyLarge?.color),
              decoration: InputDecoration(
                labelText: 'Voltaje (V)',
                suffixText: 'V',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor:
                    colorScheme.surfaceContainerHighest.withValues(alpha: 0.1),
                labelStyle: TextStyle(color: theme.textTheme.bodyMedium?.color),
                suffixStyle:
                    TextStyle(color: theme.textTheme.bodyMedium?.color),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<VoltageSystem>(
              initialValue: _system,
              decoration: InputDecoration(
                labelText: 'Sistema',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor:
                    colorScheme.surfaceContainerHighest.withValues(alpha: 0.1),
                labelStyle: TextStyle(color: theme.textTheme.bodyMedium?.color),
              ),
              items: const [
                DropdownMenuItem(
                    value: VoltageSystem.threePhase,
                    child: Text('Trifásico (400V)')),
                DropdownMenuItem(
                    value: VoltageSystem.singlePhase,
                    child: Text('Monofásico (230V)')),
              ],
              onChanged: (v) => setState(() {
                _system = v!;
                _voltageController.text =
                    _system == VoltageSystem.threePhase ? '400' : '230';
              }),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<ConductorMaterial>(
              initialValue: _material,
              decoration: InputDecoration(
                labelText: 'Material',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor:
                    colorScheme.surfaceContainerHighest.withValues(alpha: 0.1),
                labelStyle: TextStyle(color: theme.textTheme.bodyMedium?.color),
              ),
              items: const [
                DropdownMenuItem(
                    value: ConductorMaterial.copper, child: Text('Cobre (Cu)')),
                DropdownMenuItem(
                    value: ConductorMaterial.aluminum,
                    child: Text('Aluminio (Al)')),
              ],
              onChanged: (v) => setState(() => _material = v!),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<double>(
              initialValue: _section,
              decoration: InputDecoration(
                labelText: 'Sección Cable',
                border: const OutlineInputBorder(),
                filled: true,
                fillColor:
                    colorScheme.surfaceContainerHighest.withValues(alpha: 0.1),
                labelStyle: TextStyle(color: theme.textTheme.bodyMedium?.color),
              ),
              items: _standardSections
                  .map((s) => DropdownMenuItem(value: s, child: Text('$s mm²')))
                  .toList(),
              onChanged: (v) => setState(() => _section = v!),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                ),
                onPressed: _calculate,
                child: const Text('CALCULAR',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 32),

            // Results
            if (_resultVolts != null) ...[
              _buildSectionHeader('Resultados', theme),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                child: Column(
                  children: [
                    _buildResultRow('Caída Tensión (V)',
                        '${_resultVolts!.toStringAsFixed(2)} V', theme),
                    const Divider(),
                    _buildResultRow('Caída Tensión (%)',
                        '${_resultPercentage!.toStringAsFixed(2)} %', theme),
                    const SizedBox(height: 8),
                    _buildValidationTag(_resultPercentage!),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, ThemeData theme) {
    return Text(title,
        style:
            theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold));
  }

  Widget _buildResultRow(String label, String value, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: theme.textTheme.bodyLarge),
        Text(value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            )),
      ],
    );
  }

  Widget _buildValidationTag(double percentage) {
    bool valid = percentage <= 5.0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: valid
            ? Colors.green.withValues(alpha: 0.1)
            : Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: valid ? Colors.green : Colors.red),
      ),
      child: Text(
        valid ? 'CUMPLE REBT (<5%)' : 'NO CUMPLE (>5%)',
        style: TextStyle(
            color: valid ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
