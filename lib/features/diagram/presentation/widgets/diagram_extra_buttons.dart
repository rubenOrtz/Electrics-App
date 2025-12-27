import 'package:flutter/material.dart';
import '../../../../config/theme/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electrician_app/features/settings/domain/entities/app_theme_mode.dart';

/// Left-side zoom buttons (+/-, vertical layout) matching reference design
class DiagramZoomButtons extends StatelessWidget {
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;

  const DiagramZoomButtons({
    super.key,
    required this.onZoomIn,
    required this.onZoomOut,
  });

  bool _isHighContrastMode(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    return themeState.mode == AppThemeMode.highContrastLight ||
        themeState.mode == AppThemeMode.highContrastDark;
  }

  @override
  Widget build(BuildContext context) {
    final isHighContrast = _isHighContrastMode(context);

    if (!isHighContrast) {
      // Normal mode - simple circular buttons
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildNormalButton(Icons.add, onZoomIn),
          const SizedBox(height: 12),
          _buildNormalButton(Icons.remove, onZoomOut),
        ],
      );
    }

    // HIGH CONTRAST MODE - vertical pill shape matching reference
    return Container(
      width: 56,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Zoom In (+)
          SizedBox(
            width: 56,
            height: 56,
            child: IconButton(
              icon: const Icon(Icons.add, color: Colors.white, size: 32),
              onPressed: onZoomIn,
              padding: EdgeInsets.zero,
            ),
          ),
          // Divider line
          Container(
            height: 2,
            width: 40,
            color: Colors.white,
          ),
          // Zoom Out (-)
          SizedBox(
            width: 56,
            height: 56,
            child: IconButton(
              icon: const Icon(Icons.remove, color: Colors.white, size: 32),
              onPressed: onZoomOut,
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNormalButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: IconButton(
        icon: Icon(icon),
        color: Colors.white,
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }
}

/// Theme toggle button (bottom-left) matching reference design
class DiagramThemeButton extends StatelessWidget {
  final VoidCallback onToggle;

  const DiagramThemeButton({
    super.key,
    required this.onToggle,
  });

  bool _isHighContrastMode(BuildContext context) {
    final themeState = context.watch<ThemeCubit>().state;
    return themeState.mode == AppThemeMode.highContrastLight ||
        themeState.mode == AppThemeMode.highContrastDark;
  }

  @override
  Widget build(BuildContext context) {
    final isHighContrast = _isHighContrastMode(context);

    if (!isHighContrast) {
      // Normal mode - simple button
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: IconButton(
          icon: const Icon(Icons.brightness_6, color: Colors.white),
          onPressed: onToggle,
          padding: EdgeInsets.zero,
        ),
      );
    }

    // HIGH CONTRAST MODE - square with rounded corners matching reference
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: IconButton(
        icon: const Icon(Icons.brightness_2, color: Colors.black, size: 28),
        onPressed: onToggle,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
