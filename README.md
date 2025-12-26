<h1 align="center">
  <img src="assets/logo.png" width="45" style="vertical-align:middle">
  ⚡ Electrics-App: El Gemelo Digital en tu bolsillo
</h1>

<p align="center">
  <strong>Cálculo, diseño y normativa unificado bajo el REBT.</strong><br>
  <em>"Deja el Excel para la oficina. Lleva la ingeniería al campo de trabajo."</em>
</p>

<p align="center">
  <a href="https://github.com/rubenOrtz/Electrics-App/releases">
    <img src="https://img.shields.io/github/v/release/rubenOrtz/Electrics-App?include_prereleases&sort=date&display_name=release&style=for-the-badge" alt="Release">
  </a>
  
  <a href="https://github.com/rubenOrtz/Electrics-App/actions">
    <img src="https://img.shields.io/github/actions/workflow/status/rubenOrtz/Electrics-App/release.yml?branch=main&style=for-the-badge&logo=github&label=CI%20BUILD&color=success" alt="CI Status">
  </a>

  <a href="https://flutter.dev">
    <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter">
  </a>

  <a href="LICENSE">
    <img src="https://img.shields.io/github/license/rubenOrtz/Electrics-App?style=for-the-badge" alt="License">
  </a>
</p>

<p align="center">
<strong>Electrics-App</strong> no es solo una calculadora eléctrica. Es un <strong>Gemelo Digital</strong> diseñado para ingenieros e instaladores que necesitan precisión técnica y validación normativa (REBT/RAT) en tiempo real, sin necesidad de un ordenador.
</p>

> **⚠ AVISO ⚠**  
> Es ilegal el uso con fines lucrativos o comercial de este producto. Seguimos APGL-3.0. Lee la licencia.
---

## 🛠️ ¿Por qué Electrics-App?

Como ingenieros, nos enfrentamos a un mar de normativas y cálculos complejos en entornos donde no puedes abrir un portátil. El flujo de trabajo actual está roto:
1.  Tomas datos en papel o móvil.
2.  Llegas a casa cansado tras la jornada de campo.
3.  Pasas horas en Excel legalizando y presupuestando.

**Electrics-App rompe este ciclo.** Diseña, mide y presupuesta **in situ**. Para que cuando llegues a casa, tu único trabajo sea descansar.

---

## ✨ Funcionalidades Estrella

### 🧬 Motor de Física Avanzado
Cálculos precisos de caída de tensión, intensidades de cortocircuito y suma vectorial de impedancias. Un núcleo robusto que entiende la física real detrás de los cables.

A diferencia de otras aplicaciones, Electrics-App no es una "caja negra". El motor de cálculo ha sido programado siguiendo estrictamente el compendio de normas técnicas vigentes en España y Europa, las cuales puedes consultar directamente en la carpeta [`/normas`](./normas) del repositorio.

### 📚 Normativas Integradas:
* **Cálculo de Caída de Tensión e Intensidades Admisibles:** Basado en la [**UNE-HD 60364-5-52:2014**](./normas/Anexo%202.-%20UNE-HD-60364-5-52-2014.pdf).
* **Cálculo de Corrientes de Cortocircuito:** Implementación de la norma [**IEC 60909-0:2016**](./normas/IEC-60909-0-2016.pdf).
* **Protecciones y Curvas de Disparo:** Siguiendo la [**IEC 60898-1**](./normas/IEC-60898-1-2015-AMD1-2019.pdf) para interruptores magnetotérmicos.
* **Reglamento Nacional:** Cumplimiento íntegro del [**REBT (RD 842/2002)**](./normas/BOE-A-2002-18099-consolidado.pdf) y sus Guías Técnicas de Aplicación.

### 💻 Implementación en Código:
Si eres ingeniero o desarrollador, puedes auditar nuestra lógica en:
* [`electrical_math.dart`](./lib/features/calculator/domain/usecases/electrical_math.dart): Fórmulas base de suma vectorial de impedancias y potencias.
* [`rebt_rules.dart`](./lib/features/compliance/domain/standards/rebt_rules.dart): Mapeo de las restricciones legales del Reglamento Electrotécnico.
* [`iz_constants.dart`](./lib/features/diagram/domain/services/iz_constants.dart): Tablas de intensidades máximas según el método de instalación y tipo de aislamiento.
* [`trip_curve_calculator.dart`](./lib/features/components/domain/services/trip_curve_calculator.dart): Motor de renderizado y cálculo de tiempos de disparo para curvas B, C y D.

### 🏥 Sistema de Diagnóstico (Health Check)
Introduce las mediciones reales de tus herramientas y la app las comparará con el modelo teórico. ¿Desviación excesiva? La app te avisa antes de que sea un problema.

### 🤖 Base de Datos impulsada por IA
Añadir componentes nunca fue tan fácil. Gracias a nuestra integración con IA, puedes solicitar nuevos componentes electricos de la biblioteca directamente desde GitHub Issues.
* **¿Necesitas un magnetotérmico específico?** Abre un Issue con: `[COMPONENT REQUEST] M9U11206 Schneider Electric` o `[COMPONENT REQUEST] Diferencial bipolar 40A R9 2P SCHNEIDER ELECTRIC` y la IA se encargará de mapear sus características técnicas a la app. En la próxima actualización estará disponible para su uso. También existen ya componente sgenerales o puedes crear tus propios componentes.

### 📄 Presupuestos al Instante (En desarrollo)
Genera reportes y presupuestos listos para imprimir y entregar al cliente antes de salir de la instalación.

---

## 🚀 Cómo empezar

El proyecto está diseñado para **no requerir conexión** y no requiere configuración de servidores externos.
Simplemente, descárgate la última actualización
<div align="left">
  <a href="https://github.com/rubenOrtz/Electrics-App/releases/latest">
    <img src="https://img.shields.io/badge/DESCARGAR_ÚLTIMA_VERSIÓN-00569b?style=for-the-badge&logo=flutter&logoColor=white&shadow=true" alt="Download Latest Release" height="50">
  </a>
  <p><i>Pre Release v1.0.0</i></p>
</div>

---

## 🤝 Buscamos Talento (Contribuir)

Este proyecto es público porque la ingeniería eléctrica merece herramientas modernas. Buscamos dos perfiles:

1.  **Ingenieros Eléctricos:** Ayúdanos a verificar los algoritmos de cálculo, añadir lógica de normativas internacionales y testear el motor físico.
2.  **Desarrolladores Flutter:** Mejora de la UI/UX, optimización de base de datos local (Isar) y pulido de animaciones.

Consulta nuestra [Wiki](https://github.com/rubenOrtz/Electrics-App/wiki) para entender la arquitectura del motor físico.

---

## 🤖 Automatización y DevOps

Contamos con un flujo de trabajo moderno:
* **AI Code Review:** Revisión automática de Pull Requests.
* **Automated Releases:** Cada mejora llega a tus manos sin esperas.
* **AI Component Agent:** Generación automática de plantillas de componentes mediante procesamiento de lenguaje natural.

---

Hecho con ❤️ por ingenieros, para ingenieros.
