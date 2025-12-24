/// Representa el estado de salud de toda la instalación eléctrica.
/// Calculado dinámicamente a partir de errores teóricos y verificaciones de campo.
class InstallationHealth {
  /// Puntuación de salud (0-100)
  /// 0-40: Crítico
  /// 41-70: Precaución
  /// 71-90: Bueno
  /// 91-100: Excelente
  final int score;

  /// Número de errores críticos detectados
  final int criticalCount;

  /// Número de advertencias detectadas
  final int warningCount;

  /// Número de fallos en verificaciones (teoría vs realidad)
  final int verificationFailures;

  /// Nivel de seguridad clasificado
  final SecurityLevel securityLevel;

  /// Estado de cumplimiento normativo
  final ComplianceStatus complianceStatus;

  /// Fecha y hora del último cálculo
  final DateTime? lastCalculated;

  const InstallationHealth({
    required this.score,
    required this.criticalCount,
    required this.warningCount,
    required this.verificationFailures,
    required this.securityLevel,
    required this.complianceStatus,
    this.lastCalculated,
  });

  /// Clasificación textual del score
  String get classification {
    if (score >= 91) return 'Excelente';
    if (score >= 71) return 'Bueno';
    if (score >= 41) return 'Precaución';
    return 'Crítico';
  }

  /// Color asociado al score
  int get classificationColor {
    if (score >= 91) return 0xFF4CAF50; // Verde
    if (score >= 71) return 0xFF2196F3; // Azul
    if (score >= 41) return 0xFFFF9800; // Naranja
    return 0xFFF44336; // Rojo
  }

  InstallationHealth copyWith({
    int? score,
    int? criticalCount,
    int? warningCount,
    int? verificationFailures,
    SecurityLevel? securityLevel,
    ComplianceStatus? complianceStatus,
    DateTime? lastCalculated,
  }) {
    return InstallationHealth(
      score: score ?? this.score,
      criticalCount: criticalCount ?? this.criticalCount,
      warningCount: warningCount ?? this.warningCount,
      verificationFailures: verificationFailures ?? this.verificationFailures,
      securityLevel: securityLevel ?? this.securityLevel,
      complianceStatus: complianceStatus ?? this.complianceStatus,
      lastCalculated: lastCalculated ??
          this.lastCalculated, // Keep optional in copyWith if needed, but field is now nullable
    );
  }
}

/// Nivel de seguridad de la instalación
enum SecurityLevel {
  critical, // Peligro inmediato
  low, // Seguridad comprometida
  medium, // Seguridad aceptable
  high, // Seguridad óptima
}

/// Estado de cumplimiento normativo (REBT/IEC)
enum ComplianceStatus {
  pass, // Cumple normativa
  fail, // No cumple (errores críticos)
  reviewRequired, // Requiere revisión (warnings)
}
