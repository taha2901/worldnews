import 'package:flutter/material.dart';
import 'package:worldnews/core/constants/format_date.dart';
import 'package:worldnews/features/home/data/atricle_model.dart';
import 'package:worldnews/features/home/presentation/pages/widgets/article_home/article_common.dart';

class FeaturedArticleCard extends StatelessWidget {
  const FeaturedArticleCard({
    super.key,
    required this.article,
    required this.onTap,
  });

  final ArticleModel article;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final date = formatDate(article.publishedAt);

    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: SizedBox(
        height: 280,
        child: Stack(
          children: [
            ArticleImage(url: article.urlToImage),
           
            Positioned(
              left: 18,
              right: 18,
              bottom: 18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SourceBadge(name: article.source.name),
                  const SizedBox(height: 12),
                  Text(
                    article.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      height: 1.25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (date.isNotEmpty)
                    const SizedBox(height: 8),
                  if (date.isNotEmpty)
                    Text(
                      date,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
