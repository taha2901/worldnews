import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldnews/core/constants/app_colors.dart';
import 'package:worldnews/features/home/presentation/cubit/news_cubit.dart';
import 'package:worldnews/features/home/presentation/cubit/news_state.dart';
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
    return BlocProvider(
      create: (_) => NewsCubit()..fetchTopHeadlines(),
      child: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          final articles = state.articles;
          final featured = articles.isNotEmpty ? articles.first : null;
          final latest = articles.length > 1 ? articles.skip(1).toList() : const [];

          return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () => context.read<NewsCubit>().fetchTopHeadlines(
                  category: state.selectedCategory,
                ),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    const SliverToBoxAdapter(child: HomeHeader()),
                    SliverToBoxAdapter(
                      child: CategoryChips(
                        selectedCategory: state.selectedCategory,
                        onCategorySelected: (category) => context
                            .read<NewsCubit>()
                            .selectCategory(category),
                      ),
                    ),
                    if (state is NewsLoading && featured == null)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    if (state is NewsFailure)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Text(
                              state.message,
                              style: const TextStyle(
                                color: AppColors.ink,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (state is NewsEmpty)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Center(
                            child: Text('No articles found for this category'),
                          ),
                        ),
                      ),
                    if (featured != null)
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
                    if (latest.isNotEmpty)
                      const SliverToBoxAdapter(
                        child: SectionHeader(title: 'Latest news'),
                      ),
                    if (latest.isNotEmpty)
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
            ),
          );
        },
      ),
    );
  }
}