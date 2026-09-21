import 'package:flutter/material.dart';
import 'package:worldnews/core/constants/app_colors.dart';
import 'package:worldnews/features/home/data/models/atricle_model.dart';
import 'package:worldnews/features/home/presentation/pages/widgets/article_home/article_common.dart';

class ArticleDetailsHeader extends StatelessWidget {
  const ArticleDetailsHeader({super.key, required this.article});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 340,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: RoundIconButton(
          icon: Icons.arrow_back_rounded,
          tooltip: 'Back',
          onPressed: () => Navigator.maybePop(context),
        ),
      ),
      actions: [
        RoundIconButton(
          icon: Icons.ios_share_rounded,
          tooltip: 'Share',
          onPressed: () {},
        ),
        const SizedBox(width: 8),
        RoundIconButton(
          icon: Icons.bookmark_border_rounded,
          tooltip: 'Save',
          onPressed: () {},
        ),
        const SizedBox(width: 16),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [ArticleImage(url: article.urlToImage)],
        ),
      ),
      bottom:  PreferredSize(
        preferredSize: const Size.fromHeight(28),
        child: Container(
          height: 28,
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
        ),
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 40,
        height: 40,
        child: IconButton(
          onPressed: onPressed,
          tooltip: tooltip,
          icon: Icon(icon),
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            iconSize: 20,
            backgroundColor: Colors.white.withAlpha(235),
            foregroundColor: AppColors.ink,
            shadowColor: Colors.black,
            elevation: 2,
          ),
        ),
      ),
    );
  }
}
