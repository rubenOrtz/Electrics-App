/// Base class for all use cases following Clean Architecture principles.
///
/// Use cases encapsulate business logic and orchestrate data flow between
/// the data layer and presentation layer. Each use case should have a single
/// responsibility and return results wrapped in Either<Failure, T> for
/// proper error handling.
///
/// Type parameters:
/// * [T] - The type of data returned on success
/// * [Params] - The type of parameters required for execution

abstract class UseCase<T, Params> {
  /// Executes the use case with optional parameters.
  ///
  /// Returns a Future that completes with the result of type [T].
  /// Implementations should handle errors appropriately.
  Future<T> call({Params params});
}
