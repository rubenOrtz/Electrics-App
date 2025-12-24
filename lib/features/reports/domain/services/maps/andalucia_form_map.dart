import 'dart:ui';
import 'region_form_map.dart';

class AndaluciaFormMap implements RegionFormMap {
  @override
  String get templateAsset => 'assets/certs/andalucia.pdf';
  @override
  int get maxCircuitRows => 0;

  // --- DATOS DE LA INSTALACIÓN (Emplazamiento) ---
  // Y approx: 240 - 340

  // Fila 1: Dirección y Números
  Offset get emplazamientoDireccionPos => const Offset(100, 260);
  Offset get emplazamientoNumeroPos => const Offset(350, 260);
  Offset get emplazamientoBloquePos => const Offset(380, 260); // Nuevo
  Offset get emplazamientoPortalPos => const Offset(420, 260); // Nuevo
  Offset get emplazamientoEscaleraPos => const Offset(450, 245); // Nuevo
  Offset get emplazamientoPisoPos => const Offset(480, 245); // Nuevo
  Offset get emplazamientoPuertaPos => const Offset(510, 245); // Nuevo

  // Fila 2: Localidad
  Offset get emplazamientoPoblacionPos => const Offset(60, 270);
  Offset get emplazamientoProvinciaPos => const Offset(260, 270); // Nuevo
  Offset get emplazamientoCpPos => const Offset(470, 270);

  // Fila 3: Uso y Superficie
  // "Tipo de instalación" suele ser un dropdown o texto libre a la izquierda
  Offset get tipoInstalacionPos => const Offset(60, 310); // Nuevo
  Offset get usoInstalacionPos => const Offset(200, 310);
  Offset get superficiePos => const Offset(470, 310);

  // Fila 4: Estado de la instalación (Checkboxes) y CUPS
  // Y approx: 335
  Offset get checkInstalacionNuevaPos => const Offset(105, 335); // Nuevo
  Offset get checkInstalacionAmpliacionPos => const Offset(180, 335); // Nuevo
  Offset get checkInstalacionModificacionPos => const Offset(265, 335); // Nuevo
  Offset get cupsPos => const Offset(360, 335); // Nuevo

  // --- CARACTERÍSTICAS GENERALES (Técnico) ---
  // Y approx: 380 - 640

  // Bloque Izquierdo: CGP y LGA General
  Offset get cgpPos => const Offset(60, 400); // Caja General
  Offset get cgpIntensidadPos => const Offset(60, 420); // Nuevo: Intensidad CGP

  // LGA (Si/No)
  Offset get checkLgaSiPos => const Offset(250, 400); // Nuevo
  Offset get checkLgaNoPos => const Offset(280, 400); // Nuevo

  // Bloque Derecho: Detalles LGA (Conductor línea general)
  // Columna X ~ 360
  Offset get lgaNivelAislamientoPos => const Offset(480, 390); // Nuevo
  Offset get lgaMaterialAislamientoPos => const Offset(480, 405); // Nuevo
  Offset get lgaMaterialConductorPos => const Offset(480, 420); // Nuevo
  Offset get lgaSeccionPos => const Offset(480, 435);

  // Potencias
  Offset get potenciaInstalacionPos =>
      const Offset(220, 465); // "Instalación - Potencia prevista"
  Offset get potenciaDerivacionPos =>
      const Offset(220, 495); // "Derivación ind. - Potencia prevista"

  @override // Implement required getter
  Offset get potenciaPos => potenciaDerivacionPos;

  // Bloque Derecho: Detalles Derivación Individual (DI)
  // Misma X que LGA (~480), Y más abajo
  Offset get diNivelAislamientoPos => const Offset(480, 465); // Nuevo
  Offset get diMaterialAislamientoPos => const Offset(480, 480); // Nuevo
  Offset get diMaterialConductorPos => const Offset(480, 495); // Nuevo
  Offset get diSeccionPos => const Offset(480, 510); // Nuevo

  // Suministro (Tensión y Fases)
  Offset get checkMonofasicoPos => const Offset(240, 535); // Ajustado Y
  Offset get checkTrifasicoPos => const Offset(340, 535); // Ajustado Y
  @override
  Offset get tensionPos => const Offset(480, 535); // Ajustado Y

  // Protecciones Diferenciales
  Offset get proteccionDiferencialIntensidadPos => const Offset(180, 580);
  Offset get proteccionDiferencialSensibilidadPos => const Offset(330, 580);

  // Protecciones Sobreintensidades (Checkboxes)
  Offset get checkProteccionAutomaticoPos => const Offset(400, 580); // Nuevo
  Offset get checkProteccionFusiblesPos => const Offset(520, 580); // Nuevo

  // Tierras
  Offset get resistenciaTierraPos => const Offset(200, 620);
  Offset get resistenciaAislamientoPos => const Offset(480, 620); // Nuevo

  // Resto de getters requeridos por la interfaz (aunque no los usemos ahora)
  @override
  Offset get titularPos => Offset.zero;
  @override
  Offset get direccionPos => Offset.zero;
  @override
  Offset get firmaIngenieroPos => Offset.zero;
  @override
  Size get firmaBoxSize => Size.zero;
}
