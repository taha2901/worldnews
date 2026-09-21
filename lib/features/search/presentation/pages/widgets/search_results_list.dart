import 'package:flutter/material.dart';
import 'package:worldnews/core/constants/app_colors.dart';
import 'package:worldnews/features/home/data/models/atricle_model.dart';
import 'package:worldnews/features/home/presentation/pages/article_details_page.dart';
import 'package:worldnews/features/home/presentation/pages/widgets/article_home/article_list_card.dart';

class SearchResultsList extends StatelessWidget {
  const SearchResultsList({super.key, required this.articles});

  final List<ArticleModel> articles;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: articles.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final article = articles[index];

        return ArticleListCard(
          article: article,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ArticleDetailsPage(article: article),
            ),
          ),
        );
      },
    );
  }
}

class SearchEmptyState extends StatelessWidget {
  const SearchEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: AppColors.surface,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.search_rounded,
              size: 36,
              color: AppColors.accent,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Start searching',
            style: TextStyle(
              color: AppColors.ink,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Search for headlines, topics, and stories you care about.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.muted,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
