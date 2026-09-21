class ArticleModel {
  const ArticleModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    final sourceJson = json['source'];
    final source = SourceModel.fromJson(
      sourceJson is Map<String, dynamic> ? sourceJson : <String, dynamic>{},
    );

    return ArticleModel(
      source: source,
      author: json['author'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      url: json['url'] as String? ?? '',
      urlToImage: json['urlToImage'] as String? ?? '',
      publishedAt: json['publishedAt'] as String? ?? '',
      content: json['content'] as String? ?? '',
    );
  }

  final SourceModel source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
}

class SourceModel {
  const SourceModel({required this.id, required this.name});

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Unknown Source',
    );
  }

  final String id;
  final String name;
}

const List<ArticleModel> mockArticles = [
  ArticleModel(
    source: SourceModel(id: 'daily-horizon', name: 'Daily Horizon'),
    author: 'Sarah Mitchell',
    title: 'World leaders meet for climate talks',
    description:
        'Delegates from more than 60 countries opened a week of negotiations '
        'aimed at agreeing on new emission targets.',
    url: 'https://example.com/climate-talks',
    urlToImage: 'https://picsum.photos/id/1015/1200/900',
    publishedAt: '2026-09-20T08:15:00Z',
    content:
        'Negotiators arrived with very different priorities, but many say '
        'there is a rare sense of urgency this year. Early sessions focused '
        'on financing for countries most affected by rising temperatures, '
        'and a first draft of the agreement is expected within days… '
        '[+3120 chars]',
  ),
  ArticleModel(
    source: SourceModel(id: 'tech-pulse', name: 'Tech Pulse'),
    author: 'Daniel Reyes',
    title: 'Tech companies launch new AI tools',
    description:
        'Several major companies announced assistants built for everyday '
        'work, from writing to planning.',
    url: 'https://example.com/ai-tools',
    urlToImage: 'https://picsum.photos/id/1018/1200/900',
    publishedAt: '2026-09-19T17:40:00Z',
    content:
        'The new tools focus on saving time on routine tasks. Early testers '
        'say the biggest change is how naturally the assistants fit into '
        'apps they already use, rather than living in a separate window… '
        '[+2210 chars]',
  ),
  ArticleModel(
    source: SourceModel(id: 'business-brief', name: 'Business Brief'),
    author: 'Amira Hassan',
    title: 'Local market sees a strong rebound',
    description:
        'After a slow summer, shoppers are back and small businesses report '
        'their best week in months.',
    url: 'https://example.com/market-rebound',
    urlToImage: 'https://picsum.photos/id/1025/1200/900',
    publishedAt: '2026-09-19T09:05:00Z',
    content:
        'Shop owners credit a mix of seasonal demand and new payment options '
        'for the jump in sales. Analysts caution that the recovery is still '
        'fragile but say the early signs are encouraging… [+1480 chars]',
  ),
  ArticleModel(
    source: SourceModel(id: 'nature-notes', name: 'Nature Notes'),
    author: 'Lena Fischer',
    title: 'Scientists map a new deep-sea ecosystem',
    description:
        'A research team documented dozens of species never seen before '
        'near a remote underwater ridge.',
    url: 'https://example.com/deep-sea',
    urlToImage: 'https://picsum.photos/id/1043/1200/900',
    publishedAt: '2026-09-18T12:00:00Z',
    content:
        'Using a remotely operated vehicle, the team spent three weeks '
        'surveying the ridge. They describe a landscape of glowing '
        'organisms and mineral chimneys teeming with life… [+2675 chars]',
  ),
  ArticleModel(
    source: SourceModel(id: 'sports-ledger', name: 'Sports Ledger'),
    author: 'Omar Khaled',
    title: 'Championship final decided by a dramatic penalty shootout',
    description:
        'A goalkeeper who came on in the final minute saved two penalties '
        'to hand his side the trophy.',
    url: 'https://example.com/final',
    urlToImage: 'https://picsum.photos/id/1035/1200/900',
    publishedAt: '2026-09-17T21:30:00Z',
    content:
        'The match was level after extra time, and the shootout went to '
        'sudden death. Fans stayed in the stadium long after the final '
        'whistle to celebrate with the players… [+1890 chars]',
  ),
  ArticleModel(
    source: SourceModel(id: 'health-today', name: 'Health Today'),
    author: 'Priya Nair',
    title: 'New study links daily walking to better sleep',
    description:
        'Researchers found that people who walked 30 minutes a day fell '
        'asleep faster and woke up less at night.',
    url: 'https://example.com/walking-sleep',
    urlToImage: 'https://picsum.photos/id/1039/1200/900',
    publishedAt: '2026-09-16T07:45:00Z',
    content:
        'The study followed 1,200 adults over six months. Participants who '
        'kept a steady walking routine reported deeper sleep, even when '
        'their overall activity level stayed the same… [+2040 chars]',
  ),
];
