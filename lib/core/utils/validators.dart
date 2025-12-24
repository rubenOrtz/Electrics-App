import '../constants/app_strings.dart';

/// Pure Dart form validators
class Validators {
  const Validators._();

  // ============================================================================
  // EMAIL
  // ============================================================================

  /// Validates email format
  /// Returns error message if invalid, null if valid
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailRequired;
    }

    // RFC 5322 simplified regex
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
    );

    if (!emailRegex.hasMatch(value)) {
      return AppStrings.emailInvalid;
    }

    return null;
  }

  // ============================================================================
  // REQUIRED
  // ============================================================================

  /// Validates that field is not empty
  /// [fieldName] is used in error message
  static String? required(String? value, {String fieldName = 'Este campo'}) {
    if (value == null || value.isEmpty) {
      return AppStrings.format(
        AppStrings.fieldRequired,
        [fieldName],
      );
    }
    return null;
  }

  // ============================================================================
  // NUMBERS
  // ============================================================================

  /// Validates positive number (> 0)
  static String? positiveNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingresa un número';
    }

    final number = double.tryParse(value);
    if (number == null || number <= 0) {
      return AppStrings.mustBePositive;
    }

    return null;
  }

  /// Validates non-negative number (>= 0)
  static String? nonNegativeNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingresa un número';
    }

    final number = double.tryParse(value);
    if (number == null || number < 0) {
      return 'Debe ser un número no negativo';
    }

    return null;
  }

  /// Validates number within range [min, max]
  static String? range(String? value, double min, double max) {
    if (value == null || value.isEmpty) {
      return 'Ingresa un valor';
    }

    final number = double.tryParse(value);
    if (number == null || number < min || number > max) {
      return AppStrings.format(
        AppStrings.mustBeInRange,
        [min, max],
      );
    }

    return null;
  }

  /// Validates integer
  static String? integer(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingresa un número entero';
    }

    final number = int.tryParse(value);
    if (number == null) {
      return 'Debe ser un número entero';
    }

    return null;
  }

  // ============================================================================
  // ELECTRICAL SPECIFIC
  // ============================================================================

  /// Validates power factor (0.1 to 1.0)
  static String? powerFactor(String? value) {
    return range(value, 0.1, 1.0);
  }

  /// Validates voltage (must be positive)
  static String? voltage(String? value) {
    return positiveNumber(value);
  }

  /// Validates current (must be positive)
  static String? current(String? value) {
    return positiveNumber(value);
  }

  /// Validates power (must be positive)
  static String? power(String? value) {
    return positiveNumber(value);
  }

  /// Validates cable section (common values: 1.5, 2.5, 4, 6, 10, 16, etc.)
  static String? cableSection(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingresa la sección del cable';
    }

    final section = double.tryParse(value);
    if (section == null || section < 1.5) {
      return 'La sección mínima es 1.5 mm²';
    }

    // Common sections: 1.5, 2.5, 4, 6, 10, 16, 25, 35, 50, 70, 95, 120, 150, 185, 240
    const validSections = [
      1.5,
      2.5,
      4.0,
      6.0,
      10.0,
      16.0,
      25.0,
      35.0,
      50.0,
      70.0,
      95.0,
      120.0,
      150.0,
      185.0,
      240.0,
    ];

    if (!validSections.contains(section)) {
      return 'Sección no estándar. Valores comunes: 1.5, 2.5, 4, 6, 10, 16, 25, etc.';
    }

    return null;
  }

  /// Validates cable length (must be positive)
  static String? cableLength(String? value) {
    final error = positiveNumber(value);
    if (error != null) return error;

    final length = double.parse(value!);
    if (length > 1000) {
      return 'Longitud muy grande (máx. 1000m)';
    }

    return null;
  }

  // ============================================================================
  // COMBINED VALIDATORS
  // ============================================================================

  /// Combines multiple validators
  /// Returns first error found, or null if all pass
  static String? combine(
    String? value,
    List<String? Function(String?)> validators,
  ) {
    for (final validator in validators) {
      final error = validator(value);
      if (error != null) return error;
    }
    return null;
  }
}
