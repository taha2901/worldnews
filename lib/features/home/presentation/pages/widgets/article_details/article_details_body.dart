import 'package:flutter/material.dart';
import 'package:worldnews/core/constants/app_colors.dart';
import 'package:worldnews/core/constants/format_date.dart';
import 'package:worldnews/features/home/data/atricle_model.dart';

class ArticleBody extends StatelessWidget {
  const ArticleBody({super.key, required this.article});

  final ArticleModel article;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.only(left: 24, right: 24, top: 22, bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ArticleTitle(title: article.title),
          const SizedBox(height: 18),
          AuthorRow(
            author: article.author.isEmpty
                ? article.source.name
                : article.author,
            publishedAt: article.publishedAt,
          ),
          const SizedBox(height: 22),
          const Divider(height: 1, color: AppColors.border),
          const SizedBox(height: 22),
          if (article.description.isNotEmpty)
            ArticleDescription(text: article.description),
          if (article.description.isNotEmpty) const SizedBox(height: 22),
          ArticleContent(text: article.content),
        ],
      ),
    );
  }
}

class ArticleTitle extends StatelessWidget {
  const ArticleTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: AppColors.ink,
        fontSize: 27,
        height: 1.25,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.4,
      ),
    );
  }
}

class AuthorRow extends StatelessWidget {
  const AuthorRow({
    super.key,
    required this.author,
    required this.publishedAt,
  });

  final String author;
  final String publishedAt;

  @override
  Widget build(BuildContext context) {
    final date = formatDate(publishedAt);

    return Row(
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.accent,
          child: Text(
            author.isNotEmpty ? author[0].toUpperCase() : '?',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                author,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.ink,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (date.isNotEmpty) ...[
                const SizedBox(height: 3),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      size: 13,
                      color: AppColors.muted,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      date,
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class ArticleDescription extends StatelessWidget {
  const ArticleDescription({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: const Border(
          left: BorderSide(color: AppColors.accent, width: 4),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.ink,
          fontSize: 17,
          height: 1.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class ArticleContent extends StatelessWidget {
  const ArticleContent({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final cleaned = text.replaceAll(RegExp(r'\s*\[\+\d+ chars\]$'), '');

    return Text(
      cleaned,
      style: const TextStyle(
        color: AppColors.body,
        fontSize: 16.5,
        height: 1.7,
      ),
    );
  }
}
