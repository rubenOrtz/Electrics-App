import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

/// Pure Isar service - NO feature imports allowed
/// Schemas must be injected from outside to maintain Clean Architecture
class IsarService {
  Isar? _isar;

  /// Initialize Isar with provided schemas
  /// Schemas should be passed from injection_container where features are known
  Future<void> initialize(List<CollectionSchema> schemas) async {
    if (_isar != null) return; // Already initialized

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      schemas,
      directory: dir.path,
      name: 'electrics_app',
    );
  }

  /// Get Isar instance
  /// Returns null if not initialized - caller must handle this
  Isar? get instance {
    final currentInstance = Isar.getInstance();
    if (currentInstance != null) {
      _isar = currentInstance;
    }
    return _isar;
  }

  /// Close Isar connection
  Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }

  /// Clear all data (useful for testing/reset)
  Future<void> clearAll() async {
    final isar = instance;
    if (isar == null) return;

    await isar.writeTxn(() async {
      await isar.clear();
    });
  }
}
