import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodel/article_viewmodel.dart';
import '../widget/article_list_widget.dart';

class ArticleListView extends ConsumerWidget {
  const ArticleListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleState = ref.watch(articleViewModelProvider);
    final viewModel = ref.read(articleViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.getAppBarTitle()),
        actions: [
          PopupMenuButton<int>(
            onSelected: (days) => viewModel.onDaySelected(days),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 1, child: Text('1 Day')),
              const PopupMenuItem(value: 7, child: Text('7 Days')),
              const PopupMenuItem(value: 30, child: Text('30 Days')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              viewModel.getDaysDisplayText(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            child: articleState?.when(
              data: (articles) => ArticleListWidget(articles: articles.results),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: $error'),
                    ElevatedButton(
                      onPressed: () => viewModel.loadMostPopularArticles(days: viewModel.selectedDays),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ) ?? const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
