import 'package:flutter/material.dart';

class PreferencesStep extends StatelessWidget {
  const PreferencesStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
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
            'Personaliza tu experiencia',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),
          const Expanded(
            child: Center(
              child: Text(
                'Las preferencias se pueden configurar más tarde desde Ajustes',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
