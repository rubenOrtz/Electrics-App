import '../../domain/repositories/price_repository.dart';

class MockPriceRepository implements PriceRepository {
  final Map<String, double> _prices = {
    // Linked Protections (Schneider)
    'SCH-IC60N-C10': 18.20,
    'SCH-IC60N-C16': 18.50,
    'SCH-IC60N-C20': 19.10,
    'SCH-IC60N-C25': 20.50,
    'SCH-IID-40-30': 45.00, // Differential

    // Generic Protections
    'GEN-PIA-10': 6.20,
    'GEN-PIA-16': 6.50,
    'GEN-PIA-20': 6.80,
    'GEN-PIA-25': 7.10,
    'GEN-DIFF-40-30': 25.00,

    // Cables (Price per meter)
    // 3P = Mono (F+N+T), 5P = Tri (3F+N+T)
    'CABLE-CU-1.5-3P': 0.85,
    'CABLE-CU-2.5-3P': 1.20,
    'CABLE-CU-4.0-3P': 1.80,
    'CABLE-CU-6.0-3P': 2.45,
    'CABLE-CU-10.0-3P': 4.10,

    'CABLE-CU-1.5-5P': 1.40,
    'CABLE-CU-2.5-5P': 1.95,
    'CABLE-CU-4.0-5P': 2.90,
    'CABLE-CU-6.0-5P': 4.20,
    'CABLE-CU-10.0-5P': 6.50,
    'CABLE-CU-16.0-5P': 9.80,

    // Aluminum (Cheaper)
    'CABLE-AL-16.0-5P': 4.50,
    'CABLE-AL-25.0-5P': 6.20,

    // Enclosures
    'ENCLOSURE-STD': 120.00,
  };

  @override
  Future<double?> getPrice(String key) async {
    // Simulate network delay if needed, but for mock return immediately
    return _prices[key];
  }
}
