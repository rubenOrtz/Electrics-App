# 📚 Documentación y Design System

Bienvenido a la documentación del **Electrics App**, una super-app profesional para el sector eléctrico español que cumple con REBT 2002, IEC-60898, IEC-60909 e ITC-BT-19.

## 📖 Documentación Disponible

### Dartdoc - Documentación Técnica

La documentación técnica de la API se genera automáticamente con cada push a `main` usando Dartdoc.

**Acceso**:

- 🌐 **Online**: [https://rubenOrtz.github.io/Electrics-App/](https://rubenOrtz.github.io/Electrics-App/)
- 💻 **Local**: `dart doc . && open doc/api/index.html`

**Contenido**:

- Documentación completa de todas las clases y funciones
- Ejemplos de uso con código real
- Arquitectura organizada por capas (Core, Domain, Data, Presentation)
- Enlaces directos al código fuente en GitHub

---

### Storybook - Design System

Storybook Flutter permite explorar y probar componentes UI de forma aislada, acelerando el desarrollo y facilitando el onboarding de nuevos desarrolladores.

**Acceso**:

- 🌐 **Online**: [https://rubenOrtz.github.io/Electrics-App/storybook/](https://rubenOrtz.github.io/Electrics-App/storybook/)
- 💻 **Local**: `flutter run -d chrome -t storybook/main.dart`

**Componentes Documentados**:

- `AppButton`: Botón primario/secundario con estados loading y disabled
- `ElectricalNodeWidget`: Nodos del diagrama eléctrico con validación REBT

---

## 🛠️ Uso para Desarrolladores

### Ejecutar Storybook Localmente

```bash
# Launches Storybook in Chrome for component development
flutter run -d chrome -t storybook/main.dart
```

**Ventajas**:

- Hot reload habilitado (cambios instantáneos)
- Prueba componentes sin compilar la app completa
- Experimenta con diferentes estados (error, warning, ok)
- Controles interactivos (knobs) para propiedades

---

### Generar Dartdoc Localmente

```bash
# Genera documentación en doc/api/
dart doc .

# Abre en navegador (Windows)
start doc/api/index.html

# Mac/Linux
open doc/api/index.html
```

---

## ✍️ Guía para Contribuidores

### Cómo Agregar un Nuevo Componente a Storybook

1. **Crear archivo de story** en `storybook/stories/`:

   ```dart
   // storybook/stories/my_widget_story.dart
   import 'package:storybook_flutter/storybook_flutter.dart';
   import 'package:electrician_app/path/to/my_widget.dart';

   final myWidgetStories = [
     Story(
       name: 'Category/MyWidget/Default',
       description: 'Descripción del componente y cuándo usarlo',
       builder: (context) => Center(
         child: MyWidget(
           // Props del componente
         ),
       ),
     ),
   ];
   ```

2. **Importar en `storybook/main.dart`**:

   ```dart
   import 'stories/my_widget_story.dart';

   // En la lista de stories:
   stories: [
     ...myWidgetStories,
   ],
   ```

3. **Ejecutar** `flutter run -d chrome -t storybook/main.dart` para verificar.

---

### Cómo Documentar Código con Dartdoc

**Best Practices**:

```dart
/// Brief one-line summary.
///
/// **Contexto adicional**:
/// - Detalles de implementación
/// - Consideraciones arquitectónicas
/// - Normativas aplicables (ej: REBT 2002)
///
/// **Ejemplo de uso**:
/// ```dart
/// final result = MyClass(param: 'value');
/// ```
///
/// {@category CategoryName}
class MyClass {
  /// Descripción del campo.
  ///
  /// - Si hay detalles importantes, añadirlos aquí
  /// - Valores por defecto si aplica
  final String myField;
}
```

**Categorías Existentes**:

- `Core`: Funcionalidad base y utils
- `Domain`: Entities, UseCases, Repositories
- `Data`: DataSources, DTOs, Implementations
- `Presentation`: Widgets, Cubits, Pages
- `Field-UX`: Optimizaciones para trabajo en campo

---

## 🚀 Despliegue Automático (CI/CD)

El workflow `.github/workflows/docs.yml` se ejecuta automáticamente en cada push a `main`.

**Pasos**:

1. **Generate Dartdoc**: Ejecuta `dart doc .`
2. **Build Storybook**: Compila Flutter Web con `flutter build web -t storybook/main.dart`
3. **Deploy to GitHub Pages**: Despliega ambos a:
   - Root (`/`): Dartdoc
   - Subpath (`/storybook/`): Storybook Flutter

**Tiempo estimado**: ~3-5 minutos (con cache de Flutter)

---

## 📐 Estructura de Archivos

```
Electrics-App/
├── dartdoc_options.yaml         # Configuración de Dartdoc
├── storybook/
│   ├── main.dart                # Entry point de Storybook
│   └── stories/
│       ├── app_button_story.dart
│       └── electrical_node_widget_story.dart
├── .github/workflows/
│   └── docs.yml                 # CI/CD para documentación
└── doc/                         # Generado localmente (gitignored)
    └── api/                     # Dartdoc output
```

---

## ⚡ Field-UX Guidelines

Los componentes deben cumplir con optimizaciones específicas para trabajo en campo:

### Touch Targets

- Mínimo 56px según Material Design
- Usar `AppButton` en lugar de `TextButton` para acciones primarias

### Alto Contraste

- Color primario: `#135BEC`
- Texto sobre fondos claros/oscuros debe pasar WCAG AA
- Estados error/warning/ok deben ser distinguibles sin color (iconografía)

### Feedback Táctil

- Usar `HapticFeedback.lightImpact()` en interacciones magnéticas
- Animaciones deben ser obvias (~200ms) no sutiles

### Offline-First

- Todos los componentes deben funcionar sin internet
- Mostrar loading states mientras se guarda en Isar
- Manejar gracefully errores de persistencia

---

## 🧪 Testing

Los componentes en Storybook **NO** reemplazan los tests unitarios/widget:

```bash
# Ejecutar tests existentes
flutter test

# Los componentes deben tener ambos:
# 1. Story en Storybook (visualización)
# 2. Test en test/ (lógica y regressions)
```

---

## 🔗 Enlaces Útiles

- [Dartdoc Documentation](https://dart.dev/tools/dartdoc)
- [Storybook Flutter Package](https://pub.dev/packages/storybook_flutter)
- [REBT 2002](https://www.boe.es/buscar/doc.php?id=BOE-A-2002-18099)
- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

---

## 📌 Mantenimiento

**Frecuencia recomendada**:

- Actualizar Dartdoc: En cada PR que modifique APIs públicas
- Agregar stories: Al crear componentes reutilizables (no páginas)
- Revisar documentación: Mensual (detectar docs obsoletas)

**Responsabilidades**:

- Tech Lead: Aprobar nuevas categorías en Dartdoc
- Desarrolladores: Documentar código nuevo antes de merge
- UI/UX: Validar que Storybook refleje Design System actualizado

---

## 🐛 Troubleshooting

### Error: "GitHub Pages not found (404)"

**Solución**:

1. Ir a `Settings → Pages` en GitHub
2. Source: Seleccionar "GitHub Actions"
3. Esperar ~2 min a que se complete el deployment

### Error: "Dartdoc warnings sobre documentación faltante"

**Solución**: Esto no bloquea el build. Agregar Dartdoc comments a las clases públicas principales.

### Error: "Storybook no carga componentes"

**Solución**:

1. Verificar imports en `storybook/main.dart`
2. Ejecutar `flutter pub get`
3. Hot restart (`R` en terminal)

---

**¿Preguntas?** Contacta al Tech Lead o abre un issue en GitHub.
