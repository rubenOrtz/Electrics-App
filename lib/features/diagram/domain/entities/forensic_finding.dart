import 'package:freezed_annotation/freezed_annotation.dart';

part 'forensic_finding.freezed.dart';

enum FindingSeverity {
  info,
  warning,
  critical,
}

@freezed
class ForensicFinding with _$ForensicFinding {
  const factory ForensicFinding({
    required String code, // Código único del error (e.g. 'LOOSE_CONNECTION')
    required String title, // Título corto
    required String description, // Explicación detallada
    required FindingSeverity severity,
    required double measuredValue,
    required double theoreticalValue, // Valor esperado o límite
  }) = _ForensicFinding;
}
