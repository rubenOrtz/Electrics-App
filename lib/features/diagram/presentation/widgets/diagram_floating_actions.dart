import 'package:flutter/material.dart';
import '../../../../config/theme/app_themes.dart';

class DiagramFloatingActions extends StatelessWidget {
  final VoidCallback? onUndo;
  final VoidCallback? onRedo;
  final VoidCallback onDelete;

  const DiagramFloatingActions({
    super.key,
    required this.onUndo,
    required this.onRedo,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DiagramActionButton(icon: Icons.undo, onPressed: onUndo),
        const SizedBox(height: 12),
        DiagramActionButton(icon: Icons.redo, onPressed: onRedo),
        const SizedBox(height: 12),
        DiagramActionButton(
            icon: Icons.delete_outline,
            onPressed: onDelete,
            isDestructive: true),
      ],
    );
  }
}

class DiagramActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isDestructive;

  const DiagramActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final diagramTheme = theme.extension<DiagramTheme>()!;
    // final isDark = theme.brightness == Brightness.dark; // No longer needed for colors if using DiagramTheme

    // Choose colors based on theme
    final bgColor = diagramTheme.nodeBg;
    final iconColor = isDestructive ? Colors.redAccent : diagramTheme.textColor;
    final borderColor = diagramTheme.nodeBorder;

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
          border: Border.all(color: borderColor),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ]),
      child: IconButton(
        icon: Icon(icon),
        color: iconColor,
        onPressed: onPressed,
      ),
    );
  }
}
