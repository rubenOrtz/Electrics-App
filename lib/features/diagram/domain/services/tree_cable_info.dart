class CableInfo {
  final dynamic
      cable; // ConductorAttributes? - Dynamic to avoid circular deps if needed, but typed is better
  final dynamic catalog; // CatalogMetadata?

  const CableInfo({this.cable, this.catalog});
}
