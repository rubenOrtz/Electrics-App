import 'package:flutter/material.dart';
import 'package:electrician_app/core/presentation/widgets/app_button.dart';
import 'package:electrician_app/l10n/app_localizations.dart';

void showComingSoon(BuildContext context, {String? featureName}) {
  showDialog(
    context: context,
    builder: (context) => ComingSoonDialog(featureName: featureName),
  );
}

class ComingSoonDialog extends StatefulWidget {
  final String? featureName;

  const ComingSoonDialog({Key? key, this.featureName}) : super(key: key);

  @override
  State<ComingSoonDialog> createState() => _ComingSoonDialogState();
}

class _ComingSoonDialogState extends State<ComingSoonDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Default strings
    final title = "Próximamente";
    final message = widget.featureName != null
        ? "La funcionalidad '${widget.featureName}' estará disponible dentro de poco, estamos trabajando activamente en ello."
        : "Esta funcionalidad estará disponible dentro de poco, estamos trabajando activamente en ello.";

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primaryContainer,
                      colorScheme.primary.withValues(alpha: 0.3),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.rocket_launch_rounded,
                    size: 40,
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  Text(
                    l10n?.comingSoonTitle ?? title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.featureName != null
                        ? l10n?.featureUnderDevelopment(widget.featureName!) ??
                            "La funcionalidad ${widget.featureName} estará disponible dentro de poco, estamos trabajando activamente en ello."
                        : (l10n?.comingSoonMessage ?? message),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      text: l10n?.close ?? "Cerrar",
                      onPressed: () => Navigator.pop(context),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
