import 'package:flutter/material.dart';
import '../../domain/entities/validation_status.dart';

/// Badge que muestra el estado de validación de un nodo
class NodeStatusBadge extends StatefulWidget {
  final ValidationStatus status;
  final List<ValidationError> errors;
  final List<ValidationWarning> warnings;
  final VoidCallback? onTap;

  const NodeStatusBadge({
    super.key,
    required this.status,
    this.errors = const [],
    this.warnings = const [],
    this.onTap,
  });

  @override
  State<NodeStatusBadge> createState() => _NodeStatusBadgeState();
}

class _NodeStatusBadgeState extends State<NodeStatusBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    // Solo animar si hay error crítico
    if (widget.status == ValidationStatus.error) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(NodeStatusBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.status == ValidationStatus.error &&
        oldWidget.status != ValidationStatus.error) {
      _pulseController.repeat(reverse: true);
    } else if (widget.status != ValidationStatus.error) {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.status == ValidationStatus.ok ||
        widget.status == ValidationStatus.pending) {
      return const SizedBox.shrink();
    }

    return Positioned(
      top: 0,
      right: 0,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            final scale = widget.status == ValidationStatus.error
                ? _pulseAnimation.value
                : 1.0;

            return Transform.scale(
              scale: scale,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: _getBackgroundColor(),
                  shape: BoxShape.circle,
                  boxShadow: widget.status == ValidationStatus.error
                      ? [
                          BoxShadow(
                            color: Colors.redAccent.withValues(alpha: 0.5),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  _getIcon(),
                  size: 16,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (widget.status) {
      case ValidationStatus.error:
        return Colors.redAccent;
      case ValidationStatus.warning:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getIcon() {
    switch (widget.status) {
      case ValidationStatus.error:
        return Icons.error;
      case ValidationStatus.warning:
        return Icons.warning_amber;
      default:
        return Icons.check_circle;
    }
  }
}
