import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/onboarding_cubit.dart';

class PersonalInfoStep extends StatefulWidget {
  const PersonalInfoStep({Key? key}) : super(key: key);

  @override
  State<PersonalInfoStep> createState() => _PersonalInfoStepState();
}

class _PersonalInfoStepState extends State<PersonalInfoStep> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dniController = TextEditingController();
  final _engineerIdController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dniController.dispose();
    _engineerIdController.dispose();
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
              'Información Personal',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Cuéntanos sobre ti',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),

            // Full Name
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre Completo *',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context.read<OnboardingCubit>().updatePersonalInfo(name: value);
              },
            ),
            const SizedBox(height: 16),

            // Email
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo Electrónico *',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                context
                    .read<OnboardingCubit>()
                    .updatePersonalInfo(email: value);
              },
            ),
            const SizedBox(height: 16),

            // Phone
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Teléfono *',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                context
                    .read<OnboardingCubit>()
                    .updatePersonalInfo(phone: value);
              },
            ),
            const SizedBox(height: 16),

            // DNI
            TextFormField(
              controller: _dniController,
              decoration: const InputDecoration(
                labelText: 'DNI/NIE *',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context.read<OnboardingCubit>().updatePersonalInfo(dni: value);
              },
            ),
            const SizedBox(height: 16),

            // Engineer ID
            TextFormField(
              controller: _engineerIdController,
              decoration: const InputDecoration(
                labelText: 'Nº Colegiado *',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context
                    .read<OnboardingCubit>()
                    .updatePersonalInfo(engineerId: value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
