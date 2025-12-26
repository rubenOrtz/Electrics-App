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

  /// Validates Spanish Engineer ID (Colegiado).
  ///
  /// **Format:** COITI/COGITI standard format
  /// - Provincial: "MAD-12345", "BCN-54321" (2-3 letter province + hyphen + 3-10 digits)
  /// - Alternative: Letters followed by digits "ABC12345"
  ///
  /// **Examples:**
  /// - ✅ Valid: "MAD-12345", "BCN-987", "COITI-12345", "ABC1234"
  /// - ❌ Invalid: "---123", "ABC", "12345" (no letters), "A-B-C-1-2-3"
  static bool isValidEngineerID(String engineerId) {
    if (engineerId.isEmpty) return false;

    // Strict format: Province code (2-5 letters) + hyphen + 3-10 digits
    // OR: Letters (2-5) followed directly by 3-10 digits
    final strictFormat = RegExp(r'^[A-Z]{2,5}-\d{3,10}$');
    final alternateFormat = RegExp(r'^[A-Z]{2,5}\d{3,10}$');

    return strictFormat.hasMatch(engineerId.toUpperCase()) ||
        alternateFormat.hasMatch(engineerId.toUpperCase());
  }
}
