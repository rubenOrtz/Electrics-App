import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../diagram/presentation/bloc/diagram_cubit.dart';
import '../../../diagram/presentation/bloc/diagram_state.dart';
import '../../../diagram/domain/entities/electrical_node.dart';
import '../../../diagram/presentation/widgets/electrical_node_widget.dart';
import '../../../diagram/presentation/logic/auto_layout_service.dart';
import '../bloc/health_bloc.dart';
import 'manual_entry_form.dart';

/// Pantalla para seleccionar un componente del diagrama
/// y agregar una medición manual
class ComponentSelectorPage extends StatefulWidget {
  const ComponentSelectorPage({super.key});

  @override
  State<ComponentSelectorPage> createState() => _ComponentSelectorPageState();
}

class _ComponentSelectorPageState extends State<ComponentSelectorPage> {
  final TransformationController _transformController =
      TransformationController();
  String? _selectedNodeId;

  @override
  void dispose() {
    _transformController.dispose();
    super.dispose();
  }

  void _handleNodeTap(ElectricalNode node) {
    setState(() {
      _selectedNodeId = node.id;
    });

    // Mostrar el formulario de entrada manual
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ManualEntryForm(
          node: node,
          onSave: (measurement) {
            // Guardar la medición en el HealthBloc
            context.read<HealthBloc>().add(
                  AddFieldMeasurement(node.id, measurement),
                );
            // Volver atrás
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFF0F172A); // Slate 900

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Seleccionar Componente',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            Text(
              'Toca un componente para agregar medición',
              style: TextStyle(fontSize: 12, color: Colors.white54),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<DiagramCubit, DiagramState>(
        builder: (context, state) {
          if (state.root == null) {
            return const Center(
              child: Text(
                'No hay diagrama disponible',
                style: TextStyle(color: Colors.white54),
              ),
            );
          }

          // Calcular posiciones si no existen
          Map<String, Offset> positions = state.nodePositions;
          if (positions.isEmpty) {
            positions = AutoLayoutService.calculateLayout(state.root!);
          }

          return Column(
            children: [
              // Banner de instrucciones
              _buildInstructionBanner(),

              // Diagrama interactivo
              Expanded(
                child: InteractiveViewer(
                  transformationController: _transformController,
                  minScale: 0.5,
                  maxScale: 3.0,
                  boundaryMargin: const EdgeInsets.all(100),
                  child: CustomPaint(
                    size: Size.infinite,
                    painter: _GridPainter(),
                    child: Stack(
                      children: _buildNodeWidgets(
                        state.root!,
                        positions,
                        context,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInstructionBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.touch_app,
            color: Color(0xFF3B82F6),
            size: 32,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '¿Qué componente mediste?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Toca el componente en el diagrama para registrar su medición',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildNodeWidgets(
    ElectricalNode node,
    Map<String, Offset> positions,
    BuildContext context,
  ) {
    final List<Widget> widgets = [];

    // Construir widget para este nodo
    final position = positions[node.id];
    if (position != null) {
      widgets.add(
        Positioned(
          left: position.dx,
          top: position.dy,
          child: GestureDetector(
            onTap: () => _handleNodeTap(node),
            child: ElectricalNodeWidget(
              node: node,
              isSelected: _selectedNodeId == node.id,
              onTap: () => _handleNodeTap(node),
            ),
          ),
        ),
      );
    }

    // Recursión para hijos
    node.map(
      source: (n) {
        for (final child in n.children) {
          widgets.addAll(_buildNodeWidgets(child, positions, context));
        }
      },
      panel: (n) {
        for (final child in n.children) {
          widgets.addAll(_buildNodeWidgets(child, positions, context));
        }
      },
      protection: (n) {
        for (final child in n.children) {
          widgets.addAll(_buildNodeWidgets(child, positions, context));
        }
      },
      load: (_) {
        // Loads don't have children
      },
    );

    return widgets;
  }
}

// Grid Painter para el fondo
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF334155).withValues(alpha: 0.2)
      ..strokeWidth = 0.5;

    const gridSize = 30.0;

    // Vertical lines
    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }

    // Horizontal lines
    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
