import 'package:flutter/material.dart';

import 'package:electrician_app/l10n/app_localizations.dart';
import '../../domain/entities/ev_models.dart';
import '../../domain/entities/conductor.dart';
import '../../domain/usecases/electrical_math.dart';
import '../../domain/services/cable_service.dart';
import 'package:electrician_app/core/presentation/widgets/beta_feature_banner.dart';

class ChargingStationPage extends StatefulWidget {
  const ChargingStationPage({Key? key}) : super(key: key);

  @override
  State<ChargingStationPage> createState() => _ChargingStationPageState();
}

class _ChargingStationPageState extends State<ChargingStationPage> {
  // Inputs
  EvScheme _selectedScheme = EvScheme.scheme2;
  final TextEditingController _powerController =
      TextEditingController(text: '7.4');
  final TextEditingController _lengthController =
      TextEditingController(text: '25');

  bool _isThreePhase = false;
  final ConductorMaterial _material = ConductorMaterial.copper;
  final ConductorInsulation _insulation = ConductorInsulation.pvc;
  final InstallationMethod _method = InstallationMethod.b2;

  // Outputs
  EvResult? _result;
  bool _calculating = false;

  final CableService _cableService = CableService();

  @override
  void initState() {
    super.initState();
    _checkPhase();
    _powerController.addListener(_checkPhase);
  }

  @override
  void dispose() {
    _powerController.dispose();
    _lengthController.dispose();
    super.dispose();
  }

  void _checkPhase() {
    final power = double.tryParse(_powerController.text) ?? 0.0;
    // Heuristic: > 7.4kW implies 3-phase usually
    if (power > 7.4 && !_isThreePhase) {
      setState(() {
        _isThreePhase = true;
      });
    } else if (power <= 7.4 && _isThreePhase) {
      setState(() {
        _isThreePhase = false;
      });
    }
  }

  Future<void> _calculate() async {
    setState(() {
      _calculating = true;
      _result = null;
    });

    try {
      final powerKw =
          double.tryParse(_powerController.text.replaceAll(',', '.')) ?? 0;
      final length =
          double.tryParse(_lengthController.text.replaceAll(',', '.')) ?? 0;

      if (powerKw <= 0 || length <= 0) throw Exception("Inputs invalid");

      final powerW = powerKw * 1000;
      final voltage = _isThreePhase ? 400.0 : 230.0;
      final system =
          _isThreePhase ? VoltageSystem.threePhase : VoltageSystem.singlePhase;

      final current = ElectricalMath.calculateCurrent(
        powerWatts: powerW,
        voltage: voltage,
        system: system,
        powerFactor: 0.9,
      );

      // 2. Select Protection (In) >= Ib
      final standardBreakers = [
        10.0,
        16.0,
        20.0,
        25.0,
        32.0,
        40.0,
        50.0,
        63.0,
        80.0,
        100.0
      ];
      double protection =
          standardBreakers.firstWhere((b) => b >= current, orElse: () => 0.0);

      // If current > 100A, fail for MVP
      if (protection == 0.0) {
        throw Exception("Current too high (>100A)");
      }

      // 3. Select Cable Section (Iz >= In)
      // Iterative process for Voltage Drop check
      double section = 0.0;
      double drop = 0.0;
      double dropPercent = 0.0;
      bool valid = false;

      // Start withampacity check
      section = _cableService.getNextStandardSection(
          protection, _material, _insulation, _method);

      if (section == 0.0) throw Exception("No cable found for this current");

      // Loop for Voltage Drop (Limit 5% for EV?)
      // ITC-BT-52:
      // Esquema 1 (Centralizado): Type 1 (Main counter) -> Max 4.5% ? (Depends on installation)
      // Esquema 2 (Individual): From main board -> Max 5%?
      // Let's safe limit 5.0% global for MVP EV
      const maxDropPercent = 5.0;

      for (int i = 0; i < 5; i++) {
        drop = ElectricalMath.calculateVoltageDrop(
          length: length,
          current: protection,
          section: section,
          material: _material,
          insulation: _insulation,
          system: system,
        );

        dropPercent = ElectricalMath.calculateVoltageDropPercentage(
            dropVolts: drop, nominalVoltage: voltage);

        if (dropPercent <= maxDropPercent) {
          valid = true;
          break;
        }

        // Upsize
        // Helper hack: manual upsize list
        final sections = [
          1.5,
          2.5,
          4.0,
          6.0,
          10.0,
          16.0,
          25.0,
          35.0,
          50.0,
          70.0,
          95.0,
          120.0
        ];
        int idx = sections.indexOf(section);
        if (idx < sections.length - 1) {
          section = sections[idx + 1];
        } else {
          break;
        }
      }

      setState(() {
        _result = EvResult(
          section: section,
          voltageDrop: drop,
          voltageDropPercent: dropPercent,
          current: current,
          protectionAmps: protection,
          isValid: valid,
          message: valid ? "OK" : "Voltage Drop Limits Exceeded",
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    } finally {
      setState(() => _calculating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.evChargerTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const BetaFeatureBanner(),
            const SizedBox(height: 16),

            _buildEnvironmentSelector(theme),
            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color:
                    colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colorScheme.outlineVariant),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.chargingPointData,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),

                  // Scheme Dropdown
                  Text(AppLocalizations.of(context)!.installationScheme,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<EvScheme>(
                    initialValue: _selectedScheme,
                    isExpanded: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        filled: true,
                        fillColor: colorScheme.surfaceContainerHighest
                            .withValues(alpha: 0.1)),
                    items: EvScheme.values.map((s) {
                      return DropdownMenuItem(
                          value: s,
                          child: Text(s.label,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: theme.textTheme.bodyMedium?.color)));
                    }).toList(),
                    onChanged: (v) => setState(() => _selectedScheme = v!),
                  ),
                  const SizedBox(height: 16),

                  // Power and Length
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.powerKw,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _powerController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  color: theme.textTheme.bodyLarge?.color),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                suffixText: "kW",
                                suffixStyle: TextStyle(
                                    color: theme.textTheme.bodyMedium?.color),
                                filled: true,
                                fillColor: colorScheme.surfaceContainerHighest
                                    .withValues(alpha: 0.1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.lengthM,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _lengthController,
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  color: theme.textTheme.bodyLarge?.color),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                suffixText: "m",
                                suffixStyle: TextStyle(
                                    color: theme.textTheme.bodyMedium?.color),
                                filled: true,
                                fillColor: colorScheme.surfaceContainerHighest
                                    .withValues(alpha: 0.1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Phase Toggle (Info)
                  Row(
                    children: [
                      Text("Trifásico (>7.4kW): ",
                          style: Theme.of(context).textTheme.bodyMedium),
                      Switch(
                        value: _isThreePhase,
                        activeThumbColor: colorScheme.primary,
                        onChanged: (v) => setState(() => _isThreePhase = v),
                      )
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Calculate Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _calculate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: _calculating
                    ? CircularProgressIndicator(color: colorScheme.onPrimary)
                    : Text(AppLocalizations.of(context)!.calculateSection,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),

            const SizedBox(height: 24),

            // Results
            if (_result != null) _buildResults(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildEnvironmentSelector(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildEnvTab(AppLocalizations.of(context)!.housing, true,
              theme), // Simplification
          _buildEnvTab(AppLocalizations.of(context)!.garage, false, theme),
          _buildEnvTab(AppLocalizations.of(context)!.publicWay, false, theme),
        ],
      ),
    );
  }

  Widget _buildEnvTab(String label, bool active, ThemeData theme) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: active
            ? BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: theme.shadowColor.withValues(alpha: 0.05),
                      blurRadius: 4)
                ],
              )
            : null,
        child: Center(
            child: Text(label,
                style: TextStyle(
                    fontWeight: active ? FontWeight.bold : FontWeight.w500,
                    color: active
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant))),
      ),
    );
  }

  Widget _buildResults(ThemeData theme) {
    final r = _result!;
    final color =
        r.isValid ? Colors.green : Colors.orange; // Semantic colors ok

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
              r.isValid
                  ? AppLocalizations.of(context)!.calculationResult
                  : r.message,
              style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildResultItem(context, AppLocalizations.of(context)!.section,
                  '${r.section} mm²', true, color),
              Container(
                  width: 1, height: 40, color: color.withValues(alpha: 0.3)),
              _buildResultItem(
                  context,
                  AppLocalizations.of(context)!.voltageDrop,
                  '${r.voltageDropPercent.toStringAsFixed(2)}%',
                  false,
                  color),
              Container(
                  width: 1, height: 40, color: color.withValues(alpha: 0.3)),
              _buildResultItem(
                  context,
                  AppLocalizations.of(context)!.protection,
                  '${r.protectionAmps.toInt()} A',
                  false,
                  color),
            ],
          ),
          const SizedBox(height: 12),
          Text("Corriente: ${r.current.toStringAsFixed(1)} A",
              style: TextStyle(
                  fontSize: 12, color: theme.textTheme.bodySmall?.color)),
        ],
      ),
    );
  }

  Widget _buildResultItem(BuildContext context, String label, String value,
      bool isMain, Color color) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
              fontSize: isMain ? 24 : 18,
              fontWeight: FontWeight.bold,
              color: color.withValues(alpha: 1.0),
            )),
        Text(label,
            style: TextStyle(
              fontSize: 12,
              color: color.withValues(alpha: 0.8),
            )),
      ],
    );
  }
}
