# 🤝 Contribuir a Electrics-App

¡Gracias por tu interés en colaborar con **Electrics-App**! Este es un proyecto Open Source creado para modernizar la ingeniería eléctrica de campo. Queremos que la precisión técnica y la facilidad de uso vayan de la mano, y tu ayuda es fundamental para lograrlo.

Buscamos principalmente dos perfiles: **Ingenieros Eléctricos** y **Desarrolladores Flutter**.

---

## 🏗️ Perfiles de Colaboración

### ⚡ 1. Ingenieros Eléctricos (Validación y Normativa)
No necesitas saber programar para ayudar. Tu conocimiento experto en el sector es lo que hace que esta app sea fiable.
* **Auditoría de Cálculos:** Revisa los algoritmos en [`lib/features/calculator/domain/usecases/electrical_math.dart`](./lib/features/calculator/domain/usecases/electrical_math.dart).
* **Mapeo Normativo:** Ayúdanos a traducir las tablas del REBT y normas UNE al motor de validación en [`rebt_rules.dart`](./lib/features/compliance/domain/standards/rebt_rules.dart).
* **Casos de Test:** Si tienes cálculos reales hechos a mano o con software de escritorio, compártelos en un Issue para que podamos crear tests unitarios que aseguren que la app da el mismo resultado.

### 💻 2. Desarrolladores Flutter (Arquitectura y UI)
Buscamos mantener un código limpio, escalable y eficiente.
* **Stack:** Flutter, Isar DB, BLoC/Cubit.
* **Inmutabilidad:** Usamos `freezed` para los modelos y estados.
* **Tareas:** Optimización de la base de datos local, mejoras en la UX del diagrama unifilar, o implementación de la generación de informes PDF.

---

## 🛠️ Configuración del Entorno

1.  **Fork y Clonación:** Haz un fork del repositorio y clónalo en tu máquina local.
2.  **SDK:** Asegúrate de tener instalado el SDK de Flutter (canal estable).
3.  **Dependencias:** Ejecuta `flutter pub get`.
4.  **Generación de Código:** Como usamos `freezed` y `json_serializable`, ejecuta:
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```
5.  **Base de Datos:** La app utiliza Isar. No necesitas configurar servidores externos, todo es local.

---

## 🧪 Protocolo de Verificación Matemática

Si propones un cambio en una fórmula física, debes seguir estos pasos:
1.  Indica la norma específica (ej. UNE-HD 60364-5-52) y la tabla o apartado.
2.  Crea o actualiza un test unitario en la carpeta [`test/features/calculator/`](./test/features/calculator/).
3.  Verifica que el cambio no rompa la coherencia del motor de doble pasada (Ascendente/Descendente).

---

## 🤖 Agente de IA y Componentes

Contamos con un sistema automatizado para ampliar la biblioteca de materiales:
* Si quieres añadir un nuevo interruptor o diferencial, no hace falta que edites el JSON.
* Simplemente abre un **GitHub Issue** con la etiqueta `[COMPONENT REQUEST]`.
* Nuestro bot en Python procesará la solicitud y mapeará las características técnicas automáticamente.

---

## 📐 Estilo de Código y Pull Requests

* **Arquitectura:** Seguimos principios de *Clean Architecture*. Separa claramente `Domain`, `Data` y `Presentation`.
* **Commits:** Usa mensajes descriptivos (ej. `feat: add voltage drop calculation for aluminum cables`).
* **PRs:** Todas las Pull Requests pasan por una revisión automática de **AI Code Review**. Asegúrate de que los tests pasen antes de solicitar la fusión.

---

## 💬 ¿Dónde hablar?

Si tienes dudas técnicas o quieres proponer una funcionalidad grande:
* **Discusiones:** Usa la pestaña de "Discussions" en GitHub.
* **Issues:** Para bugs o peticiones de componentes.

*"Porque la ingeniería colaborativa es el futuro del sector eléctrico."* ⚡
