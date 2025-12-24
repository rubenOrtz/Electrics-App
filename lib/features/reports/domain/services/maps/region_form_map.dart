import 'dart:ui';

/// Defines the coordinate mapping and configuration for a specific regional form.
abstract class RegionFormMap {
  /// Path to the PDF template asset
  String get templateAsset;

  /// Maximum number of circuit rows that fit in the main form's table
  int get maxCircuitRows;

  // --- Common Fields ---
  Offset get titularPos;
  Offset get direccionPos;
  Offset get tensionPos;
  Offset get potenciaPos;
  Offset get firmaIngenieroPos;

  // Size for the signature box
  Size get firmaBoxSize;
}
