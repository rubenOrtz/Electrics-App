class SpanishDocumentValidator {
  /// Validates DNI with proper letter algorithm (BOE)
  static bool isValidDNI(String dni) {
    if (dni.length != 9) return false;
    final number = int.tryParse(dni.substring(0, 8));
    if (number == null) return false;
    final letter = dni[8].toUpperCase();
    const letters = 'TRWAGMYFPDXBNJZSQVHLCKE';
    return letter == letters[number % 23];
  }

  /// Validates NIE format
  static bool isValidNIE(String nie) {
    if (nie.length != 9) return false;
    final first = nie[0].toUpperCase();
    if (!['X', 'Y', 'Z'].contains(first)) return false;
    // Replace X=0, Y=1, Z=2, then validate as DNI
    final normalized =
        nie.replaceFirst(first, {'X': '0', 'Y': '1', 'Z': '2'}[first]!);
    return isValidDNI(normalized);
  }

  /// Validates CIF with checksum algorithm
  static bool isValidCIF(String cif) {
    if (cif.length != 9) return false;
    final type = cif[0].toUpperCase();
    if (!'ABCDEFGHJNPQRSUVW'.contains(type)) return false;

    final digits = cif.substring(1, 8);
    if (int.tryParse(digits) == null) return false;

    // Checksum calculation (specific algorithm)
    int sum = 0;
    for (int i = 0; i < digits.length; i++) {
      int digit = int.parse(digits[i]);
      if (i % 2 == 0) {
        digit *= 2;
        digit = digit ~/ 10 + digit % 10;
      }
      sum += digit;
    }
    final control = (10 - (sum % 10)) % 10;

    final lastChar = cif[8];
    // Can be letter or digit depending on type
    if ('NPQRSW'.contains(type)) {
      return lastChar == 'JABCDEFGHI'[control];
    } else {
      return lastChar == control.toString() ||
          lastChar == 'JABCDEFGHI'[control];
    }
  }

  /// Validates Spanish Engineer ID (Nº Colegiado)
  /// Format: COITI/COGITI provincial codes (e.g., "MAD-12345" or "12345-MAD")
  static bool isValidEngineerID(String engineerId) {
    if (engineerId.isEmpty) return false;

    // Common formats:
    // - Provincial: "MAD-12345", "BCN-54321"
    // - National: "12345" (legacy)
    // - COGITI: Prefix + number (varies by province)

    // Basic validation: contains digits and optional province code
    final hasDigits = RegExp(r'\d+').hasMatch(engineerId);
    if (!hasDigits) return false;

    // Extract numeric part
    final numericPart = engineerId.replaceAll(RegExp(r'[^0-9]'), '');
    if (numericPart.isEmpty || numericPart.length < 3) return false;

    // Valid if has minimum 3 digits and reasonable length
    return engineerId.length >= 3 && engineerId.length <= 20;
  }
}
