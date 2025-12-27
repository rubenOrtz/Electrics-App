import 'package:flutter/material.dart';
import '../../domain/entities/component_template.dart';
import '../../domain/services/trip_curve_calculator.dart';
import 'trip_curve_painter.dart';

/// Widget that displays an animated trip curve for a protection device
class TripCurveViewer extends StatefulWidget {
  final ProtectionTemplate protection;
  final double? height;
  final bool showGrid;

  const TripCurveViewer({
    super.key,
    required this.protection,
    this.height,
    this.showGrid = true,
  });

  @override
  State<TripCurveViewer> createState() => _TripCurveViewerState();
}

class _TripCurveViewerState extends State<TripCurveViewer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late TripCurveData _curveData;

  @override
  void initState() {
    super.initState();
    _curveData = TripCurveCalculator.calculateCurve(
      curveType: widget.protection.curveType,
      ratedCurrent: widget.protection.ratedCurrent,
    );

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(TripCurveViewer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Recalculate curve if parameters changed
    if (oldWidget.protection.curveType != widget.protection.curveType ||
        oldWidget.protection.ratedCurrent != widget.protection.ratedCurrent) {
      setState(() {
        _curveData = TripCurveCalculator.calculateCurve(
          curveType: widget.protection.curveType,
          ratedCurrent: widget.protection.ratedCurrent,
        );
      });

      // Animate transition
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            Row(
              children: [
                const Icon(Icons.show_chart, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Curva de Disparo IEC 60898',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                _buildCurveTypeBadge(context),
              ],
            ),
            const SizedBox(height: 16),

            // Trip curve canvas
            SizedBox(
              height: widget.height ?? 400,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return CustomPaint(
                    painter: TripCurvePainter(
                      curveData: _curveData,
                      curveColor: _getCurveColor(),
                      showGrid: widget.showGrid,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      gridColor: Theme.of(context)
                          .colorScheme
                          .outlineVariant
                          .withValues(alpha: 0.5),
                      axisColor: Theme.of(context).colorScheme.onSurface,
                      textColor: Theme.of(context).colorScheme.onSurface,
                    ),
                    size: Size.infinite,
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Info panel
            _buildInfoPanel(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCurveTypeBadge(BuildContext context) {
    final color = _getCurveColor();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
      ),
      child: Text(
        'Tipo ${widget.protection.curveType}',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildInfoPanel(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest
            .withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInfoItem(
            context,
            'Corriente Nominal',
            '${widget.protection.ratedCurrent.toStringAsFixed(0)} A',
            Icons.flash_on,
          ),
          _buildInfoItem(
            context,
            'Poder de Corte',
            '${widget.protection.breakingCapacity.toStringAsFixed(0)} kA',
            Icons.power,
          ),
          _buildInfoItem(
            context,
            'Polos',
            '${widget.protection.poles}P',
            Icons.settings_input_component,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon,
            size: 20, color: Theme.of(context).colorScheme.onSurfaceVariant),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Color _getCurveColor() {
    switch (widget.protection.curveType.toUpperCase()) {
      case 'B':
        return Colors.green;
      case 'C':
        return Colors.blue;
      case 'D':
        return Colors.orange;
      case 'K':
        return Colors.purple;
      case 'Z':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }
}
