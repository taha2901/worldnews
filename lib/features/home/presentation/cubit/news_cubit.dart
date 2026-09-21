import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldnews/features/home/data/repo/home_repo.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit({NewsRepository? repository})
      : _repository = repository ?? NewsRepository(),
        super(const NewsInitial());

  final NewsRepository _repository;

  Future<void> fetchTopHeadlines({String? category}) async {
    final selectedCategory = category ?? state.selectedCategory;

    emit(NewsLoading(selectedCategory: selectedCategory));

    final result = await _repository.fetchTopHeadlines(
      country: 'us',
      category: selectedCategory,
    );

    if (result.isSuccess && result.data != null) {
      if (result.data!.isEmpty) {
        emit(NewsEmpty(selectedCategory: selectedCategory));
        return;
      }

      emit(NewsSuccess(
        articles: result.data!,
        selectedCategory: selectedCategory,
      ));
      return;
    }

    emit(NewsFailure(
      message: result.errorMessage ?? 'Unable to load headlines.',
      selectedCategory: selectedCategory,
    ));
  }

  Future<void> selectCategory(String category) async {
    await fetchTopHeadlines(category: category);
  }
}
