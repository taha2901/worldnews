import 'package:flutter/material.dart';
import 'package:worldnews/core/constants/app_colors.dart';
import 'package:worldnews/features/home/data/atricle_model.dart';
import 'package:worldnews/features/home/presentation/pages/article_details_page.dart';
import 'package:worldnews/features/home/presentation/pages/widgets/article_home/article_list_card.dart';
import 'package:worldnews/features/home/presentation/pages/widgets/article_home/category_chips.dart';
import 'package:worldnews/features/home/presentation/pages/widgets/article_home/featured_article_card.dart';
import 'package:worldnews/features/home/presentation/pages/widgets/article_home/home_header.dart';
import 'package:worldnews/features/home/presentation/pages/widgets/article_home/section_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final featured = mockArticles.first;
    final latest = mockArticles.skip(1).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(child: HomeHeader()),
            const SliverToBoxAdapter(child: CategoryChips()),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
                child: FeaturedArticleCard(
                  article: featured,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ArticleDetailsPage(article: featured),
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SectionHeader(title: 'Latest news')),
            SliverPadding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
              sliver: SliverList.separated(
                itemCount: latest.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) => ArticleListCard(
                  article: latest[index],
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          ArticleDetailsPage(article: latest[index]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}