import 'package:flutter/material.dart';
import 'package:electrician_app/l10n/app_localizations.dart';

class BetaFeatureBanner extends StatelessWidget {
  final String? title;
  final String? message;

  const BetaFeatureBanner({super.key, this.title, this.message});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final warningColor = Colors.amber.shade700;
    final containerColor = isDark
        ? Colors.amber.withValues(alpha: 0.15)
        : Colors.amber.withValues(alpha: 0.25);

    final displayTitle =
        title ?? l10n?.betaWarningTitle ?? "Funcionalidad Beta";
    final displayMessage = message ??
        l10n?.betaWarningMessage ??
        "Esta característica está en desarrollo. úsela con precaución.";

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: warningColor.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: warningColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayTitle,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: warningColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  displayMessage,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodyMedium?.color,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
