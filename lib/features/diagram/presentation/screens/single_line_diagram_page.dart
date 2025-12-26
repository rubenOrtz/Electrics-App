import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Domain
import '../../domain/entities/electrical_node.dart';
import '../../domain/entities/electrical_enums.dart'; // NodeType
import '../../domain/entities/conductor_attributes.dart';
import '../../domain/entities/diagram_models.dart'; // DiagramNode

import '../../domain/services/tree_utilities.dart'; // Corrected Path

// Presentation - BLoC
import '../bloc/diagram_cubit.dart';
import '../bloc/diagram_state.dart';

// Presentation - Logic
import '../logic/auto_layout_service.dart';

// Presentation - Widgets
import '../widgets/diagram_top_bar.dart';
import '../widgets/diagram_bottom_panel.dart';
import '../widgets/diagram_floating_actions.dart';
import '../widgets/diagram_canvas.dart';
import '../widgets/onboarding_overlay.dart';
import '../widgets/circuit_config_sheet.dart';
import '../widgets/protection_config_sheet.dart';
import '../widgets/diagram_constants.dart';

// Other Features
import '../../../projects/presentation/bloc/project_cubit.dart';
import '../../../health/presentation/screens/health_dashboard_page.dart';
import '../../../health/presentation/bloc/health_bloc.dart';

// Config
import '../../../../config/theme/app_themes.dart';
import '../../../../injection_container.dart';
import '../../../../l10n/app_localizations.dart';

enum SelectMode {
  none,
  measurement,
  inspection,
}

class SingleLineDiagramPage extends StatefulWidget {
  final String projectId;
  final String title;
  final SelectMode selectMode;
  final Function(ElectricalNode)? onNodeSelected;
  final String? initialSelectedNodeId;

  const SingleLineDiagramPage({
    Key? key,
    required this.projectId,
    required this.title,
    this.selectMode = SelectMode.none,
    this.onNodeSelected,
    this.initialSelectedNodeId,
  }) : super(key: key);

  @override
  State<SingleLineDiagramPage> createState() => _SingleLineDiagramPageState();
}

class _SingleLineDiagramPageState extends State<SingleLineDiagramPage> {
  // Panel Rectangles for layout
  final Map<String, Rect> _panelRects = {};
  DiagramNode? _selectedNode;
  int _selectedTab = 0; // 0: Diagram, 1: Health, 2: Budget
  bool _hasAutoCentered = false;
  final TransformationController _transformController =
      TransformationController();

  // Dragging & Alignment
  String? _draggingNodeId;
  final List<double> _horizontalGuides = [];
  final List<double> _verticalGuides = [];

  @override
  void initState() {
    super.initState();
    // Pre-center view roughly
    // Pre-center view roughly
    _transformController.value = Matrix4.translationValues(-2200.0, -50.0, 0.0);
  }

  @override
  void dispose() {
    _transformController.dispose();
    super.dispose();
  }

  /// Build visual nodes from cubit state positions and tree structure
  List<DiagramNode> _buildVisualNodesFromState(DiagramState state) {
    if (state.root == null) return [];

    final List<DiagramNode> nodes = [];
    final positions = state.nodePositions;

    // Traverse tree and build visual nodes for each positioned node
    void traverse(ElectricalNode node) {
      if (positions.containsKey(node.id)) {
        final type = _mapDomainTypeToVisual(node);
        final position = positions[node.id]!;

        nodes.add(DiagramNode(
          id: node.id,
          type: type,
          position: position,
          properties: TreeUtilities.extractProperties(node),
          relatedNode: node,
        ));
      }

      // Recursively traverse children
      node.maybeMap(
        source: (n) => n.children.forEach(traverse),
        panel: (n) => n.children.forEach(traverse),
        protection: (n) => n.children.forEach(traverse),
        orElse: () {},
      );
    }

    traverse(state.root!);
    return nodes;
  }

  @override
  Widget build(BuildContext context) {
    // Determine Theme
    final theme = Theme.of(context);
    final diagramTheme = theme.extension<DiagramTheme>()!;

    final l10n = AppLocalizations.of(context)!;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = sl<DiagramCubit>();
            final projectState = context.read<ProjectCubit>().state;
            if (projectState.root != null) {
              cubit.setRoot(projectState.root!);
            } else {
              // Fallback / Initial blank project
              cubit.setRoot(ElectricalNode.source(
                  id: const Uuid().v4(), name: l10n.acometida));
            }
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final diagramCubit = context.read<DiagramCubit>();
            return HealthBloc(diagramCubit: diagramCubit);
          },
        )
      ],
      child: BlocConsumer<DiagramCubit, DiagramState>(
        listenWhen: (previous, current) {
          if (widget.initialSelectedNodeId != null &&
              current.root != null &&
              _selectedNode == null) {
            return true;
          }
          return (previous.root != null && current.root != previous.root) ||
              (previous.status != current.status &&
                  current.status == DiagramStatus.ready);
        },
        listener: (context, state) {
          _handleStateChanges(context, state);
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: diagramTheme.canvasBg,
            body: SafeArea(
              child: Column(
                children: [
                  // 1. Top Bar
                  // 1. Top Bar
                  DiagramTopBar(
                    title: context.select(
                        (ProjectCubit cubit) => cubit.state.projectName),
                    subtitle: _selectedTab == 0
                        ? l10n.singleLineDiagram
                        : _selectedTab == 1
                            ? "Diagnóstico"
                            : "Presupuesto",
                    selectedTab: _selectedTab,
                    onBackPressed: () => Navigator.of(context).pop(),
                    onBudgetPressed: () {
                      setState(() => _selectedTab = 2);
                    },
                    onTabChanged: (index) {
                      setState(() => _selectedTab = index);
                    },
                    isSelectionMode: widget.selectMode != SelectMode.none,
                  ),

                  // 2. Main Content Area
                  Expanded(
                    child: _buildContent(context, state, diagramTheme, l10n),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, DiagramState state,
      DiagramTheme diagramTheme, AppLocalizations l10n) {
    if (_selectedTab == 1) {
      // Health Dashboard requires title
      return HealthDashboardPage(
        projectId: widget.projectId,
        title: widget.title,
      );
    }
    if (_selectedTab == 2) {
      return Center(child: Text(l10n.budgetComingSoon));
    }

    // Default: Diagram View
    if (state.root == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // CRITICAL: Ensure positions are calculated before rendering
    // If positions are empty, calculate them synchronously
    Map<String, Offset> positions = state.nodePositions;
    if (positions.isEmpty && state.root != null) {
      positions = AutoLayoutService.calculateLayout(state.root!);
      // Update cubit state with calculated positions (this will trigger a rebuild)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final cubit = context.read<DiagramCubit>();
        for (var entry in positions.entries) {
          cubit.updateNodePosition(entry.key, entry.value, saveState: false);
        }
      });
    }

    // Build visual nodes from current state positions
    final visualNodes =
        _buildVisualNodesFromState(state.copyWith(nodePositions: positions));

    return Column(
      children: [
        // Banner de instrucciones para modo medición
        if (widget.selectMode == SelectMode.measurement)
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: diagramTheme.accentColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: diagramTheme.accentColor.withValues(alpha: 0.4),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.touch_app,
                  color: diagramTheme.accentColor,
                  size: 32,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.whatComponentMeasure,
                        style: TextStyle(
                          color: diagramTheme.textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.tapComponentMeasure,
                        style: TextStyle(
                          color: diagramTheme.textColor.withValues(alpha: 0.7),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        // Diagrama
        Expanded(
          child: Stack(
            children: [
              // A. Canvas
              Positioned.fill(
                child: DiagramCanvas(
                  transformController: _transformController,
                  diagramTheme: diagramTheme,
                  root: state.root!,
                  nodePositions: positions, // Use locally calculated positions
                  panelRects: _panelRects,
                  panelNames: TreeUtilities.extractPanelNames(state.root!),
                  visualNodes: visualNodes,
                  selectedNode: _selectedNode,
                  draggingNodeId: _draggingNodeId,
                  verticalGuides: _verticalGuides,
                  horizontalGuides: _horizontalGuides,
                  onBackgroundTap: (_) {
                    if (_selectedNode != null) {
                      setState(() => _selectedNode = null);
                    }
                  },
                  onNodeSelected: (node) {
                    // Si estamos en modo de selección para mediciones
                    if (widget.selectMode == SelectMode.measurement &&
                        widget.onNodeSelected != null) {
                      // Llamar al callback y no cambiar el estado local
                      widget.onNodeSelected!(node.relatedNode!);
                      return;
                    }

                    // Modo normal: actualizar selección local
                    setState(() => _selectedNode = node);
                    HapticFeedback.selectionClick();
                  },
                  onNodeDroppedOnPanel: (details, panelId) {
                    _addChildToId(context, panelId, details.data);
                  },
                ),
              ),

              // B. Floating Actions (Undo/Redo/Delete) - Top Left
              if (widget.selectMode == SelectMode.none)
                Positioned(
                  left: 16,
                  top: 16,
                  child: DiagramFloatingActions(
                    onUndo: state.canUndo
                        ? () => context.read<DiagramCubit>().undo()
                        : null,
                    onRedo: state.canRedo
                        ? () => context.read<DiagramCubit>().redo()
                        : null,
                    onDelete: () {
                      if (_selectedNode != null) {
                        _deleteNode(context, _selectedNode!);
                      }
                    },
                  ),
                ),

              // C. Zoom Controls - Top Right
              if (widget.selectMode == SelectMode.none)
                Positioned(
                  right: 16,
                  top: 16,
                  child: Column(
                    children: [
                      DiagramActionButton(
                        icon: Icons.add,
                        onPressed: () => _applyZoom(1.2),
                      ),
                      const SizedBox(height: 12),
                      DiagramActionButton(
                        icon: Icons.remove,
                        onPressed: () => _applyZoom(0.8),
                      ),
                    ],
                  ),
                ),

              // D. Bottom Panel (Palette + Properties) - Oculto en modo medición
              if (widget.selectMode == SelectMode.none)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: DiagramBottomPanel(
                    selectedNode: _selectedNode,
                    onAddNode: (type) {
                      // If a node is selected, add as child; otherwise create root
                      if (_selectedNode != null) {
                        _addChildToId(context, _selectedNode!.id, type);
                      } else {
                        _addRoot(context, type);
                      }
                    },
                    onEditAdvanced: () {
                      if (_selectedNode != null &&
                          _selectedNode!.relatedNode != null) {
                        _showEditSheet(context, _selectedNode!.relatedNode!);
                      }
                    },
                  ),
                ),

              // E. Onboarding - Only show if diagram is completely empty
              if (state.root == null) const OnboardingOverlay(),
            ],
          ), // Cierre del Stack
        ), // Cierre del Expanded
      ], // Cierre de children de Column
    ); // Cierre de Column
  }

  // Logic Methods

  void _handleStateChanges(BuildContext context, DiagramState state) {
    final projectCubit = context.read<ProjectCubit>();

    // Initial Selection logic
    if (widget.initialSelectedNodeId != null &&
        state.root != null &&
        _selectedNode == null &&
        state.nodePositions.isNotEmpty) {
      final id = widget.initialSelectedNodeId!;
      if (state.nodePositions.containsKey(id)) {
        final pos = state.nodePositions[id]!;
        final domainNode = TreeUtilities.findNodeById(state.root!, id);
        if (domainNode != null) {
          final type = _mapDomainTypeToVisual(domainNode);
          setState(() {
            _selectedNode = DiagramNode(
                id: id,
                type: type,
                position: pos,
                properties: TreeUtilities.extractProperties(domainNode),
                relatedNode: domainNode);
            _hasAutoCentered = true;
          });
        }
      }
    }

    // REFRESH SELECTED NODE IF STATE CHANGED
    // Esto asegura que si se editan propiedades, el panel inferior muestre los datos nuevos inmediatamente
    if (_selectedNode != null && state.root != null) {
      final updatedNode =
          TreeUtilities.findNodeById(state.root!, _selectedNode!.id);
      if (updatedNode != null) {
        // Encontramos el nodo actualizado en el nuevo árbol
        // Necesitamos su posición también (que puede no haber cambiado)
        final pos =
            state.nodePositions[_selectedNode!.id] ?? _selectedNode!.position;
        final type = _mapDomainTypeToVisual(updatedNode);

        // Solo setState si realmente hay cambios en las propiedades o nodo
        // para evitar loops infinitos, aunque BlocListener suele proteger de eso.
        // Aquí asumimos que si el root cambió, debemos refrescar.
        // Hacemos un check simple de identidad para no redibujar a lo loco si es identico objeto (raro con freezed)
        if (updatedNode != _selectedNode!.relatedNode) {
          setState(() {
            _selectedNode = DiagramNode(
                id: updatedNode.id,
                type: type,
                position: pos,
                properties: TreeUtilities.extractProperties(updatedNode),
                relatedNode: updatedNode);
          });
        }
      } else {
        // El nodo seleccionado fue borrado
        setState(() {
          _selectedNode = null;
        });
      }
    }

    // Auto-layout on any root update (Always enforce structure)
    // Removed nodePositions.isEmpty check to ensure new nodes are laid out
    if (state.root != null) {
      // Use microtask to avoid setState during build or listener collision
      Future.microtask(() {
        _runAutoLayout(context);
        if (!_hasAutoCentered) {
          Future.delayed(const Duration(milliseconds: 100), () {
            _centerViewOnDiagram(context);
            _hasAutoCentered = true;
          });
        }
      });
    }

    // Auto-save
    if (state.root != null) {
      projectCubit.updateRoot(state.root!);
      projectCubit.saveProject();
    }
  }

  void _runAutoLayout(BuildContext context) {
    final diagramCubit = context.read<DiagramCubit>();
    final root = diagramCubit.state.root;
    if (root == null) {
      setState(() => _panelRects.clear());
      return;
    }

    final positions = AutoLayoutService.calculateLayout(root);
    final panels =
        AutoLayoutService.calculatePanelRects(root: root, positions: positions);

    setState(() {
      _panelRects.clear();
      _panelRects.addAll(panels);
    });

    for (var entry in positions.entries) {
      diagramCubit.updateNodePosition(entry.key, entry.value, saveState: false);
    }
  }

  void _applyZoom(double factor) {
    final currentScale = _transformController.value.getMaxScaleOnAxis();

    // Limits
    if (factor > 1 && currentScale >= 4.0) return;
    if (factor < 1 && currentScale <= 0.2) return;

    // Use screen center as pivot
    final size = MediaQuery.of(context).size;
    final center = Offset(size.width / 2, size.height / 2);

    final matrix = _transformController.value;
    final translate = Matrix4.translationValues(center.dx, center.dy, 0);
    final scaleM = Matrix4.diagonal3Values(factor, factor, 1.0);
    final untranslate = Matrix4.translationValues(-center.dx, -center.dy, 0);

    setState(() {
      _transformController.value = translate * scaleM * untranslate * matrix;
    });
  }

  void _centerViewOnDiagram(BuildContext context) {
    final diagramCubit = context.read<DiagramCubit>();
    final positions = diagramCubit.state.nodePositions;

    if (positions.isEmpty) return;

    // Calculate bounds of all nodes
    double minX = double.infinity;
    double minY = double.infinity;
    double maxX = -double.infinity;
    double maxY = -double.infinity;

    const nodeWidth = kNodeWidth;
    const nodeHeight = kNodeHeight;

    for (final pos in positions.values) {
      if (pos.dx < minX) minX = pos.dx;
      if (pos.dy < minY) minY = pos.dy;
      if (pos.dx + nodeWidth > maxX) maxX = pos.dx + nodeWidth;
      if (pos.dy + nodeHeight > maxY) maxY = pos.dy + nodeHeight;
    }

    // Get the actual InteractiveViewer size from RenderBox
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box == null) return;

    final viewportWidth = box.size.width;
    final viewportHeight = box.size.height;

    // Calculate diagram content bounds
    final diagramWidth = maxX - minX;
    final diagramHeight = maxY - minY;

    // Add 10% padding
    final paddingX = viewportWidth * 0.1;
    final paddingY = viewportHeight * 0.1;

    // Calculate scale to fit
    final scaleX = (viewportWidth - 2 * paddingX) / diagramWidth;
    final scaleY = (viewportHeight - 2 * paddingY) / diagramHeight;
    final scale = (scaleX < scaleY ? scaleX : scaleY).clamp(0.2, 2.0);

    // Calculate centers
    final contentCenterX = (minX + maxX) / 2;
    final contentCenterY = (minY + maxY) / 2;
    final viewportCenterX = viewportWidth / 2;
    final viewportCenterY = viewportHeight / 2;

    // Simple centering transformation
    final translateX = viewportCenterX - (contentCenterX * scale);
    final translateY = viewportCenterY - (contentCenterY * scale);

    // Apply transformation
    _transformController.value =
        Matrix4.translationValues(translateX, translateY, 0.0)
          ..multiply(Matrix4.diagonal3Values(scale, scale, 1.0));
  }

  NodeType _mapDomainTypeToVisual(ElectricalNode node) {
    return node.map(
      source: (_) => NodeType.supply,
      panel: (_) => NodeType.panel,
      protection: (p) {
        switch (p.protectionType) {
          case ProtectionType.circuitBreaker:
            return NodeType.breaker;
          case ProtectionType.differential:
            return NodeType.differential;
          default:
            return NodeType.breaker;
        }
      },
      load: (_) => NodeType.load,
    );
  }

  void _addChildToId(BuildContext context, String parentId, NodeType type) {
    final cubit = context.read<DiagramCubit>();
    final newNode = _createNodeFromType(context, type);

    // Estimate position (center of screen or offset)
    final pos = Offset(200, 200);

    cubit.addChild(parentId, newNode, pos);
  }

  void _addRoot(BuildContext context, NodeType type) {
    final cubit = context.read<DiagramCubit>();
    if (cubit.state.root == null) {
      cubit.setRoot(_createNodeFromType(context, type));
    }
  }

  ElectricalNode _createNodeFromType(BuildContext context, NodeType type) {
    final id = const Uuid().v4();
    final l10n = AppLocalizations.of(context)!;

    switch (type) {
      case NodeType.supply:
        return SourceNode(
          id: id,
          name: l10n.acometida,
          nominalVoltage: 230,
        );
      case NodeType.panel:
        return PanelNode(id: id, name: l10n.panel, children: []);
      case NodeType.breaker:
        return ProtectionNode(
            id: id,
            name: l10n.elemBreaker,
            protectionType: ProtectionType.circuitBreaker,
            ratingAmps: 16);
      case NodeType.differential:
        return ProtectionNode(
            id: id,
            name: l10n.elemDifferential,
            protectionType: ProtectionType.differential,
            ratingAmps: 40,
            sensitivity: 30.0);
      case NodeType.load:
        return LoadNode(id: id, name: l10n.power, powerWatts: 1000);
      default:
        return LoadNode(id: id, name: l10n.elemLoad, powerWatts: 0);
    }
  }

  void _deleteNode(BuildContext context, DiagramNode node) {
    // Basic implementation: Delete directly
    context.read<DiagramCubit>().removeNode(node.id);

    setState(() {
      _selectedNode = null;
    });
  }

  void _showEditSheet(BuildContext context, ElectricalNode node) {
    final cubit = context.read<DiagramCubit>();
    final l10n = AppLocalizations.of(context)!;

    // Safety check just in case, although protected by types
    if (node is! ProtectionNode && node is! LoadNode) {
      showModalBottomSheet(
          context: context,
          builder: (ctx) => SizedBox(
              height: 200, child: Center(child: Text(l10n.editNotAvailable))));
      return;
    }

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (ctx) {
          // Get the latest node from cubit state to ensure we have updated data
          ElectricalNode latestNode = node;
          final state = cubit.state;
          if (state.root != null) {
            latestNode = _findNodeById(state.root!, node.id) ?? node;
          }

          if (latestNode is ProtectionNode) {
            return ProtectionConfigSheet(
              initialData: ProtectionConfigData(
                type: latestNode.protectionType,
                ratingAmps: latestNode.ratingAmps,
                poles: latestNode.poles,
                curve: latestNode.curve,
                sensitivityMa: latestNode.sensitivity,
                breakingCapacityKa: latestNode.pdc ?? 6.0,
                inputCableSection: null, // Protection nodes don't have cables
                catalogData: latestNode.catalogData,
                cableCatalogData: latestNode.cableCatalogData,
              ),
              onSave: (data) async {
                await cubit.updateNodeProperties(latestNode.id, (n) {
                  if (n is! ProtectionNode) return n;

                  // Protection nodes don't have cables
                  return n.copyWith(
                    protectionType: data.type,
                    ratingAmps: data.ratingAmps,
                    poles: data.poles,
                    curve: data.curve,
                    sensitivity: data.sensitivityMa,
                    pdc: data.breakingCapacityKa,
                    catalogData: data.catalogData,
                    cableCatalogData: data.cableCatalogData,
                  );
                });
                if (ctx.mounted) Navigator.pop(ctx);
              },
              onCancel: () => Navigator.pop(ctx),
            );
          }
          if (latestNode is LoadNode) {
            return CircuitConfigSheet(
              initialData: CircuitConfigData(
                type: latestNode.type,
                isThreePhase: latestNode.isThreePhase,
                powerKw: latestNode.powerWatts / 1000,
                cosPhi: latestNode.cosPhi,
                lengthMeters: latestNode.inputCable?.lengthMeters ?? 10,
                sectionMm2: latestNode.inputCable?.sectionMm2,
                installMethod:
                    latestNode.inputCable?.method ?? InstallationMethod.b1,
                insulation:
                    latestNode.inputCable?.insulation ?? CableInsulation.pvc,
                correctionFactors: latestNode.inputCable?.factors,
                cableCatalogData: latestNode.cableCatalogData,
              ),
              onSave: (data) async {
                await cubit.updateNodeProperties(latestNode.id, (n) {
                  if (n is! LoadNode) return n;

                  final updatedCable = n.inputCable?.copyWith(
                          lengthMeters: data.lengthMeters,
                          sectionMm2: data.sectionMm2 ?? 2.5,
                          method: data.installMethod,
                          insulation: data.insulation,
                          factors: data.correctionFactors ??
                              const CorrectionFactors()) ??
                      ConductorAttributes(
                          lengthMeters: data.lengthMeters,
                          sectionMm2: data.sectionMm2 ?? 2.5,
                          material: ConductorMaterial.copper,
                          insulation: data.insulation,
                          method: data.installMethod,
                          factors: data.correctionFactors ??
                              const CorrectionFactors(),
                          label: "Cable");

                  return n.copyWith(
                      powerWatts: data.powerKw * 1000,
                      cosPhi: data.cosPhi,
                      type: data.type,
                      isThreePhase: data.isThreePhase,
                      inputCable: updatedCable,
                      cableCatalogData: data.cableCatalogData);
                });
                if (ctx.mounted) Navigator.pop(ctx);
              },
              onCancel: () => Navigator.pop(ctx),
            );
          }
          return SizedBox(
              height: 200, child: Center(child: Text(l10n.editNotAvailable)));
        });
  }

  // Helper method to find a node by ID recursively
  ElectricalNode? _findNodeById(ElectricalNode root, String id) {
    if (root.id == id) return root;

    return root.map(
      source: (node) {
        for (final child in node.children) {
          final found = _findNodeById(child, id);
          if (found != null) return found;
        }
        return null;
      },
      panel: (node) {
        for (final child in node.children) {
          final found = _findNodeById(child, id);
          if (found != null) return found;
        }
        return null;
      },
      protection: (node) {
        for (final child in node.children) {
          final found = _findNodeById(child, id);
          if (found != null) return found;
        }
        return null;
      },
      load: (_) => null,
    );
  }
}
