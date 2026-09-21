import 'package:flutter/material.dart';
import 'package:worldnews/core/constants/app_colors.dart';
import 'package:worldnews/features/home/data/atricle_model.dart';
import 'package:worldnews/features/home/presentation/pages/widgets/article_details/article_details_body.dart';
import 'package:worldnews/features/home/presentation/pages/widgets/article_details/article_details_header.dart';
import 'package:worldnews/features/home/presentation/pages/widgets/article_details/read_full_article_bar.dart';

class ArticleDetailsPage extends StatelessWidget {
  const ArticleDetailsPage({super.key, required this.article});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          ArticleDetailsHeader(article: article),
          SliverToBoxAdapter(child: ArticleBody(article: article)),
        ],
      ),
      bottomNavigationBar: const ReadFullArticleBar(),
    );
  }
}