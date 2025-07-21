
import 'package:quickview/core/model/article_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_selected_article_notifier.g.dart';

@Riverpod(keepAlive: true)
class CurrentSelectedArticleNotifier extends _$CurrentSelectedArticleNotifier {
  @override
  Article? build() {
    return null;
  }

  void addArticle(Article article) {
    state = article;
  }
}
