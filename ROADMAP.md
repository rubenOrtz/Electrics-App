# 🗺️ Roadmap de Electrics-App

Este documento detalla la visión de futuro para **Electrics-App**. El objetivo es convertir esta herramienta en el estándar de código abierto para la ingeniería eléctrica de campo.

---

## ✅ Fase 1: Consolidación y Core (Completado)
* [x] **Motor de Física 1.0:** Implementación de doble pasada (Bottom-Up para carga, Top-Down para impedancia).
* [x] **Cumplimiento REBT/UNE:** Mapeo de intensidades admisibles y caídas de tensión según normativa española.
* [x] **Arquitectura Offline-First:** Persistencia total con Isar DB.
* [x] **AI Component Agent:** Automatización de la biblioteca de materiales vía GitHub Issues.
* [x] **CI/CD:** Automatización de releases y revisión de código por IA.

---

## 🏗️ Fase 2: Documentación y Legalización (En progreso)
*Objetivo: Que el instalador pueda legalizar la instalación antes de salir de la obra.*

* [ ] **Generador de PDF Pro:** Exportación automática de la Memoria Técnica de Diseño (MTD) y el Certificado de Instalación Eléctrica (CIE/Boletín).
* [ ] **Esquemas Unifilares Exportables:** Exportación del diagrama visual en formato DXF/DWG o PDF técnico.
* [ ] **Multilenguaje Estricto:** Soporte completo para Inglés y Español (UI y Reportes). (falta revisión completa)
* [ ] **Mejora de UX en el Diagrama:** Soporte para gestos avanzados y alineación inteligente de nodos.

---

## 🚀 Fase 3: Ecosistema e Industrialización (Corto Plazo)
*Objetivo: Integrar el valor económico y el mantenimiento preventivo.*

* [ ] **Módulo Económico:** Integración con bases de precios (ej. BEDEC/Presto) para generar presupuestos automáticos basados en el diagrama. (en proceso)
* [ ] **Gestión de Activos con QR/NFC:** Capacidad de asociar un código físico en el cuadro eléctrico con el "Gemelo Digital" en la app para ver el historial de mantenimiento.
* [ ] **Health Insights Avanzados:** Uso de modelos de ML locales para predecir fallos de aislamiento basados en tendencias de mediciones de campo.
* [ ] **Mediciones Automáticas**: Añadir mediciones Automáticas desde la app mediante el uso de APIs de herramientas reales.

---

## ⚡ Fase 4: Expansión a Alta Tensión (Medio Plazo)
*Objetivo: Cubrir todo el espectro de la ingeniería eléctrica.*

* [ ] **Motor de Cálculo RAT:** Implementación del Reglamento de Alta Tensión para celdas de Media Tensión y transformadores.
* [ ] **Cálculo de Redes de Tierra:** Algoritmos para dimensionamiento de electrodos y tensiones de paso/contacto.
* [ ] **Sincronización en la Nube (Cloud Sync):** Colaboración entre equipos de ingeniería (Web/Desktop/Móvil).

---

## 🌍 Fase 5: Internacionalización Normativa (Visión Global)
* [ ] **Soporte NEC (EE.UU.):** Adaptación de cálculos para el National Electrical Code.
* [ ] **Soporte IEC Internacional:** Modularización de las reglas de cumplimiento para adaptarse a diferentes normativas nacionales.

---

## 💡 ¿Quieres proponer algo?

Si crees que falta alguna funcionalidad crítica para tu día a día en la obra, [abre una Feature Request](https://github.com/rubenOrtz/Electrics-App/issues/new?labels=enhancement). 

*"Construyendo el futuro de la ingeniería, cable por cable."*
