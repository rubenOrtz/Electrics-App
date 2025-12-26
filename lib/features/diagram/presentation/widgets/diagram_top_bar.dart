import 'package:flutter/material.dart';
import '../../../../config/theme/app_themes.dart';

class DiagramTopBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onBackPressed;
  final int selectedTab; // 0: Diagram, 1: Health, 2: Budget
  final VoidCallback onBudgetPressed;
  final Function(int) onTabChanged;
  final bool isSelectionMode;

  const DiagramTopBar({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onBackPressed,
    required this.selectedTab,
    required this.onBudgetPressed,
    required this.onTabChanged,
    this.isSelectionMode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final diagramTheme = theme.extension<DiagramTheme>()!;

    return Container(
      color: diagramTheme.canvasBg.withValues(alpha: 0.9),
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
      child: Row(
        children: [
          // Back button
          _buildActionButton(
            icon: Icons.arrow_back_ios_new,
            color: diagramTheme.textColor,
            onPressed: onBackPressed,
            theme: diagramTheme,
          ),
          const SizedBox(width: 16),
          // Title and subtitle
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: diagramTheme.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Colors.greenAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          color: diagramTheme.textColor.withValues(alpha: 0.7),
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          if (!isSelectionMode) ...[
            const SizedBox(width: 12),
            // Tab Icons (Diagram / Health)
            _buildActionButton(
              icon: Icons.account_tree_outlined,
              color: selectedTab == 0
                  ? diagramTheme.accentColor
                  : diagramTheme.textColor.withValues(alpha: 0.4),
              onPressed: () => onTabChanged(0),
              theme: diagramTheme,
              isActive: selectedTab == 0,
            ),
            const SizedBox(width: 8),
            _buildActionButton(
              icon: Icons.health_and_safety_outlined,
              color: selectedTab == 1
                  ? diagramTheme.accentColor
                  : diagramTheme.textColor.withValues(alpha: 0.4),
              onPressed: () => onTabChanged(1),
              theme: diagramTheme,
              isActive: selectedTab == 1,
            ),

            const SizedBox(width: 8),

            // Budget Button
            _buildActionButton(
              icon: Icons.euro_symbol,
              color: selectedTab == 2
                  ? diagramTheme.accentColor
                  : diagramTheme.textColor.withValues(alpha: 0.4),
              onPressed: onBudgetPressed,
              theme: diagramTheme,
              isActive: selectedTab == 2,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required DiagramTheme theme,
    bool isActive = false,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 44,
        height: 44,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isActive
              ? theme.accentColor.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isActive
              ? Border.all(color: theme.accentColor.withValues(alpha: 0.3))
              : null,
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }
}
