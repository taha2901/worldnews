import 'package:flutter/material.dart';
import 'package:worldnews/core/constants/app_colors.dart';
import 'package:worldnews/core/constants/format_date.dart';
import 'package:worldnews/features/home/data/atricle_model.dart';
import 'package:worldnews/features/home/presentation/pages/widgets/article_home/article_common.dart';

class ArticleListCard extends StatelessWidget {
  const ArticleListCard({
    super.key,
    required this.article,
    required this.onTap,
  });

  final ArticleModel article;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final date = formatDate(article.publishedAt);

    return Container(
      decoration: BoxDecoration(
      color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
       
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(
                  width: 104,
                  height: 104,
                  child: ArticleImage(url: article.urlToImage),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 104,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.source.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.accent,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        child: Text(
                          article.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.ink,
                            fontSize: 16,
                            height: 1.3,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      if (date.isNotEmpty)
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time_rounded,
                              size: 14,
                              color: AppColors.muted,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              date,
                              style: const TextStyle(
                                color: AppColors.muted,
                                fontSize: 12.5,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
