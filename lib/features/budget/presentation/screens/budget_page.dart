import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/budget_item.dart';
import '../../../../features/projects/domain/entities/budget_config.dart';
import '../../../../features/projects/presentation/bloc/project_cubit.dart';
import '../cubit/budget_cubit.dart';
import '../cubit/budget_state.dart';
import '../widgets/budget_config_dialog.dart';
import 'package:printing/printing.dart';
import '../../../reports/data/generators/budget_pdf_generator.dart';
import '../../../../features/projects/domain/entities/project.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key}) : super(key: key);

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Refresh budget with project config
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final projectCubit = context.read<ProjectCubit>();
      final config = projectCubit.state.budgetConfig;
      final root = projectCubit.state.root;
      if (config != null && root != null) {
        context.read<BudgetCubit>().loadBudget(root, config: config);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text("Presupuesto y Materiales",
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.blueAccent),
            onPressed: () => _openConfigDialog(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blueAccent,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blueAccent,
          tabs: const [
            Tab(text: "Resumen"),
            Tab(text: "Desglose"),
          ],
        ),
      ),
      body: BlocBuilder<BudgetCubit, BudgetState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(
                child: Text("No hay elementos para presupuestar"));
          }
          return TabBarView(
            controller: _tabController,
            children: [
              _buildSummaryTab(state),
              _buildBreakdownTab(state),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _exportPdf(context),
        icon: const Icon(Icons.picture_as_pdf),
        label: const Text("Exportar PDF"),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  Widget _buildSummaryTab(BudgetState state) {
    // Colors for chart
    final categoryColors = {
      BudgetCategory.protection: Colors.blue,
      BudgetCategory.cable: Colors.orange,
      BudgetCategory.enclosure: Colors.grey,
      BudgetCategory.generic: Colors.purple,
    };

    // Prepare chart data
    Map<BudgetCategory, double> categoryTotals = {};
    for (var item in state.items) {
      categoryTotals.update(item.category, (val) => val + item.total,
          ifAbsent: () => item.total);
    }

    final sections = categoryTotals.entries.map((e) {
      final total = state.netTotal > 0 ? state.netTotal : 1.0;
      final percent = (e.value / total) * 100;
      return PieChartSectionData(
        value: e.value,
        title: '${percent.toStringAsFixed(0)}%',
        color: categoryColors[e.key] ?? Colors.black,
        radius: 50,
        titleStyle: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
      );
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Total Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4))
              ],
            ),
            child: Column(
              children: [
                const Text("Coste Total Estimado",
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                Text(
                  "${state.finalTotal.toStringAsFixed(2)} €",
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
                const Divider(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Neto",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                          Text("${state.netTotal.toStringAsFixed(2)} €",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Beneficio (${state.marginPercent.toInt()}%)",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.green)),
                          Text("+${state.marginAmount.toStringAsFixed(2)} €",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                        ]),
                  ],
                ),
                if (state.includeTax)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("IVA (21%)",
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                        Text("+${state.taxAmount.toStringAsFixed(2)} €",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent)),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Donut Chart
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                sections: sections,
                centerSpaceRadius: 40,
                sectionsSpace: 2,
              ),
            ),
          ),

          // Legend
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: categoryTotals.keys.map((cat) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      width: 12,
                      height: 12,
                      color: categoryColors[cat] ?? Colors.black),
                  const SizedBox(width: 4),
                  Text(cat.name.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              );
            }).toList(),
          ),

          const SizedBox(height: 32),

          // Settings
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Ajustes de Presupuesto",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                        child: Text(
                            "Margen Comercial: ${state.marginPercent.toInt()}%")),
                    Expanded(
                      flex: 2,
                      child: Slider(
                        value: state.marginPercent,
                        min: 0,
                        max: 50,
                        divisions: 10,
                        activeColor: Colors.green,
                        onChanged: (val) {
                          context.read<BudgetCubit>().updateMargin(val);
                        },
                      ),
                    ),
                  ],
                ),

                // Tax Switch
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Incluir IVA (21%)"),
                    Switch(
                      value: state.includeTax,
                      activeTrackColor: Colors.blueAccent,
                      onChanged: (val) {
                        context.read<BudgetCubit>().toggleTax(val);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdownTab(BudgetState state) {
    // Group items by category
    Map<BudgetCategory, List<BudgetItem>> grouped = {};
    for (var cat in BudgetCategory.values) {
      var list = state.items.where((i) => i.category == cat).toList();
      if (list.isNotEmpty) grouped[cat] = list;
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: grouped.keys.length,
      itemBuilder: (context, index) {
        final cat = grouped.keys.elementAt(index);
        final items = grouped[cat]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                cat.name.toUpperCase(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey),
              ),
            ),
            ...items
                .map((item) => Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.grey.shade200)),
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: _getCategoryColor(item.category)
                              .withValues(alpha: 0.1),
                          child: Icon(_getCategoryIcon(item.category),
                              color: _getCategoryColor(item.category),
                              size: 20),
                        ),
                        title: Text(item.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14)),
                        subtitle: Text(
                            "${item.description}  x  ${item.unitPrice.toStringAsFixed(2)} €/ud"),
                        trailing: Text(
                          "${item.total.toStringAsFixed(2)} €",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ))
                .toList(),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Color _getCategoryColor(BudgetCategory cat) {
    switch (cat) {
      case BudgetCategory.protection:
        return Colors.blue;
      case BudgetCategory.cable:
        return Colors.orange;
      case BudgetCategory.enclosure:
        return Colors.grey;
      case BudgetCategory.generic:
        return Colors.purple;
      case BudgetCategory.labor:
        return Colors.brown;
      case BudgetCategory.smallMaterial:
        return Colors.blueGrey;
    }
  }

  IconData _getCategoryIcon(BudgetCategory cat) {
    switch (cat) {
      case BudgetCategory.protection:
        return Icons.health_and_safety;
      case BudgetCategory.cable:
        return Icons.cable;
      case BudgetCategory.enclosure:
        return Icons.inbox;
      case BudgetCategory.generic:
        return Icons.bolt;
      case BudgetCategory.labor:
        return Icons.engineering;
      case BudgetCategory.smallMaterial:
        return Icons.build;
    }
  }

  Future<void> _openConfigDialog(BuildContext context) async {
    final projectCubit = context.read<ProjectCubit>();
    final currentConfig =
        projectCubit.state.budgetConfig ?? const BudgetConfig();

    final newConfig = await showDialog<BudgetConfig>(
      context: context,
      builder: (_) => BudgetConfigDialog(initialConfig: currentConfig),
    );

    if (newConfig != null) {
      projectCubit.updateBudgetConfig(newConfig);
      await projectCubit.saveProject();

      if (!mounted) return;
      // Reload budget with new config
      final root = projectCubit.state.root;
      if (root != null) {
        context.read<BudgetCubit>().loadBudget(root, config: newConfig);
      }
    }
  }

  Future<void> _exportPdf(BuildContext context) async {
    final budgetState = context.read<BudgetCubit>().state;
    final projectState = context.read<ProjectCubit>().state;

    // Construct a Project object from state (or use cached one if available, but state is safer)
    final project = Project(
        id: projectState.projectId,
        name: projectState.projectName,
        client: projectState.client,
        reference: projectState.reference,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        root: projectState.root,
        budgetConfig: projectState.budgetConfig,
        electricalStandardId: projectState.electricalStandardId);

    try {
      final generator = BudgetPdfGenerator();
      await Printing.layoutPdf(
        onLayout: (format) async => generator.generate(
          project: project,
          items: budgetState.items,
          netTotal: budgetState.netTotal,
          marginAmount: budgetState.marginAmount,
          subtotal: budgetState.netTotal + budgetState.marginAmount,
          taxAmount: budgetState.taxAmount,
          finalTotal: budgetState.finalTotal,
        ),
        name: '${project.name}_Presupuesto.pdf',
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al generar PDF: $e')),
        );
      }
    }
  }
}
