import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/project_cubit.dart';
import '../../../../features/compliance/domain/compliance_registry.dart';
import '../../../../l10n/app_localizations.dart';

class GeneralConfigPage extends StatefulWidget {
  const GeneralConfigPage({Key? key}) : super(key: key);

  @override
  State<GeneralConfigPage> createState() => _GeneralConfigPageState();
}

class _GeneralConfigPageState extends State<GeneralConfigPage> {
  late TextEditingController _nameController;
  late TextEditingController _referenceController;
  late TextEditingController _clientController;
  late TextEditingController _ownerPhoneController;
  late TextEditingController _ownerEmailController;
  late TextEditingController _powerController;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ProjectCubit>();
    _nameController = TextEditingController(text: cubit.state.projectName);
    _referenceController = TextEditingController(text: cubit.state.reference);
    _clientController = TextEditingController(text: cubit.state.client);
    _ownerPhoneController = TextEditingController(text: cubit.state.ownerPhone);
    _ownerEmailController = TextEditingController(text: cubit.state.ownerEmail);
    _powerController = TextEditingController(
        text: (cubit.state.expectedPower ?? 15.0).toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _referenceController.dispose();
    _clientController.dispose();
    _ownerPhoneController.dispose();
    _ownerEmailController.dispose();
    _powerController.dispose();
    super.dispose();
  }

  void _saveProject() {
    final cubit = context.read<ProjectCubit>();
    // Reset success/error before saving
    cubit.clearError();

    cubit.updateProjectName(_nameController.text);
    cubit.updateReference(_referenceController.text);
    cubit.updateClient(_clientController.text);
    cubit.updateOwnerPhone(_ownerPhoneController.text);
    cubit.updateOwnerEmail(_ownerEmailController.text);

    final power =
        double.tryParse(_powerController.text.replaceAll(',', '.')) ?? 15.0;
    cubit.updateExpectedPower(power);

    cubit.saveProject();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocListener<ProjectCubit, ProjectState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: colorScheme.error),
          );
        } else if (state.saveSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.projectSavedSuccess)),
          );
          // Go back to previous screen (Project List or Dashboard)
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.projectConfigTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.save_outlined, color: colorScheme.primary),
              onPressed: _saveProject,
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSection(context, l10n.generalInfo, [
                _buildTextInput(
                    context, l10n.projectNameLabel, _nameController),
                _buildTextInput(
                    context, l10n.internalReference, _referenceController),
                _buildTextInput(context, l10n.location, null,
                    initialValue: 'C/ Gran Vía 1, Madrid'),
              ]),
              const SizedBox(height: 24),
              _buildSection(context, l10n.ownerData, [
                _buildTextInput(context, l10n.ownerName, _clientController),
                _buildTextInput(
                    context, l10n.ownerPhone, _ownerPhoneController),
                _buildTextInput(
                    context, l10n.ownerEmail, _ownerEmailController),
                _buildTextInput(context, l10n.ownerId, null,
                    initialValue: 'A-81234567'),
              ]),
              const SizedBox(height: 24),
              BlocBuilder<ProjectCubit, ProjectState>(
                builder: (context, state) {
                  return _buildSection(
                      context, l10n.regulationsAndCalculation, [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.electricalRegulations,
                            style: theme.textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: colorScheme.outlineVariant),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: state.electricalStandardId,
                              dropdownColor:
                                  colorScheme.surfaceContainerHighest,
                              items: ComplianceRegistry.all.map((s) {
                                return DropdownMenuItem(
                                  value: s.id,
                                  child: Text(s.name,
                                      style: TextStyle(
                                          color: colorScheme.onSurface)),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  context
                                      .read<ProjectCubit>()
                                      .updateElectricalStandard(val);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ]);
                },
              ),
              const SizedBox(height: 24),
              BlocBuilder<ProjectCubit, ProjectState>(
                builder: (context, state) {
                  return _buildSection(context, l10n.electricalParams, [
                    _buildDropdown(
                        context,
                        l10n.supplyVoltage,
                        state.supplyVoltage ?? '400V III',
                        ['400V III', '230V II', '230V III'],
                        (val) => context
                            .read<ProjectCubit>()
                            .updateSupplyVoltage(val)),
                    _buildDropdown(
                        context,
                        l10n.installationUsage,
                        state.installationUsage ??
                            'Local de Pública Concurrencia',
                        [
                          'Local de Pública Concurrencia',
                          l10n.housingType,
                          l10n.industrialType,
                          l10n.othersType
                        ],
                        (val) => context
                            .read<ProjectCubit>()
                            .updateInstallationUsage(val)),
                    Row(
                      children: [
                        Expanded(
                            child: _buildTextInput(
                                context, l10n.expectedPower, _powerController)),
                        const SizedBox(width: 16),
                        Expanded(
                            child: _buildDropdown(
                                context,
                                l10n.powerFactor,
                                (state.powerFactor ?? 0.9).toString(),
                                ['0.8', '0.85', '0.9', '0.95', '1.0'],
                                (val) => context
                                    .read<ProjectCubit>()
                                    .updatePowerFactor(
                                        double.tryParse(val) ?? 0.9))),
                      ],
                    ),
                    _buildToggle(
                        context,
                        l10n.requiresTechProject,
                        state.requiresTechProject ?? true,
                        (v) => context
                            .read<ProjectCubit>()
                            .updateRequiresTechProject(v)),
                    _buildToggle(
                        context,
                        l10n.newLinkInstallation,
                        state.isNewLink ?? false,
                        (v) => context.read<ProjectCubit>().updateIsNewLink(v)),
                  ]);
                },
              ),
              const SizedBox(height: 24),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _saveProject,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(l10n.saveAndContinue,
                      style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
      BuildContext context, String title, List<Widget> children) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurfaceVariant)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Column(
            children: children
                .expand((element) => [element, const SizedBox(height: 16)])
                .take(children.length * 2 - 1)
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTextInput(
      BuildContext context, String label, TextEditingController? controller,
      {String? initialValue}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: theme.textTheme.bodySmall
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller, // Use controller if provided
          initialValue: controller == null
              ? initialValue
              : null, // Use initialValue if no controller
          style: TextStyle(color: colorScheme.onSurface),
          decoration: InputDecoration(
            filled: true,
            fillColor:
                colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(BuildContext context, String label, String value,
      List<String> items, Function(String) onChanged) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: theme.textTheme.bodySmall
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: colorScheme.outlineVariant),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value:
                  items.contains(value) ? value : items.first, // Safety check
              dropdownColor: colorScheme.surfaceContainerHighest,
              items: items.map((s) {
                return DropdownMenuItem(
                  value: s,
                  child:
                      Text(s, style: TextStyle(color: colorScheme.onSurface)),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) onChanged(val);
              },
              icon:
                  Icon(Icons.expand_more, color: colorScheme.onSurfaceVariant),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToggle(BuildContext context, String label, bool value,
      Function(bool) onChanged) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: colorScheme.primary),
      ],
    );
  }
}
