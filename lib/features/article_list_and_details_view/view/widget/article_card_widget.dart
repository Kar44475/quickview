import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:quickview/core/provider/current_selected_article_notifier.dart';
import 'package:quickview/core/widget/utils.dart';
import 'package:quickview/features/article_list_and_details_view/extensions/extension.dart';
import 'package:quickview/features/article_list_and_details_view/model/article_list_model.dart';
import 'package:quickview/features/article_list_and_details_view/view/pages/article_detail_view.dart';
import 'package:quickview/features/article_list_and_details_view/view/widget/article_image_widget.dart';
class ArticleCardWidget extends ConsumerWidget {
  final Result article;

  const ArticleCardWidget({super.key, required this.article});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 2,
      child: ListTile(
        leading: ArticleImage(thumbnailUrl: article.thumbnailUrl),
        title: Text(
          article.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.resultAbstract,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '${article.section} • ${article.byline} • ${formatDate(article.publishedDate)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        onTap: () => {
          ref
              .read(currentSelectedArticleNotifierProvider.notifier)
              .addArticle(article.toArticle()),

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ArticleDetailView()),
          ),
        },
      ),
    );
  }
}