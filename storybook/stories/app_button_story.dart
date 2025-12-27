import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:electrician_app/core/presentation/widgets/app_button.dart';
import 'package:ionicons/ionicons.dart';

/// Stories para AppButton - Demuestra todas las variantes del botón principal
/// de la aplicación según el Design System.
final appButtonStories = [
  Story(
    name: 'Core/AppButton/Primary',
    description: '''
Botón primario estándar con fondo #135BEC.
Field-UX optimizations:
- Touch target: 56px mínimo
- Alto contraste para exteriores
- Sombras pronunciadas para profundidad
    ''',
    builder: (context) {
      final text = context.knobs.text(
        label: 'Text',
        initial: 'Guardar Proyecto',
      );
      final isLoading = context.knobs.boolean(
        label: 'Loading',
        initial: false,
      );
      final showIcon = context.knobs.boolean(
        label: 'Show Icon',
        initial: false,
      );

      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: AppButton(
            text: text,
            onPressed: () {},
            isLoading: isLoading,
            icon: showIcon ? Ionicons.checkmark : null,
          ),
        ),
      );
    },
  ),
  Story(
    name: 'Core/AppButton/Secondary',
    description: '''
Botón secundario con borde (outline style).
Usado para acciones no-críticas.
    ''',
    builder: (context) {
      final text = context.knobs.text(
        label: 'Text',
        initial: 'Cancelar',
      );

      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: AppButton(
            text: text,
            onPressed: () {},
            isSecondary: true,
          ),
        ),
      );
    },
  ),
  Story(
    name: 'Core/AppButton/Disabled',
    description: '''
Estado disabled (onPressed == null).
Se deshabilita automáticamente cuando isLoading == true.
    ''',
    builder: (context) => const Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: AppButton(
          text: 'Acción No Disponible',
          onPressed: null,
        ),
      ),
    ),
  ),
  Story(
    name: 'Core/AppButton/Loading',
    description: '''
Estado loading con CircularProgressIndicator.
Bloquea interacción automáticamente.
    ''',
    builder: (context) => const Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: AppButton(
          text: 'Calculando...',
          onPressed: null,
          isLoading: true,
        ),
      ),
    ),
  ),
  Story(
    name: 'Core/AppButton/With Icon',
    description: '''
Botón con icono a la izquierda.
Usar iconos de Ionicons para consistencia.
    ''',
    builder: (context) => const Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: AppButton(
          text: 'Exportar PDF',
          icon: Ionicons.download_outline,
          onPressed: null,
        ),
      ),
    ),
  ),
  Story(
    name: 'Core/AppButton/Custom Colors',
    description: '''
Ejemplo con colores customizados.
Útil para acciones destructivas (ej: eliminar).
    ''',
    builder: (context) => const Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: AppButton(
          text: 'Eliminar Diagrama',
          icon: Ionicons.trash_outline,
          onPressed: null,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
        ),
      ),
    ),
  ),
  Story(
    name: 'Core/AppButton/All States',
    description: 'Comparativa de todos los estados lado a lado.',
    builder: (context) => Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            AppButton(
              text: 'Primary Active',
              onPressed: null, // onPressed will be () {} in real use
            ),
            SizedBox(height: 16),
            AppButton(
              text: 'Secondary Active',
              isSecondary: true,
              onPressed: null,
            ),
            SizedBox(height: 16),
            AppButton(
              text: 'Disabled',
              onPressed: null,
            ),
            SizedBox(height: 16),
            AppButton(
              text: 'Loading...',
              isLoading: true,
              onPressed: null,
            ),
            SizedBox(height: 16),
            AppButton(
              text: 'With Icon',
              icon: Ionicons.checkmark_circle,
              onPressed: null,
            ),
          ],
        ),
      ),
    ),
  ),
];
