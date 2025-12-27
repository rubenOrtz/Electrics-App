import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/component_template.dart';
import '../../domain/repositories/component_repository.dart';

part 'component_library_state.dart';
part 'component_library_cubit.freezed.dart';

class ComponentLibraryCubit extends Cubit<ComponentLibraryState> {
  final ComponentRepository repository;

  ComponentLibraryCubit(this.repository)
      : super(const ComponentLibraryState.initial());

  static const int _pageSize = 20;

  Future<void> loadAll() async {
    emit(state.copyWith(
      isLoading: true,
      error: null,
      filteredComponents: [],
      hasReachedMax: false,
    ));

    final result = await repository.getAll(offset: 0, limit: _pageSize);

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, error: error)),
      (components) => emit(state.copyWith(
        isLoading: false,
        allComponents: components,
        filteredComponents: components,
        hasReachedMax: components.length < _pageSize,
      )),
    );
  }

  Future<void> loadMore() async {
    if (state.hasReachedMax || state.isLoading) return;

    final offset = state.filteredComponents.length;

    final result = state.selectedType != null
        ? await repository.getByType(state.selectedType!,
            offset: offset, limit: _pageSize)
        : state.searchQuery.isNotEmpty
            ? await repository.search(state.searchQuery,
                offset: offset, limit: _pageSize)
            : await repository.getAll(offset: offset, limit: _pageSize);

    result.fold(
      (error) => emit(state.copyWith(error: error)),
      (components) => emit(state.copyWith(
        filteredComponents: [...state.filteredComponents, ...components],
        hasReachedMax: components.length < _pageSize,
      )),
    );
  }

  Future<void> filterByType(ComponentType? type) async {
    if (type == null) {
      emit(state.copyWith(
        filteredComponents: [],
        selectedType: null,
        hasReachedMax: false,
      ));
      return loadAll();
    }

    emit(state.copyWith(
      isLoading: true,
      selectedType: type,
      filteredComponents: [],
      hasReachedMax: false,
    ));

    final result =
        await repository.getByType(type, offset: 0, limit: _pageSize);

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, error: error)),
      (components) => emit(state.copyWith(
        isLoading: false,
        filteredComponents: components,
        hasReachedMax: components.length < _pageSize,
      )),
    );
  }

  Future<void> searchComponents(String query) async {
    if (query.isEmpty) {
      emit(state.copyWith(
        filteredComponents: [],
        searchQuery: '',
        hasReachedMax: false,
      ));
      return loadAll();
    }

    emit(state.copyWith(
      isLoading: true,
      searchQuery: query,
      filteredComponents: [],
      hasReachedMax: false,
    ));

    final result = await repository.search(query, offset: 0, limit: _pageSize);

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, error: error)),
      (components) => emit(state.copyWith(
        isLoading: false,
        filteredComponents: components,
        hasReachedMax: components.length < _pageSize,
      )),
    );
  }

  Future<void> getFavorites() async {
    emit(state.copyWith(isLoading: true));

    final result = await repository.getFavorites();

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, error: error)),
      (components) => emit(state.copyWith(
        isLoading: false,
        filteredComponents: components,
      )),
    );
  }

  Future<void> toggleFavorite(String id) async {
    final result = await repository.toggleFavorite(id);

    result.fold(
      (error) => emit(state.copyWith(error: error)),
      (_) => _refresh(), // Reload respecting filter
    );
  }

  Future<void> saveComponent(ComponentTemplate component) async {
    emit(state.copyWith(isLoading: true));

    final result = await repository.save(component);

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, error: error)),
      (_) => _refresh(),
    );
  }

  Future<void> deleteComponent(String id) async {
    emit(state.copyWith(isLoading: true));

    final result = await repository.delete(id);

    result.fold(
      (error) => emit(state.copyWith(isLoading: false, error: error)),
      (_) => _refresh(),
    );
  }

  Future<void> loadSeedData() async {
    final result = await repository.loadSeedData();

    result.fold(
      (error) => emit(state.copyWith(error: error)),
      (_) => _refresh(),
    );
  }

  Future<void> _refresh() async {
    if (state.selectedType != null) {
      return filterByType(state.selectedType);
    }
    // We don't have a persisted search query in state for searchComponents to just 'rerun' easily
    // unless we modify searchComponents to not clear it?
    // Looking at searchComponents: emit(state.copyWith(isLoading: true, searchQuery: query));
    // So state.searchQuery should be available.
    if (state.searchQuery.isNotEmpty) {
      return searchComponents(state.searchQuery);
    }
    return loadAll();
  }
}
