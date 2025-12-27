import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:electrician_app/features/diagram/domain/entities/electrical_node.dart';
import 'package:electrician_app/features/diagram/domain/entities/calculation_result.dart';
import 'package:electrician_app/features/diagram/domain/entities/validation_status.dart';
import 'package:electrician_app/features/diagram/presentation/widgets/electrical_node_widget.dart';
import 'package:electrician_app/config/theme/app_themes.dart';

/// Stories para ElectricalNodeWidget - Demuestra el sistema de validación
/// visual y feedback para nodos del diagrama eléctrico.
///
/// IMPORTANTE: Estos son mocks para visualización. En producción,
/// los datos vienen del ElectricalCalculator (domain layer).
final electricalNodeWidgetStories = [
  Story(
    name: 'Diagram/ElectricalNode/Source - OK',
    description: '''
Nodo fuente (acometida) en estado compliant.
- Borde verde: Cumple REBT 2002
- Icc: 4500A (típica de suministro urbano)
- Voltaje: 230V monofásico
''',
    builder: (context) {
      final isSelected = context.knobs.boolean(
        label: 'Selected',
        initial: false,
      );

      return Theme(
        data: ThemeData.dark().copyWith(
          extensions: [
            const DiagramTheme(
              canvasBg: Color(0xFF121212),
              panelBg: Color(0xFF1E1E1E),
              gridLine: Color(0xFF2C2C2C),
              isDark: true,
              nodeBg: Color(0xFF1E1E1E),
              nodeBorder: Color(0xFF4CAF50), // Green for OK
              accentColor: Color(0xFF135BEC),
              textColor: Colors.white,
            ),
          ],
        ),
        child: Scaffold(
          backgroundColor: const Color(0xFF121212),
          body: Center(
            child: ElectricalNodeWidget(
              node: ElectricalNode.source(
                id: 'source-demo',
                name: 'ACOMETIDA',
                nominalVoltage: 230.0,
                shortCircuitCapacity: 4500.0,
                result: const CalculationResult(
                  designCurrent: 25.0,
                  voltageDrop: 0.0,
                  status: ValidationStatus.ok,
                ),
              ),
              isSelected: isSelected,
              onTap: () {},
            ),
          ),
        ),
      );
    },
  ),
  Story(
    name: 'Diagram/ElectricalNode/Protection - Error',
    description: '''
Protección con fallo crítico (REBT incumplido).
- Animación de pulso rojo
- Icc insuficiente (Breaking Capacity < Icc)
''',
    builder: (context) {
      return Theme(
        data: ThemeData.dark().copyWith(
          extensions: [
            const DiagramTheme(
              canvasBg: Color(0xFF121212),
              panelBg: Color(0xFF1E1E1E),
              gridLine: Color(0xFF2C2C2C),
              isDark: true,
              nodeBg: Color(0xFF1E1E1E),
              nodeBorder: Color(0xFFE53935), // Red for Error
              accentColor: Color(0xFF135BEC),
              textColor: Colors.white,
            ),
          ],
        ),
        child: Scaffold(
          backgroundColor: const Color(0xFF121212),
          body: Center(
            child: ElectricalNodeWidget(
              node: ElectricalNode.protection(
                id: 'prot-error',
                name: 'IGA APARTAMENTO',
                ratingAmps: 25.0,
                pdc: 3000.0, // 3kA
                curve: 'C',
                result: const CalculationResult(
                  status: ValidationStatus.error,
                  maxShortCircuitCurrent: 4500.0, // 4.5kA > 3kA -> Error
                  errors: [
                    ValidationError.shortCircuit(
                      message: 'PDC insuficiente',
                      breakingCapacity: 3000,
                      shortCircuitCurrent: 4500,
                    ),
                  ],
                ),
              ),
              isSelected: false,
              onTap: () {},
            ),
          ),
        ),
      );
    },
  ),
  Story(
    name: 'Diagram/ElectricalNode/Load - Warning',
    description: '''
Carga con advertencia (caída de tensión al límite).
- Borde naranja
- Feedback visual sutil
''',
    builder: (context) {
      return Theme(
        data: ThemeData.dark().copyWith(
          extensions: [
            const DiagramTheme(
              canvasBg: Color(0xFF121212),
              panelBg: Color(0xFF1E1E1E),
              gridLine: Color(0xFF2C2C2C),
              isDark: true,
              nodeBg: Color(0xFF1E1E1E),
              nodeBorder: Color(0xFFFF9800), // Orange for Warning
              accentColor: Color(0xFF135BEC),
              textColor: Colors.white,
            ),
          ],
        ),
        child: Scaffold(
          backgroundColor: const Color(0xFF121212),
          body: Center(
            child: ElectricalNodeWidget(
              node: ElectricalNode.load(
                id: 'load-warning',
                name: 'HORNO COCINA',
                powerWatts: 3500.0,
                cosPhi: 1.0,
                result: const CalculationResult(
                  status: ValidationStatus.warning,
                  voltageDrop: 4.5, // Warning zone
                  warnings: [
                    ValidationWarning.general(
                      message: 'Caída de tensión elevada',
                    ),
                  ],
                ),
              ),
              isSelected: false,
              onTap: () {},
            ),
          ),
        ),
      );
    },
  ),
  Story(
    name: 'Diagram/All Types',
    description: 'Comparativa visual de todos los tipos de nodos',
    builder: (context) {
      const theme = DiagramTheme(
        canvasBg: Color(0xFF121212),
        panelBg: Color(0xFF1E1E1E),
        gridLine: Color(0xFF2C2C2C),
        isDark: true,
        nodeBg: Color(0xFF1E1E1E),
        nodeBorder: Color(0xFF9E9E9E),
        accentColor: Color(0xFF135BEC),
        textColor: Colors.white,
      );

      return Theme(
        data: ThemeData.dark().copyWith(
          extensions: [theme],
        ),
        child: Scaffold(
          backgroundColor: const Color(0xFF121212),
          body: Center(
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                ElectricalNodeWidget(
                  node: const ElectricalNode.source(
                    id: 's1',
                    name: 'SOURCE',
                    nominalVoltage: 230,
                    shortCircuitCapacity: 6000,
                  ),
                  isSelected: false,
                  onTap: () {},
                ),
                ElectricalNodeWidget(
                  node: const ElectricalNode.panel(
                    id: 'p1',
                    name: 'PANEL',
                  ),
                  isSelected: false,
                  onTap: () {},
                ),
                ElectricalNodeWidget(
                  node: const ElectricalNode.protection(
                    id: 'prot1',
                    name: 'BREAKER',
                    ratingAmps: 16,
                    curve: 'C',
                  ),
                  isSelected: false,
                  onTap: () {},
                ),
                ElectricalNodeWidget(
                  node: const ElectricalNode.load(
                    id: 'l1',
                    name: 'LOAD',
                    powerWatts: 2000,
                  ),
                  isSelected: false,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      );
    },
  ),
  Story(
    name: 'Diagram/Interactive',
    description: 'Playground interactivo para probar estados',
    builder: (context) {
      final name = context.knobs.text(label: 'Name', initial: 'Test Node');
      final status = context.knobs.options(
        label: 'Validation Status',
        initial: ValidationStatus.ok,
        options: const [
          Option(label: 'OK', value: ValidationStatus.ok),
          Option(label: 'Warning', value: ValidationStatus.warning),
          Option(label: 'Error', value: ValidationStatus.error),
          Option(label: 'Pending', value: ValidationStatus.pending),
        ],
      );
      final isSelected =
          context.knobs.boolean(label: 'Selected', initial: false);

      Color borderColor;
      switch (status) {
        case ValidationStatus.ok:
          borderColor = Colors.green;
          break;
        case ValidationStatus.warning:
          borderColor = Colors.orange;
          break;
        case ValidationStatus.error:
          borderColor = Colors.red;
          break;
        case ValidationStatus.pending:
          borderColor = const Color(0xFF757575);
          break;
      }

      final theme = DiagramTheme(
        canvasBg: const Color(0xFF121212),
        panelBg: const Color(0xFF1E1E1E),
        gridLine: const Color(0xFF2C2C2C),
        isDark: true,
        nodeBg: const Color(0xFF1E1E1E),
        nodeBorder: borderColor,
        accentColor: const Color(0xFF135BEC),
        textColor: Colors.white,
      );

      final errors = status == ValidationStatus.error
          ? [const ValidationError.general(message: 'Critical Failure')]
          : <ValidationError>[];

      final warnings = status == ValidationStatus.warning
          ? [const ValidationWarning.general(message: 'Check voltage')]
          : <ValidationWarning>[];

      return Theme(
        data: ThemeData.dark().copyWith(
          extensions: [theme],
        ),
        child: Scaffold(
          backgroundColor: const Color(0xFF121212),
          body: Center(
            child: ElectricalNodeWidget(
              node: ElectricalNode.protection(
                id: 'interactive',
                name: name,
                ratingAmps: 16,
                curve: 'C',
                result: CalculationResult(
                  status: status,
                  errors: errors,
                  warnings: warnings,
                ),
              ),
              isSelected: isSelected,
              onTap: () {},
            ),
          ),
        ),
      );
    },
  ),
];
