import 'package:dartz/dartz.dart';
import '../entities/component_template.dart';

/// Repository interface for component template operations
abstract class ComponentRepository {
  /// Get all components (paginated)
  Future<Either<String, List<ComponentTemplate>>> getAll(
      {int offset = 0, int limit = 20});

  /// Get components by type (paginated)
  Future<Either<String, List<ComponentTemplate>>> getByType(ComponentType type,
      {int offset = 0, int limit = 20});

  /// Get single component by ID
  Future<Either<String, ComponentTemplate>> getById(String id);

  /// Search components by name (paginated)
  Future<Either<String, List<ComponentTemplate>>> search(String query,
      {int offset = 0, int limit = 20});

  /// Get favorite components
  Future<Either<String, List<ComponentTemplate>>> getFavorites();

  /// Save/update component
  Future<Either<String, void>> save(ComponentTemplate component);

  /// Delete component
  Future<Either<String, void>> delete(String id);

  /// Toggle favorite status
  Future<Either<String, void>> toggleFavorite(String id);

  /// Check if seed data exists
  Future<bool> hasSeedData();

  /// Load seed data (standard components)
  Future<Either<String, void>> loadSeedData();
}

/// Component type enum for filtering
enum ComponentType {
  protection,
  cable,
  source,
}
