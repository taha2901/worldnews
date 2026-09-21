import 'package:worldnews/features/home/data/models/atricle_model.dart';

import '../../../../core/network/api_constants.dart';
import '../../../../core/network/api_result.dart';
import '../../../../core/network/api_service.dart';

class NewsRepository {
  NewsRepository({ApiService? apiService}) : _apiService = apiService ?? ApiService();

  final ApiService _apiService;

  Future<ApiResult<List<ArticleModel>>> fetchTopHeadlines({
    String country = 'us',
    String? category,
  }) async {
    final result = await _apiService.get(
      ApiConstants.topHeadlines,
      queryParameters: {
        'country': country,
        if (category != null && category.isNotEmpty) 'category': category,
      },
    );

    if (!result.isSuccess || result.data == null) {
      return ApiResult.failure(result.errorMessage ?? 'Failed to load headlines');
    }

    final articles = result.data!['articles'];
    if (articles is! List) {
      return ApiResult.failure('No articles found');
    }

    final list = articles
        .whereType<Map>()
        .map((e) => ArticleModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    return ApiResult.success(list);
  }

  Future<ApiResult<List<ArticleModel>>> searchArticles({
    required String query,
    String language = 'en',
    String sortBy = 'publishedAt',
    int pageSize = 20,
    int page = 1,
  }) async {
    if (query.trim().isEmpty) {
      return ApiResult.failure('Search query cannot be empty');
    }

    final result = await _apiService.get(
      ApiConstants.everything,
      queryParameters: {
        'q': query.trim(),
        'language': language,
        'sortBy': sortBy,
        'pageSize': pageSize,
        'page': page,
      },
    );

    if (!result.isSuccess || result.data == null) {
      return ApiResult.failure(result.errorMessage ?? 'Search failed');
    }

    final articles = result.data!['articles'];
    if (articles is! List) {
      return ApiResult.failure('No articles found');
    }

    final list = articles
        .whereType<Map>()
        .map((e) => ArticleModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    return ApiResult.success(list);
  }
}
