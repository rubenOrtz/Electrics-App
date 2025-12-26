import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/onboarding_cubit.dart';
import '../../domain/utils/validators.dart';

class CompanyInfoStep extends StatefulWidget {
  const CompanyInfoStep({Key? key}) : super(key: key);

  @override
  State<CompanyInfoStep> createState() => _CompanyInfoStepState();
}

class _CompanyInfoStepState extends State<CompanyInfoStep> {
  final _formKey = GlobalKey<FormState>();
  final _cifController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<OnboardingCubit>().state;
    _cifController.text = state.companyCif ?? '';
    _nameController.text = state.companyName ?? '';
    _addressController.text = state.companyAddress ?? '';
  }

  @override
  void dispose() {
    _cifController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            Text(
              'Datos de Empresa',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Información corporativa',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),

            // CIF
            TextFormField(
              controller: _cifController,
              textCapitalization: TextCapitalization.characters,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: 'CIF *',
                hintText: 'Ej: B12345678',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.business_outlined),
                filled: true,
                fillColor: theme.colorScheme.onSurface.withValues(alpha: 0.05),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El CIF es obligatorio';
                }
                if (!SpanishDocumentValidator.isValidCIF(value)) {
                  return 'CIF inválido';
                }
                return null;
              },
              onChanged: (value) {
                if (_formKey.currentState!.validate()) {
                  context.read<OnboardingCubit>().updateCompanyInfo(cif: value);
                } else {
                  context.read<OnboardingCubit>().updateCompanyInfo(cif: value);
                }
              },
            ),
            const SizedBox(height: 16),

            // Company Name
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: 'Nombre de Empresa *',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.storefront_outlined),
                filled: true,
                fillColor: theme.colorScheme.onSurface.withValues(alpha: 0.05),
              ),
              validator: (value) => (value == null || value.isEmpty)
                  ? 'El nombre es obligatorio'
                  : null,
              onChanged: (value) {
                context.read<OnboardingCubit>().updateCompanyInfo(name: value);
              },
            ),
            const SizedBox(height: 16),

            // Address
            TextFormField(
              controller: _addressController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                labelText: 'Dirección *',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.location_on_outlined),
                filled: true,
                fillColor: theme.colorScheme.onSurface.withValues(alpha: 0.05),
              ),
              maxLines: 3,
              validator: (value) => (value == null || value.isEmpty)
                  ? 'La dirección es obligatoria'
                  : null,
              onChanged: (value) {
                context
                    .read<OnboardingCubit>()
                    .updateCompanyInfo(address: value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
