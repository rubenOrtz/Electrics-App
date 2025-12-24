part of 'component_library_cubit.dart';

@freezed
class ComponentLibraryState with _$ComponentLibraryState {
  const factory ComponentLibraryState.initial({
    @Default(false) bool isLoading,
    @Default([]) List<ComponentTemplate> allComponents,
    @Default([]) List<ComponentTemplate> filteredComponents,
    ComponentType? selectedType,
    @Default('') String searchQuery,
    @Default(false) bool hasReachedMax,
    String? error,
  }) = _Initial;
}
