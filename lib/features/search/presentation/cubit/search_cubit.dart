import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldnews/features/home/data/repo/home_repo.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({NewsRepository? repository})
      : _repository = repository ?? NewsRepository(),
        super(const SearchInitial());

  final NewsRepository _repository;

  void _safeEmit(SearchState newState) {
    if (!isClosed) {
      emit(newState);
    }
  }

  Future<void> search(String query) async {
    final trimmed = query.trim();

    if (trimmed.isEmpty) {
      _safeEmit(const SearchInitial());
      return;
    }

    _safeEmit(SearchLoading(query: trimmed));

    final result = await _repository.searchArticles(query: trimmed);

    if (isClosed) return;

    if (result.isSuccess && result.data != null) {
      if (result.data!.isEmpty) {
        _safeEmit(SearchEmpty(query: trimmed));
        return;
      }

      _safeEmit(SearchSuccess(query: trimmed, articles: result.data!));
      return;
    }

    _safeEmit(
      SearchFailure(
        query: trimmed,
        message: result.errorMessage ?? 'Something went wrong while searching.',
      ),
    );
  }
}
