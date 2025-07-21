class Article {
  final DateTime publishedDate;
  final String section;
  final String byline;
  final String title;
  final String abstract;
  final List<ArticleMedia> media;

  Article({
    required this.publishedDate,
    required this.section,
    required this.byline,
    required this.title,
    required this.abstract,
    required this.media,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    publishedDate:
        DateTime.tryParse(json["published_date"] ?? '') ?? DateTime.now(),
    section: json["section"] ?? '',
    byline: json["byline"] ?? '',
    title: json["title"] ?? '',
    abstract: json["abstract"] ?? '',
    media: List<ArticleMedia>.from(
      json["media"]?.map((x) => ArticleMedia.fromJson(x)) ?? [],
    ),
  );

  String get thumbnailUrl {
    if (media.isNotEmpty && media.first.mediaMetadata.isNotEmpty) {
      return media.first.mediaMetadata.first.url;
    }
    return '';
  }

  String get mediumImageUrl {
    if (media.isNotEmpty && media.first.mediaMetadata.length > 1) {
      return media.first.mediaMetadata[1].url;
    }
    return thumbnailUrl;
  }

  String get largeImageUrl {
    if (media.isNotEmpty && media.first.mediaMetadata.length > 2) {
      return media.first.mediaMetadata[2].url;
    }
    return mediumImageUrl;
  }
}

class ArticleMedia {
  final List<ArticleMediaMetadata> mediaMetadata;

  ArticleMedia({required this.mediaMetadata});

  factory ArticleMedia.fromJson(Map<String, dynamic> json) => ArticleMedia(
    mediaMetadata: List<ArticleMediaMetadata>.from(
      json["media-metadata"]?.map((x) => ArticleMediaMetadata.fromJson(x)) ??
          [],
    ),
  );
}

class ArticleMediaMetadata {
  final String url;

  ArticleMediaMetadata({required this.url});

  factory ArticleMediaMetadata.fromJson(Map<String, dynamic> json) =>
      ArticleMediaMetadata(url: json["url"] ?? '');

  Map<String, dynamic> toJson() => {"url": url};
}
