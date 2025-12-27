import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/app_preferences.dart';
import '../bloc/settings_cubit.dart';

/// Dialog for selecting text size preference
class TextSizeSelector extends StatelessWidget {
  const TextSizeSelector({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const TextSizeSelector(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          title: const Text('Tamaño de Texto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSizeOption(
                context,
                theme,
                TextSizePreference.small,
                state.textSize,
              ),
              _buildSizeOption(
                context,
                theme,
                TextSizePreference.medium,
                state.textSize,
              ),
              _buildSizeOption(
                context,
                theme,
                TextSizePreference.large,
                state.textSize,
              ),
              _buildSizeOption(
                context,
                theme,
                TextSizePreference.extraLarge,
                state.textSize,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.close),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSizeOption(
    BuildContext context,
    ThemeData theme,
    TextSizePreference size,
    TextSizePreference currentSize,
  ) {
    final isSelected = size == currentSize;

    return ListTile(
      title: Text(
        size.displayName,
        style: TextStyle(
          fontSize: 14 * size.scaleFactor,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: theme.primaryColor)
          : null,
      onTap: () {
        context.read<SettingsCubit>().setTextSize(size);
        Navigator.of(context).pop();
      },
    );
  }
}
