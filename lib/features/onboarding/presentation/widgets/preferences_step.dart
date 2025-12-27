import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electrician_app/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:electrician_app/features/settings/domain/entities/app_preferences.dart';
import 'package:electrician_app/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:electrician_app/features/settings/domain/entities/app_theme_mode.dart';
import '../../../../config/theme/theme_cubit.dart';

class PreferencesStep extends StatelessWidget {
  const PreferencesStep({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    final theme = Theme.of(context);

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Preferencias',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Personaliza la apariencia de la aplicación',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),

              // Theme Selector
              Text(
                'Tema',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildThemeOption(
                context,
                title: 'Claro',
                icon: Icons.light_mode,
                value: AppThemeMode.light,
                groupValue: state.themePreference,
              ),
              const SizedBox(height: 12),
              _buildThemeOption(
                context,
                title: 'Oscuro',
                icon: Icons.dark_mode,
                value: AppThemeMode.dark,
                groupValue: state.themePreference,
              ),
              const SizedBox(height: 12),
              _buildThemeOption(
                context,
                title: 'Automático (Sistema)',
                icon: Icons.brightness_auto,
                value: AppThemeMode.system,
                groupValue: state.themePreference,
              ),
              // Conditionally show Dynamic Theme
              if (themeState.isDynamicColorAvailable) ...[
                const SizedBox(height: 12),
                _buildThemeOption(
                  context,
                  title: 'Dinámico (Material You)',
                  icon: Icons.palette_outlined,
                  value: AppThemeMode.dynamic,
                  groupValue: state.themePreference,
                ),
              ],

              const SizedBox(height: 32),

              // Text Size Selector
              Text(
                'Tamaño de Texto',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              SegmentedButton<TextSizePreference>(
                segments: const [
                  ButtonSegment(
                    value: TextSizePreference.small,
                    label: Text('Pequeño'),
                    icon: Icon(Icons.text_fields, size: 16),
                  ),
                  ButtonSegment(
                    value: TextSizePreference.medium,
                    label: Text('Medio'),
                    icon: Icon(Icons.text_fields, size: 20),
                  ),
                  ButtonSegment(
                    value: TextSizePreference.large,
                    label: Text('Grande'),
                    icon: Icon(Icons.text_fields, size: 24),
                  ),
                ],
                selected: {state.textSizePreference},
                onSelectionChanged: (Set<TextSizePreference> newSelection) {
                  final newSize = newSelection.first;
                  // Update Onboarding State
                  context.read<OnboardingCubit>().updatePreferences(
                        textSize: newSize,
                      );
                  // Update Global Settings for Instant Feedback
                  context.read<SettingsCubit>().setTextSize(newSize);
                },
              ),

              const SizedBox(height: 32),

              // Notifications
              SwitchListTile(
                title: const Text('Habilitar Notificaciones'),
                subtitle:
                    const Text('Recibe alertas sobre cambios en normativas'),
                value: state.notificationsEnabled,
                onChanged: (value) {
                  context.read<OnboardingCubit>().updatePreferences(
                        notificationsEnabled: value,
                      );
                },
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildThemeOption(
    BuildContext context, {
    required String title,
    required IconData icon,
    required AppThemeMode value,
    required AppThemeMode groupValue,
  }) {
    final theme = Theme.of(context);
    final isSelected = value == groupValue;

    return InkWell(
      onTap: () {
        context.read<OnboardingCubit>().updatePreferences(themeMode: value);
        // Instant Theme Reaction
        context.read<ThemeCubit>().setTheme(value);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : theme.dividerColor,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.1)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.iconTheme.color?.withValues(alpha: 0.7),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? theme.colorScheme.primary : null,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: theme.colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}
