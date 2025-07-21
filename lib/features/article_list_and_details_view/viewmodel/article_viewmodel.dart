import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repositories/lastest_article_repository.dart';
import '../model/article_list_model.dart';

part 'article_viewmodel.g.dart';

@riverpod
class ArticleViewModel extends _$ArticleViewModel {
  int _selectedDays = 1; 

  @override
  AsyncValue<ArticleListModel>? build() {
    Future.microtask(() => loadMostPopularArticles(days: _selectedDays));
    return null;
  }


  int get selectedDays => _selectedDays;

  Future<void> loadMostPopularArticles({required int days}) async {
    state = const AsyncValue.loading();

    try {
      final repository = ref.read(lastestArticleRepositoryProvider);
      final result = await repository.getMostPopularArticles(days: days);

      result.fold(
        (failure) =>
            state = AsyncValue.error(failure.message, StackTrace.current),
        (articles) => state = AsyncValue.data(articles),
      );
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> onDaySelected(int days) async {
    _selectedDays = days; 
    await loadMostPopularArticles(days: days);
  }

  String getAppBarTitle() {
    return 'Most Popular Articles ($_selectedDays ${_selectedDays == 1 ? 'day' : 'days'})';
  }

  String getDaysDisplayText() {
    return 'Showing most popular articles from last $_selectedDays ${_selectedDays == 1 ? 'day' : 'days'}';
  }
}
