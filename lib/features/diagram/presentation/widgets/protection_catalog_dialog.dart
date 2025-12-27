import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/catalog_metadata.dart';
import '../../../components/domain/entities/component_template.dart';
import '../../../components/presentation/bloc/component_library_cubit.dart';
import '../../../../injection_container.dart';
import '../../../../config/theme/app_themes.dart';

/// Dialog to browse and select protection devices from catalog
class ProtectionCatalogDialog extends StatefulWidget {
  final ProtectionDeviceType initialType;

  const ProtectionCatalogDialog({
    super.key,
    required this.initialType,
  });

  @override
  State<ProtectionCatalogDialog> createState() =>
      _ProtectionCatalogDialogState();
}

class _ProtectionCatalogDialogState extends State<ProtectionCatalogDialog> {
  ProtectionDeviceType _selectedType = ProtectionDeviceType.circuitBreaker;
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final ComponentLibraryCubit _cubit;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialType;
    _cubit = sl<ComponentLibraryCubit>();
    _scrollController.addListener(_onScroll);
    _cubit.loadAll();
  }

  void _onScroll() {
    if (_isBottom) {
      _cubit.loadMore();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.7);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<ProtectionTemplate> _getFilteredProducts(
      List<ComponentTemplate> allComponents) {
    // Filter only protection components
    var products = allComponents
        .whereType<ProtectionTemplate>()
        .where((p) => p.deviceType == _selectedType)
        .toList();

    if (_searchQuery.isNotEmpty) {
      products = products.where((p) {
        final query = _searchQuery.toLowerCase();
        return (p.manufacturer?.toLowerCase().contains(query) ?? false) ||
            p.name.toLowerCase().contains(query) ||
            (p.series?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final diagramTheme = theme.extension<DiagramTheme>()!;

    return Dialog(
      backgroundColor: diagramTheme.panelBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 700, maxHeight: 800),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Catálogo de Productos",
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Search bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Buscar por marca, referencia...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: diagramTheme.nodeBg,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: diagramTheme.nodeBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: diagramTheme.nodeBorder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: diagramTheme.accentColor),
                ),
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
            const SizedBox(height: 16),

            // Type filter
            Container(
              decoration: BoxDecoration(
                color: diagramTheme.nodeBg,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  _buildTypeTab("Magnetotérmicos",
                      ProtectionDeviceType.circuitBreaker, theme),
                  _buildTypeTab("Diferenciales",
                      ProtectionDeviceType.differential, theme),
                  _buildTypeTab("Fusibles", ProtectionDeviceType.fuse, theme),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Products list
            Expanded(
              child: BlocBuilder<ComponentLibraryCubit, ComponentLibraryState>(
                bloc: _cubit,
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final products =
                      _getFilteredProducts(state.filteredComponents);

                  if (products.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off,
                              size: 64, color: theme.disabledColor),
                          const SizedBox(height: 16),
                          Text("No se encontraron productos",
                              style: TextStyle(color: theme.disabledColor)),
                          const SizedBox(height: 8),
                          if (state.allComponents.isEmpty)
                            TextButton(
                              onPressed: () => _cubit.loadSeedData(),
                              child: const Text("Cargar datos de ejemplo"),
                            ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: products.length + (state.hasReachedMax ? 0 : 1),
                    itemBuilder: (context, index) {
                      if (index >= products.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      final product = products[index];
                      return _buildProductCard(product, theme);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeTab(
      String label, ProtectionDeviceType type, ThemeData theme) {
    final isSelected = _selectedType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedType = type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? theme
                    .extension<DiagramTheme>()!
                    .accentColor
                    .withValues(alpha: 0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isSelected
                ? Border.all(
                    color: theme.extension<DiagramTheme>()!.accentColor)
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? theme.extension<DiagramTheme>()!.accentColor
                    : theme.disabledColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(ProtectionTemplate product, ThemeData theme) {
    final diagramTheme = theme.extension<DiagramTheme>()!;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: diagramTheme.nodeBg,
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: diagramTheme.nodeBorder)),
      child: InkWell(
        onTap: () {
          // Return a map with both metadata AND the full product specs
          Navigator.pop(
            context,
            {
              'metadata': CatalogMetadata(
                componentId: product.id,
                brand: product.manufacturer ?? "Generic",
                series: product.series,
                reference: product.id,
                displayName: product.name,
              ),
              'product': product,
            },
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (product.manufacturer != null)
                          Text(
                            product.manufacturer!,
                            style: TextStyle(
                              color: diagramTheme.accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        const SizedBox(height: 4),
                        Text(
                          product.name,
                          style: TextStyle(
                              color: diagramTheme.textColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "ID: ${product.id}",
                          style: TextStyle(
                            color: theme.disabledColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (product.price != null)
                        Text(
                          "${product.price!.toStringAsFixed(2)} €",
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: diagramTheme.accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color:
                              diagramTheme.accentColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "Vincular",
                          style: TextStyle(
                            color: diagramTheme.accentColor,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  _buildSpec("${product.ratedCurrent.toStringAsFixed(0)}A",
                      theme, diagramTheme),
                  _buildSpec("Curva ${product.curveType}", theme, diagramTheme),
                  if (product.sensitivity != null)
                    _buildSpec("${product.sensitivity}mA", theme, diagramTheme),
                  _buildSpec("${product.poles}P", theme, diagramTheme),
                  _buildSpec(
                      "${product.breakingCapacity}kA", theme, diagramTheme),
                  if (product.series != null)
                    _buildSpec(product.series!, theme, diagramTheme),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpec(String text, ThemeData theme, DiagramTheme diagramTheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: diagramTheme.canvasBg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: diagramTheme.textColor.withValues(alpha: 0.7),
          fontSize: 11,
        ),
      ),
    );
  }
}
