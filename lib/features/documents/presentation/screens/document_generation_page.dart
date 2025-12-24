import 'package:flutter/material.dart';
import '../../../../config/theme/app_themes.dart';
import 'package:printing/printing.dart';
import '../../../../features/projects/domain/entities/project.dart';

import '../../../../features/projects/presentation/bloc/project_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../reports/domain/services/document_service.dart';

class DocumentGenerationPage extends StatefulWidget {
  const DocumentGenerationPage({Key? key}) : super(key: key);

  @override
  State<DocumentGenerationPage> createState() => _DocumentGenerationPageState();
}

class _DocumentGenerationPageState extends State<DocumentGenerationPage> {
  // Mock state
  final Map<String, bool> _selectedDocs = {
    'Memoria Técnica': true,
    'Plano Unifilar': true,
    'Presupuesto Estimado': false,
    'Manual de Usuario': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generar Documentación'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Project Summary Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kBackgroundLight, // soft bg
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.folder, color: kPrimaryColor),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: BlocBuilder<ProjectCubit, ProjectState>(
                      builder: (context, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(state.projectName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            Text('Cliente: ${state.client ?? "Sin cliente"}',
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Align(
              alignment: Alignment.centerLeft,
              child: Text('SELECCIÓN DE DOCUMENTOS',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),

            // Document List
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: _selectedDocs.entries.map((entry) {
                  return Column(
                    children: [
                      CheckboxListTile(
                        title: Text(entry.key,
                            style:
                                const TextStyle(fontWeight: FontWeight.w500)),
                        value: entry.value,
                        activeColor: kPrimaryColor,
                        onChanged: (val) {
                          setState(() {
                            _selectedDocs[entry.key] = val ?? false;
                          });
                        },
                      ),
                      if (entry.key != _selectedDocs.keys.last)
                        const Divider(height: 1, indent: 16, endIndent: 16),
                    ],
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 24),

            Align(
              alignment: Alignment.centerLeft,
              child: Text('OPCIONES DE EXPORTACIÓN',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _buildOptionRow(context, 'Formato', 'PDF Unificado'),
                  const Divider(height: 24),
                  _buildOptionRow(context, 'Idioma', 'Español'),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Incluir Firma Digital',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Switch(
                          value: true,
                          onChanged: (v) {},
                          activeThumbColor: kPrimaryColor),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // Preview PDF
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(title: const Text("Vista Previa PDF")),
                      body: PdfPreview(
                        build: (format) async {
                          final state = context.read<ProjectCubit>().state;
                          final project = Project(
                            id: state.projectId,
                            name: state.projectName,
                            client: state.client,
                            reference: state.reference,
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                            root: state.root,
                            electricalStandardId: state.electricalStandardId,
                          );

                          final service = DocumentService();
                          return service.generateUnified(project);
                        },
                      ),
                    ),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.visibility, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Previsualizar Documento',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        Row(
          children: [
            Text(value,
                style: const TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.bold)),
            const SizedBox(width: 4),
            const Icon(Icons.expand_more, color: kPrimaryColor, size: 20),
          ],
        ),
      ],
    );
  }
}
