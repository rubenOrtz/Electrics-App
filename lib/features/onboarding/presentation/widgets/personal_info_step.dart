import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/onboarding_cubit.dart';
import '../../domain/utils/validators.dart';

class PersonalInfoStep extends StatefulWidget {
  const PersonalInfoStep({Key? key}) : super(key: key);

  @override
  State<PersonalInfoStep> createState() => _PersonalInfoStepState();
}

// TODO: ADD I18N
class _PersonalInfoStepState extends State<PersonalInfoStep> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _dniController = TextEditingController();
  final _engineerIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<OnboardingCubit>().state;
    _nameController.text = state.personalName ?? '';
    _emailController.text = state.personalEmail ?? '';
    _phoneController.text = state.personalPhone ?? '';
    _dniController.text = state.personalDni ?? '';
    _engineerIdController.text = state.engineerId ?? '';
  }

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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
              'Cuéntanos sobre ti para personalizar tus informes.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: theme.dividerColor.withValues(alpha: 0.5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    textCapitalization: TextCapitalization.words,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Nombre Completo *',
                      prefixIcon: const Icon(Icons.person_outline),
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor:
                          theme.colorScheme.onSurface.withValues(alpha: 0.05),
                    ),
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'El nombre es obligatorio'
                        : null,
                    onChanged: (value) {
                      context
                          .read<OnboardingCubit>()
                          .updatePersonalInfo(name: value);
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Correo Electrónico *',
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor:
                          theme.colorScheme.onSurface.withValues(alpha: 0.05),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El correo es obligatorio';
                      }
                      final emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Introduce un correo válido';
                      }
                      return null;
                    },
                    onChanged: (value) => context
                        .read<OnboardingCubit>()
                        .updatePersonalInfo(email: value),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _phoneController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Teléfono *',
                      prefixIcon: const Icon(Icons.phone_outlined),
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor:
                          theme.colorScheme.onSurface.withValues(alpha: 0.05),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El teléfono es obligatorio';
                      }
                      if (value.length < 9) return 'Mínimo 9 dígitos';
                      return null;
                    },
                    onChanged: (value) => context
                        .read<OnboardingCubit>()
                        .updatePersonalInfo(phone: value),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _dniController,
                    textCapitalization: TextCapitalization.characters,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'DNI / NIE *',
                      prefixIcon: const Icon(Icons.badge_outlined),
                      border: const OutlineInputBorder(),
                      helperText: 'Para firmar boletines y certificados',
                      filled: true,
                      fillColor:
                          theme.colorScheme.onSurface.withValues(alpha: 0.05),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El DNI/NIE es obligatorio';
                      }
                      if (!SpanishDocumentValidator.isValidDNI(value) &&
                          !SpanishDocumentValidator.isValidNIE(value)) {
                        return 'DNI o NIE inválido (verifica la letra)';
                      }
                      return null;
                    },
                    onChanged: (value) => context
                        .read<OnboardingCubit>()
                        .updatePersonalInfo(dni: value),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _engineerIdController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      labelText: 'Nº Colegiado (Opcional)',
                      prefixIcon: const Icon(Icons.assignment_ind_outlined),
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor:
                          theme.colorScheme.onSurface.withValues(alpha: 0.05),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return null; // Optional
                      }
                      if (!SpanishDocumentValidator.isValidEngineerID(value)) {
                        return 'Formato inválido (ej: MAD-12345)';
                      }
                      return null;
                    },
                    onChanged: (value) => context
                        .read<OnboardingCubit>()
                        .updatePersonalInfo(engineerId: value),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Icon(Icons.info_outline, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Todos los campos marcados con (*) son obligatorios.",
                    style:
                        theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
