import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/settings_cubit.dart';

/// Dialog for selecting app language
class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const LanguageSelector(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(l10n.language),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLanguageOption(
                context,
                theme,
                'es',
                'Español (España)',
                state.locale,
              ),
              _buildLanguageOption(
                context,
                theme,
                'en',
                'English (US)',
                state.locale,
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

  Widget _buildLanguageOption(
    BuildContext context,
    ThemeData theme,
    String localeCode,
    String displayName,
    String currentLocale,
  ) {
    final isSelected = localeCode == currentLocale;

    return ListTile(
      title: Text(
        displayName,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: theme.primaryColor)
          : null,
      onTap: () {
        context.read<SettingsCubit>().setLocale(localeCode);
        Navigator.of(context).pop();
      },
    );
  }
}
