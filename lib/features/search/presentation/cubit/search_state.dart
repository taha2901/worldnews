import 'package:worldnews/features/home/data/models/atricle_model.dart';

abstract class SearchState {
  const SearchState();

  String get query;
  List<ArticleModel> get articles;
  String? get errorMessage;
}

final class SearchInitial extends SearchState {
  const SearchInitial({this.query = ''});

  @override
  final String query;

  @override
  final List<ArticleModel> articles = const [];

  @override
  final String? errorMessage = null;
}

final class SearchLoading extends SearchState {
  const SearchLoading({required this.query});

  @override
  final String query;

  @override
  final List<ArticleModel> articles = const [];

  @override
  final String? errorMessage = null;
}

final class SearchSuccess extends SearchState {
  const SearchSuccess({
    required this.query,
    required this.articles,
  });

  @override
  final String query;

  @override
  final List<ArticleModel> articles;

  @override
  final String? errorMessage = null;
}

final class SearchEmpty extends SearchState {
  const SearchEmpty({required this.query});

  @override
  final String query;

  @override
  final List<ArticleModel> articles = const [];

  @override
  final String? errorMessage = null;
}

final class SearchFailure extends SearchState {
  const SearchFailure({
    required this.query,
    required this.message,
  });

  @override
  final String query;

  final String message;

  @override
  final List<ArticleModel> articles = const [];

  @override
  String? get errorMessage => message;
}
