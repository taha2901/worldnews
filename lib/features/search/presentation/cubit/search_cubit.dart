import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldnews/features/home/data/repo/home_repo.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({NewsRepository? repository})
      : _repository = repository ?? NewsRepository(),
        super(const SearchInitial());

  final NewsRepository _repository;

  Future<void> search(String query) async {
    final trimmed = query.trim();

    if (trimmed.isEmpty) {
      emit(const SearchInitial());
      return;
    }

    emit(SearchLoading(query: trimmed));

    final result = await _repository.searchArticles(query: trimmed);

    if (result.isSuccess && result.data != null) {
      if (result.data!.isEmpty) {
        emit(SearchEmpty(query: trimmed));
        return;
      }

      emit(SearchSuccess(query: trimmed, articles: result.data!));
      return;
    }

    emit(
      SearchFailure(
        query: trimmed,
        message: result.errorMessage ?? 'Something went wrong while searching.',
      ),
    );
  }
}
