import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:electrician_app/l10n/app_localizations.dart';
import '../../domain/entities/component_template.dart';
import '../../domain/repositories/component_repository.dart';
import '../bloc/component_library_cubit.dart';
import 'component_detail_page.dart';

class ComponentLibraryPage extends StatefulWidget {
  final bool isPicker;
  final String? filterType; // NEW: Filter by component type

  const ComponentLibraryPage({
    super.key,
    this.isPicker = false,
    this.filterType,
  });

  @override
  State<ComponentLibraryPage> createState() => _ComponentLibraryPageState();
}

class _ComponentLibraryPageState extends State<ComponentLibraryPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  ComponentType? _selectedFilter;

  @override
  void initState() {
    super.initState();

    // Setup scroll listener for pagination
    _scrollController.addListener(_onScroll);

    // Apply initial filter from route arguments
    if (widget.filterType != null) {
      _selectedFilter = _parseFilterType(widget.filterType!);
      if (_selectedFilter != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<ComponentLibraryCubit>().filterByType(_selectedFilter!);
        });
      }
    } else {
      // Load all components if no filter is provided
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<ComponentLibraryCubit>().loadAll();
      });
    }
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ComponentLibraryCubit>().loadMore();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.7); // Trigger at 70% scroll
  }

  ComponentType? _parseFilterType(String type) {
    switch (type.toLowerCase()) {
      case 'protection':
        return ComponentType.protection;
      case 'cable':
        return ComponentType.cable;
      case 'source':
        return ComponentType.source;
      default:
        return null;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isPicker
            ? AppLocalizations.of(context)!.selectComponent
            : AppLocalizations.of(context)!.componentLibraryTitle),
        actions: [
          if (!widget.isPicker)
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                // Show filter options
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.searchComponents,
                    prefixIcon: Icon(Icons.search,
                        color: Theme.of(context).colorScheme.primary),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              context
                                  .read<ComponentLibraryCubit>()
                                  .searchComponents('');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest
                        .withValues(alpha: 0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outline),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outlineVariant),
                    ),
                  ),
                  onChanged: (query) {
                    context
                        .read<ComponentLibraryCubit>()
                        .searchComponents(query);
                  },
                ),
                const SizedBox(height: 12),
                // Filter chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip(context, null,
                          AppLocalizations.of(context)!.filterAll, Icons.apps),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                          context,
                          ComponentType.protection,
                          AppLocalizations.of(context)!.filterProtection,
                          Icons.shield),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                          context,
                          ComponentType.cable,
                          AppLocalizations.of(context)!.filterCable,
                          Icons.cable),
                      const SizedBox(width: 8),
                      _buildFilterChip(
                          context,
                          ComponentType.source,
                          AppLocalizations.of(context)!.filterSource,
                          Icons.power),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Component list
          Expanded(
            child: BlocBuilder<ComponentLibraryCubit, ComponentLibraryState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.error != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(state.error!),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<ComponentLibraryCubit>().loadAll();
                          },
                          child: Text(AppLocalizations.of(context)!.retry),
                        ),
                      ],
                    ),
                  );
                }

                final components = state.filteredComponents;

                if (components.isEmpty) {
                  return _buildEmptyState(context);
                }

                return ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: components.length + (state.hasReachedMax ? 0 : 1),
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    if (index >= components.length) {
                      // Loading indicator at bottom
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    final component = components[index];
                    return _buildComponentCard(context, component);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: widget.isPicker
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                // Navigate to create component page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<ComponentLibraryCubit>(),
                      child: const ComponentDetailPage(isNewComponent: true),
                    ),
                  ),
                );
              },
              backgroundColor: Theme.of(context).colorScheme.primary,
              icon: Icon(Icons.add,
                  color: Theme.of(context).colorScheme.onPrimary),
              label: Text(AppLocalizations.of(context)!.newComponent,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary)),
            ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    ComponentType? type,
    String label,
    IconData icon,
  ) {
    final isSelected = _selectedFilter == type;

    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              size: 16,
              color: isSelected
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.primary),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = selected ? type : null;
        });
        context.read<ComponentLibraryCubit>().filterByType(type);
      },
      selectedColor: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context)
          .colorScheme
          .surfaceContainerHighest
          .withValues(alpha: 0.5),
      labelStyle: TextStyle(
        color: isSelected
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.onSurface,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      checkmarkColor: Theme.of(context).colorScheme.onPrimary,
    );
  }

  Widget _buildComponentCard(
    BuildContext context,
    ComponentTemplate component,
  ) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          if (widget.isPicker) {
            // Picker mode: return selected component and close
            Navigator.of(context).pop(component);
          } else {
            // Normal mode: navigate to detail page
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<ComponentLibraryCubit>(),
                  child: ComponentDetailPage(component: component),
                ),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _getComponentColor(component).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getComponentIcon(component),
                  color: _getComponentColor(component),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            component.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        if (component.isFavorite)
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (component.manufacturer != null)
                      Text(
                        component.manufacturer!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: _buildComponentSpecs(context, component)),
                        // Price display
                        if (component.price != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '€${component.price!.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              // Arrow
              Icon(Icons.chevron_right,
                  color: Theme.of(context).colorScheme.outline),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComponentSpecs(
    BuildContext context,
    ComponentTemplate component,
  ) {
    return component.when(
      protection: (id, name, manufacturer, series, isFavorite, ratedCurrent,
          curveType, breakingCapacity, poles, deviceType, sensitivity, price) {
        return Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            _buildSpecChip('${ratedCurrent.toStringAsFixed(0)}A'),
            _buildSpecChip('Curva $curveType'),
            _buildSpecChip('${poles}P'),
          ],
        );
      },
      cable: (id, name, manufacturer, series, isFavorite, section, material,
          insulationType, maxOperatingTemp, installationMethod, price) {
        return Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            _buildSpecChip('${section}mm²'),
            _buildSpecChip(material == CableMaterial.copper ? 'Cu' : 'Al'),
            _buildSpecChip(insulationType),
          ],
        );
      },
      source: (id, name, manufacturer, series, isFavorite, voltage,
          maxShortCircuitCurrent, ratedPower, sourceType, price) {
        return Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            _buildSpecChip('${voltage.toStringAsFixed(0)}V'),
            _buildSpecChip(
              '${(maxShortCircuitCurrent).toStringAsFixed(1)}kA',
            ),
          ],
        );
      },
    );
  }

  Widget _buildSpecChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined,
              size: 80, color: Theme.of(context).colorScheme.outlineVariant),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.noComponentsFound,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.createFirstComponent,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  IconData _getComponentIcon(ComponentTemplate component) {
    return component.when(
      protection: (_, __, ___, ____, _____, ______, _______, ________,
              _________, __________, ___________, param) =>
          Icons.security,
      cable: (_, __, ___, ____, _____, ______, _______, ________, _________,
              __________, param) =>
          Icons.cable,
      source: (_, __, ___, ____, _____, ______, _______, ________, _________,
              param) =>
          Icons.electrical_services,
    );
  }

  Color _getComponentColor(ComponentTemplate component) {
    return component.when(
      protection: (_, __, ___, ____, _____, ______, _______, ________,
              _________, __________, ___________, param) =>
          Colors.blue,
      cable: (_, __, ___, ____, _____, ______, _______, ________, _________,
              __________, param) =>
          Colors.orange,
      source: (_, __, ___, ____, _____, ______, _______, ________, _________,
              param) =>
          Colors.purple,
    );
  }
}
