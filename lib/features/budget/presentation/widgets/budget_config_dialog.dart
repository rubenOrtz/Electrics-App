import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../features/projects/domain/entities/budget_config.dart';

class BudgetConfigDialog extends StatefulWidget {
  final BudgetConfig initialConfig;

  const BudgetConfigDialog({Key? key, required this.initialConfig})
      : super(key: key);

  @override
  State<BudgetConfigDialog> createState() => _BudgetConfigDialogState();
}

class _BudgetConfigDialogState extends State<BudgetConfigDialog> {
  late LaborCostType _laborType;
  late TextEditingController _rateController;
  late TextEditingController _timeController;
  late TextEditingController _fixedCostController;
  late TextEditingController _smallMaterialController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _laborType = widget.initialConfig.laborCostType;
    _rateController = TextEditingController(
        text: widget.initialConfig.laborRate.toStringAsFixed(2));
    _timeController = TextEditingController(
        text: widget.initialConfig.laborTime.toStringAsFixed(2));
    _fixedCostController = TextEditingController(
        text: widget.initialConfig.fixedLaborCost.toStringAsFixed(2));
    _smallMaterialController = TextEditingController(
        text: widget.initialConfig.smallMaterialPercent.toStringAsFixed(1));
  }

  @override
  void dispose() {
    _rateController.dispose();
    _timeController.dispose();
    _fixedCostController.dispose();
    _smallMaterialController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Configuración de Presupuesto"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Mano de Obra",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              // Labor Type Selector
              DropdownButtonFormField<LaborCostType>(
                initialValue: _laborType,
                decoration: const InputDecoration(
                  labelText: "Tipo de Coste",
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                items: const [
                  DropdownMenuItem(
                      value: LaborCostType.hourly, child: Text("Por Horas")),
                  DropdownMenuItem(
                      value: LaborCostType.fixed, child: Text("Coste Fijo")),
                ],
                onChanged: (val) {
                  if (val != null) {
                    setState(() {
                      _laborType = val;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Hourly Inputs
              if (_laborType == LaborCostType.hourly) ...[
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _rateController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(
                          labelText: "Tarifa (€/h)",
                          border: OutlineInputBorder(),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        validator: _validateNumber,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _timeController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(
                          labelText: "Horas Est.",
                          border: OutlineInputBorder(),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        validator: _validateNumber,
                      ),
                    ),
                  ],
                ),
              ],

              // Fixed Input
              if (_laborType == LaborCostType.fixed)
                TextFormField(
                  controller: _fixedCostController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: "Coste Fijo (€)",
                    border: OutlineInputBorder(),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  validator: _validateNumber,
                ),

              const Divider(height: 32),

              const Text("Materiales",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              TextFormField(
                controller: _smallMaterialController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: "Pequeño Material (%)",
                  helperText: "Porcentaje sobre el total de materiales",
                  border: OutlineInputBorder(),
                  suffixText: "%",
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                ],
                validator: _validateNumber,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text("Guardar"),
        ),
      ],
    );
  }

  String? _validateNumber(String? value) {
    if (value == null || value.isEmpty) return "Requerido";
    if (double.tryParse(value) == null) return "Número inválido";
    return null;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final config = BudgetConfig(
        laborCostType: _laborType,
        laborRate: double.parse(_rateController.text),
        laborTime: double.parse(_timeController.text),
        fixedLaborCost: double.parse(_fixedCostController.text),
        smallMaterialPercent: double.parse(_smallMaterialController.text),
      );
      Navigator.pop(context, config);
    }
  }
}
