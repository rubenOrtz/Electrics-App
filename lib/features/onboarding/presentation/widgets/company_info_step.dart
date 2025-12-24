import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/onboarding_cubit.dart';

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
              decoration: const InputDecoration(
                labelText: 'CIF *',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context.read<OnboardingCubit>().updateCompanyInfo(cif: value);
              },
            ),
            const SizedBox(height: 16),

            // Company Name
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre de Empresa *',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context.read<OnboardingCubit>().updateCompanyInfo(name: value);
              },
            ),
            const SizedBox(height: 16),

            // Address
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Dirección *',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
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
