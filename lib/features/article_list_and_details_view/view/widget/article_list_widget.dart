import 'package:flutter/material.dart';
import 'package:quickview/features/article_list_and_details_view/model/article_list_model.dart';
import 'package:quickview/features/article_list_and_details_view/view/widget/article_card_widget.dart';
import 'package:quickview/features/article_list_and_details_view/view/widget/empty_article_widget.dart';

class ArticleListWidget extends StatelessWidget {
  final List<Result> articles;

  const ArticleListWidget({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    if (articles.isEmpty) {
      return const EmptyArticlesWidget();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return ArticleCardWidget(article: article);
      },
    );
  }
}
