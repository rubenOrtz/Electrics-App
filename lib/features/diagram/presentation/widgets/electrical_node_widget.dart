import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Haptics
import '../../domain/entities/electrical_node.dart';
import '../../domain/entities/electrical_enums.dart'; // For LoadType
import '../../domain/entities/validation_status.dart';
import '../../domain/entities/diagram_models.dart';
import 'diagnostic_sheet.dart';
import '../../../../config/theme/app_themes.dart';

const double kNodeWidth = 80.0;
const double kNodeHeight = 120.0;

/// Widget reactivo que renderiza un ElectricalNode con feedback visual
class ElectricalNodeWidget extends StatefulWidget {
  final ElectricalNode node;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final Function(NodeType)? onNodeDropped;

  const ElectricalNodeWidget({
    Key? key,
    required this.node,
    required this.isSelected,
    required this.onTap,
    this.onLongPress,
    this.onNodeDropped,
  }) : super(key: key);

  @override
  State<ElectricalNodeWidget> createState() => _ElectricalNodeWidgetState();
}

class _ElectricalNodeWidgetState extends State<ElectricalNodeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _updateAnimation();
  }

  @override
  void didUpdateWidget(ElectricalNodeWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.node.result?.status != widget.node.result?.status) {
      _updateAnimation();
    }
  }

  void _updateAnimation() {
    final status = widget.node.result?.status ?? ValidationStatus.pending;
    if (status == ValidationStatus.error) {
      _pulseController.repeat(reverse: true);
    } else {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  bool _wasHovered = false;

  @override
  Widget build(BuildContext context) {
    final result = widget.node.result;
    final status = result?.status ?? ValidationStatus.pending;
    final isLoad = widget.node is LoadNode;
    final hasIssues =
        status == ValidationStatus.error || status == ValidationStatus.warning;

    final diagramTheme = Theme.of(context).extension<DiagramTheme>()!;

    return DragTarget<NodeType>(
      onWillAcceptWithDetails: (details) {
        return true;
      },
      onAcceptWithDetails: (details) {
        if (widget.onNodeDropped != null) {
          widget.onNodeDropped!(details.data);
        }
      },
      builder: (context, candidateData, rejectedData) {
        final isHovered = candidateData.isNotEmpty;

        // Haptic & State Trigger on Enter/Exit
        if (isHovered != _wasHovered) {
          if (isHovered) {
            HapticFeedback.lightImpact(); // "Imán" sensation
          }
          _wasHovered = isHovered;
        }

        return GestureDetector(
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          child: AnimatedScale(
            scale: isHovered ? 1.15 : 1.0, // Magnetic pop effect
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutBack,
            child: SizedBox(
              width: kNodeWidth,
              height: isLoad ? 80 : kNodeHeight,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  // Highlight when hovering
                  Positioned.fill(
                    child: AnimatedOpacity(
                      opacity: isHovered ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.blueAccent, width: 3),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.blueAccent.withValues(alpha: 0.15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withValues(alpha: 0.3),
                              blurRadius: 12,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Main node content
                  Positioned.fill(
                    child: _buildNodeContent(isLoad, status, diagramTheme),
                  ),

                  // Status badge (top-right)
                  if (hasIssues)
                    Positioned(
                      top: -6,
                      right: -6,
                      child: GestureDetector(
                        onTap: () {
                          if (widget.node.result != null) {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (ctx) => DiagnosticSheet(
                                node: widget.node,
                              ),
                            );
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: status == ValidationStatus.error
                                ? Colors.red
                                : Colors.amber,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Icon(
                            status == ValidationStatus.error
                                ? Icons.close
                                : Icons.priority_high,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNodeContent(
      bool isLoad, ValidationStatus status, DiagramTheme theme) {
    if (isLoad) {
      return _buildLoadNode(status, theme);
    }
    return _buildStandardNode(status, theme);
  }

  Widget _buildLoadNode(ValidationStatus status, DiagramTheme theme) {
    final loadNode = widget.node as LoadNode;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            final scale =
                status == ValidationStatus.error ? _pulseAnimation.value : 1.0;

            return Transform.scale(
              scale: scale,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: theme.nodeBg,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.isSelected
                        ? theme.accentColor
                        : _getBorderColor(status, theme),
                    width: widget.isSelected ? 3 : 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.isSelected
                          ? theme.accentColor.withValues(alpha: 0.4)
                          : _getBorderColor(status, theme)
                              .withValues(alpha: 0.3),
                      blurRadius: widget.isSelected
                          ? 16
                          : (status == ValidationStatus.error ? 12 : 8),
                      spreadRadius: widget.isSelected
                          ? 3
                          : (status == ValidationStatus.error ? 2 : 0),
                    ),
                  ],
                ),
                child: Icon(
                  _getLoadIcon(loadNode),
                  color: status == ValidationStatus.error
                      ? Colors.redAccent
                      : status == ValidationStatus.warning
                          ? Colors.orange
                          : Colors.amberAccent,
                  size: 24,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 6),
        Text(
          widget.node.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: status == ValidationStatus.error
                ? Colors.redAccent
                : theme.textColor.withValues(alpha: 0.5),
            fontSize: 10,
            fontWeight: status == ValidationStatus.error
                ? FontWeight.bold
                : FontWeight.normal,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildStandardNode(ValidationStatus status, DiagramTheme theme) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        final scale =
            status == ValidationStatus.error ? _pulseAnimation.value : 1.0;

        return Transform.scale(
          scale: scale,
          child: Container(
            width: kNodeWidth,
            height: kNodeHeight,
            decoration: BoxDecoration(
              color: theme.nodeBg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: widget.isSelected
                    ? theme.accentColor
                    : _getBorderColor(status, theme),
                width: widget.isSelected
                    ? 2
                    : (status == ValidationStatus.error ? 2.5 : 1.5),
              ),
              boxShadow: [
                BoxShadow(
                  color: _getBorderColor(status, theme).withValues(alpha: 0.4),
                  blurRadius: status == ValidationStatus.error ? 12 : 8,
                  spreadRadius: status == ValidationStatus.error ? 1 : 0,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    widget.node.name,
                    style: TextStyle(
                      color: status == ValidationStatus.error
                          ? Colors.redAccent
                          : status == ValidationStatus.warning
                              ? Colors.orange
                              : theme.accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // Icon
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: _getIconBgColor(status, theme),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    _getIcon(),
                    color: _getIconColor(status, theme),
                    size: 24,
                  ),
                ),

                // Info
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: _buildInfoText(theme),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoText(DiagramTheme theme) {
    final result = widget.node.result;

    if (result == null) {
      return Text(
        'Sin calcular',
        style: TextStyle(
            color: theme.textColor.withValues(alpha: 0.5), fontSize: 9),
      );
    }

    return Column(
      children: [
        Text(
          'Ib: ${result.designCurrent.toStringAsFixed(1)}A',
          style: TextStyle(
              color: theme.textColor.withValues(alpha: 0.5), fontSize: 9),
        ),
        if (result.voltageDrop > 0)
          Text(
            'ΔU: ${result.voltageDrop.toStringAsFixed(1)}%',
            style: TextStyle(
              color: result.voltageDrop > 5
                  ? Colors.redAccent
                  : theme.textColor.withValues(alpha: 0.5),
              fontSize: 9,
              fontWeight:
                  result.voltageDrop > 5 ? FontWeight.bold : FontWeight.normal,
            ),
          ),
      ],
    );
  }

  Color _getBorderColor(ValidationStatus status, DiagramTheme theme) {
    switch (status) {
      case ValidationStatus.error:
        return Colors.redAccent;
      case ValidationStatus.warning:
        return Colors.orange;
      case ValidationStatus.ok:
        return theme.nodeBorder;
      case ValidationStatus.pending:
        return theme.nodeBorder;
    }
  }

  Color _getIconBgColor(ValidationStatus status, DiagramTheme theme) {
    switch (status) {
      case ValidationStatus.error:
        return Colors.red.withValues(alpha: 0.2);
      case ValidationStatus.warning:
        return Colors.orange.withValues(alpha: 0.2);
      default:
        return theme.accentColor.withValues(alpha: 0.1);
    }
  }

  Color _getIconColor(ValidationStatus status, DiagramTheme theme) {
    switch (status) {
      case ValidationStatus.error:
        return Colors.redAccent;
      case ValidationStatus.warning:
        return Colors.orange;
      default:
        return theme.accentColor;
    }
  }

  IconData _getLoadIcon(LoadNode node) {
    switch (node.type) {
      case LoadType.motor:
        return Icons.settings;
      case LoadType.power:
        return Icons.power;
      case LoadType.lighting:
        return Icons.lightbulb_outline;
    }
  }

  IconData _getIcon() {
    return widget.node.map(
      source: (n) => Icons.power,
      panel: (n) => Icons.dashboard,
      protection: (n) => Icons.toggle_off,
      load: (n) => Icons.lightbulb_outline,
    );
  }
}
