import 'package:flutter/material.dart';

/// Botón primario de la aplicación con soporte para estados loading, disabled,
/// y variantes primary/secondary.
///
/// **Field-UX Optimizations**:
/// - Touch target: 56px mínimo (Material Design compliance)
/// - Alto contrasto (#135BEC primary) para visibilidad en exteriores
/// - Sombras pronunciadas para affordance táctil
/// - Estados visuales claros (loading, disabled) para trabajo sin mirar
///
/// **Uso básico**:
/// ```dart
/// AppButton(
///   text: 'Guardar Proyecto',
///   onPressed: () => _saveProject(),
/// )
/// ```
///
/// **Con estado loading**:
/// ```dart
/// AppButton(
///   text: 'Calculando...',
///   isLoading: true,
///   onPressed: null, // Auto-disabled durante loading
/// )
/// ```
///
/// **Botón secundario (outline)**:
/// ```dart
/// AppButton(
///   text: 'Cancelar',
///   isSecondary: true,
///   onPressed: () => Navigator.pop(context),
/// )
/// ```
///
/// **Con icono**:
/// ```dart
/// AppButton(
///   text: 'Exportar PDF',
///   icon: Ionicons.download_outline,
///   onPressed: () => _exportToPdf(),
/// )
/// ```
///
/// {@category Core}
/// {@category Presentation}
/// {@category Field-UX}
class AppButton extends StatelessWidget {
  /// Texto visible en el botón.
  final String text;

  /// Callback ejecutado al presionar.
  ///
  /// Si es `null`, el botón se deshabilita automáticamente (estilo gris).
  /// También se deshabilita si [isLoading] es `true`.
  final VoidCallback? onPressed;

  /// Si `true`, muestra un [CircularProgressIndicator] y deshabilita el botón.
  ///
  /// Útil para operaciones asíncronas como guardado en Isar o cálculos eléctricos.
  final bool isLoading;

  /// Icono opcional a la izquierda del texto.
  ///
  /// Usar iconos de Ionicons para consistencia con el Design System.
  final IconData? icon;

  /// Si `true`, usa estilo secondary (transparente con borde).
  ///
  /// Usado para acciones no-críticas o cancelaciones.
  final bool isSecondary;

  /// Color de fondo customizado (opcional).
  ///
  /// Por defecto:
  /// - Primary: Theme.primaryColor (#135BEC)
  /// - Secondary: Transparente
  final Color? backgroundColor;

  /// Color del texto customizado (opcional).
  ///
  /// Por defecto:
  /// - Primary: Blanco
  /// - Secondary: Theme.primaryColor
  final Color? textColor;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.isSecondary = false,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Determine colors
    final bgColor = backgroundColor ??
        (isSecondary ? Colors.transparent : theme.primaryColor);

    final txtColor =
        textColor ?? (isSecondary ? theme.primaryColor : Colors.white);

    final borderSide = isSecondary
        ? BorderSide(color: theme.primaryColor, width: 2)
        : BorderSide.none;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: isSecondary || onPressed == null
            ? []
            : [
                BoxShadow(
                  color: bgColor.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Ink(
            decoration: BoxDecoration(
              color: onPressed == null ? Colors.grey : bgColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.fromBorderSide(
                  onPressed == null ? BorderSide.none : borderSide),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              alignment: Alignment.center,
              child: isLoading
                  ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(txtColor),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          Icon(icon, color: txtColor, size: 20),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          text,
                          style: TextStyle(
                            color: txtColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
