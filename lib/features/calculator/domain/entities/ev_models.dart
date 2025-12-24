enum EvScheme {
  scheme1('Esquema 1: Troncal con contadores',
      'Esquema colectivo con contador principal'),
  scheme2('Esquema 2: Colectivo (Contador propio)',
      'Instalación desde contadores existentes'),
  scheme3('Esquema 3: Troncal con derivación',
      'Derivación individual para cada vehículo'),
  scheme4a('Esquema 4a: Individual (Garaje comunal)',
      'Conexión directa desde contador vivienda'),
  scheme4b('Esquema 4b: Individual (Garaje unifam.)',
      'Conexión desde cuadro general vivienda');

  final String label;
  final String description;
  const EvScheme(this.label, this.description);
}

class EvResult {
  final double section;
  final double voltageDrop;
  final double voltageDropPercent;
  final double current;
  final double protectionAmps;
  final bool isValid;
  final String message;

  EvResult({
    required this.section,
    required this.voltageDrop,
    required this.voltageDropPercent,
    required this.current,
    required this.protectionAmps,
    required this.isValid,
    required this.message,
  });
}
