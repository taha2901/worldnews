import 'package:worldnews/features/home/data/models/atricle_model.dart';

abstract class NewsState {
  const NewsState();

  String get selectedCategory;
  List<ArticleModel> get articles;
  String? get errorMessage;
}

final class NewsInitial extends NewsState {
  const NewsInitial({this.selectedCategory = 'general'});

  @override
  final String selectedCategory;

  @override
  final List<ArticleModel> articles = const [];

  @override
  final String? errorMessage = null;
}

final class NewsLoading extends NewsState {
  const NewsLoading({
    this.selectedCategory = 'general',
    this.articles = const [],
  });

  @override
  final String selectedCategory;

  @override
  final List<ArticleModel> articles;

  @override
  final String? errorMessage = null;
}

final class NewsSuccess extends NewsState {
  const NewsSuccess({
    required this.articles,
    required this.selectedCategory,
  });

  @override
  final List<ArticleModel> articles;

  @override
  final String selectedCategory;

  @override
  final String? errorMessage = null;
}

final class NewsEmpty extends NewsState {
  const NewsEmpty({this.selectedCategory = 'general'});

  @override
  final String selectedCategory;

  @override
  final List<ArticleModel> articles = const [];

  @override
  final String? errorMessage = null;
}

final class NewsFailure extends NewsState {
  const NewsFailure({
    required this.message,
    this.selectedCategory = 'general',
  });

  final String message;

  @override
  final String selectedCategory;

  @override
  final List<ArticleModel> articles = const [];

  @override
  String? get errorMessage => message;
}
