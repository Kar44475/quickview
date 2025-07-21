import 'package:quickview/core/model/article_model.dart';
import '../model/article_list_model.dart';

extension ResultToArticle on Result {
  Article toArticle() {
    return Article(
      publishedDate: publishedDate,
      section: section,
      byline: byline,
      title: title,
      abstract: resultAbstract,
      media: media
          .map(
            (m) => ArticleMedia(
              mediaMetadata: m.mediaMetadata
                  .map(
                    (meta) => ArticleMediaMetadata(
                      url: meta.url,
                    ),
                  )
                  .toList(),
            ),
          )
          .toList(),
    );
  }
}
