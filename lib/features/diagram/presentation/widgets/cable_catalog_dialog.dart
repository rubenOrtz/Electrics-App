import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/catalog_metadata.dart';
import '../../../components/domain/entities/component_template.dart';
import '../../../components/presentation/bloc/component_library_cubit.dart';
import '../../../../injection_container.dart';
import '../../../../config/theme/app_themes.dart';

/// Dialog to browse and select cables from catalog
class CableCatalogDialog extends StatefulWidget {
  const CableCatalogDialog({super.key});

  @override
  State<CableCatalogDialog> createState() => _CableCatalogDialogState();
}

class _CableCatalogDialogState extends State<CableCatalogDialog> {
  CableMaterial _selectedMaterial = CableMaterial.copper;
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late final ComponentLibraryCubit _cubit;

  @override
  void initState() {
    super.initState();
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

  List<CableTemplate> _getFilteredCables(
      List<ComponentTemplate> allComponents) {
    // Filter only cable components
    var cables = allComponents
        .whereType<CableTemplate>()
        .where((c) => c.material == _selectedMaterial)
        .toList();

    if (_searchQuery.isNotEmpty) {
      cables = cables.where((c) {
        final query = _searchQuery.toLowerCase();
        return (c.manufacturer?.toLowerCase().contains(query) ?? false) ||
            c.name.toLowerCase().contains(query) ||
            (c.series?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    // Sort by section ascending
    cables.sort((a, b) => a.section.compareTo(b.section));

    return cables;
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
                  "Catálogo de Cables",
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
                hintText: "Buscar por marca, serie...",
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

            // Material filter
            Container(
              decoration: BoxDecoration(
                color: diagramTheme.nodeBg,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  _buildMaterialTab("Cobre", CableMaterial.copper, theme),
                  _buildMaterialTab("Aluminio", CableMaterial.aluminum, theme),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Cables list
            Expanded(
              child: BlocBuilder<ComponentLibraryCubit, ComponentLibraryState>(
                bloc: _cubit,
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final cables = _getFilteredCables(state.filteredComponents);

                  if (cables.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off,
                              size: 64, color: theme.disabledColor),
                          const SizedBox(height: 16),
                          Text("No se encontraron cables",
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
                    itemCount: cables.length + (state.hasReachedMax ? 0 : 1),
                    itemBuilder: (context, index) {
                      if (index >= cables.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      final cable = cables[index];
                      return _buildCableCard(cable, theme);
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

  Widget _buildMaterialTab(
      String label, CableMaterial material, ThemeData theme) {
    final isSelected = _selectedMaterial == material;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedMaterial = material),
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

  Widget _buildCableCard(CableTemplate cable, ThemeData theme) {
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
          // Return a map with both metadata AND the full cable specs
          Navigator.pop(
            context,
            {
              'metadata': CatalogMetadata(
                componentId: cable.id,
                brand: cable.manufacturer ?? "Generic",
                series: cable.series,
                reference: cable.id,
                displayName: cable.name,
              ),
              'cable': cable,
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
                        if (cable.manufacturer != null)
                          Text(
                            cable.manufacturer!,
                            style: TextStyle(
                              color: diagramTheme.accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        const SizedBox(height: 4),
                        Text(
                          cable.name,
                          style: TextStyle(
                              color: diagramTheme.textColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "ID: ${cable.id}",
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
                      if (cable.price != null)
                        Text(
                          "${cable.price!.toStringAsFixed(2)} €/m",
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
                  _buildSpec("${cable.section} mm²", theme, diagramTheme),
                  _buildSpec(
                      cable.material == CableMaterial.copper ? "Cu" : "Al",
                      theme,
                      diagramTheme),
                  _buildSpec(cable.insulationType, theme, diagramTheme),
                  _buildSpec(
                      "${cable.maxOperatingTemp}°C", theme, diagramTheme),
                  if (cable.installationMethod != null)
                    _buildSpec(cable.installationMethod!, theme, diagramTheme),
                  if (cable.series != null)
                    _buildSpec(cable.series!, theme, diagramTheme),
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
