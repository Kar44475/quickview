import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:quickview/core/failure/failure.dart';
import 'package:quickview/features/article_list_and_details_view/model/article_list_model.dart';
import 'package:quickview/features/article_list_and_details_view/repositories/lastest_article_repository.dart';
import 'package:quickview/features/article_list_and_details_view/viewmodel/article_viewmodel.dart';


class FakeRepository extends LastestArticleRepository {
  bool shouldFail = false;

  @override
  Future<Either<AppFailure, ArticleListModel>> getMostPopularArticles({
    required int days,
  }) async {
    if (shouldFail) {
      return Left(AppFailure('Network error'));
    }

    return Right(ArticleListModel(
      status: 'OK',
      copyright: 'Test',
      numResults: 1,
      results: [
        Result(
          publishedDate: DateTime.now(),
          section: 'Tech',
          byline: 'Test Author',
          title: 'Test Article for $days days', 
          resultAbstract: 'Test abstract',
          media: [],
        ),
      ],
    ));
  }
}

void main() {
  group('ArticleViewModel Business Logic Tests', () {
    late ProviderContainer container;
    late FakeRepository fakeRepo;

    setUp(() {
      fakeRepo = FakeRepository();
      container = ProviderContainer(
        overrides: [
          lastestArticleRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

   
    test('should update selectedDays when onDaySelected is called', () async {
      final viewModel = container.read(articleViewModelProvider.notifier);
      expect(viewModel.selectedDays, 1); 
      
      await viewModel.onDaySelected(7);
      expect(viewModel.selectedDays, 7);
      
      await viewModel.onDaySelected(30);
      expect(viewModel.selectedDays, 30);
      
      await viewModel.onDaySelected(1);
      expect(viewModel.selectedDays, 1);
    });


    test('should format app bar title correctly for singular and plural days', () async {
      final viewModel = container.read(articleViewModelProvider.notifier);

      expect(viewModel.getAppBarTitle(), 'Most Popular Articles (1 day)');
      
 
      await viewModel.onDaySelected(7);
      expect(viewModel.getAppBarTitle(), 'Most Popular Articles (7 days)');
      
    
      await viewModel.onDaySelected(30);
      expect(viewModel.getAppBarTitle(), 'Most Popular Articles (30 days)');
    });

  
    test('should format display text correctly for singular and plural days', () async {
      final viewModel = container.read(articleViewModelProvider.notifier);
      

      expect(viewModel.getDaysDisplayText(), 
             'Showing most popular articles from last 1 day');
      
 
      await viewModel.onDaySelected(7);
      expect(viewModel.getDaysDisplayText(), 
             'Showing most popular articles from last 7 days');
    });

    test('should manage loading states correctly during data fetch', () async {
      final viewModel = container.read(articleViewModelProvider.notifier);
      expect(container.read(articleViewModelProvider), isNull);  
      final future = viewModel.loadMostPopularArticles(days: 1);  
      expect(container.read(articleViewModelProvider), isA<AsyncLoading>());
      await future;
      expect(container.read(articleViewModelProvider), isA<AsyncData>());
    });

    test('should handle errors and maintain selectedDays state', () async {
      final viewModel = container.read(articleViewModelProvider.notifier);
      
      await viewModel.onDaySelected(7);
      expect(viewModel.selectedDays, 7);
      
      fakeRepo.shouldFail = true;
      await viewModel.loadMostPopularArticles(days: 30);
      
      expect(container.read(articleViewModelProvider), isA<AsyncError>());
      expect(viewModel.selectedDays, 7); 
    });

    test('should update selectedDays AND load new data when onDaySelected is called', () async {
      final viewModel = container.read(articleViewModelProvider.notifier);
      

      await viewModel.onDaySelected(7);
      expect(viewModel.selectedDays, 7);    
      final state = container.read(articleViewModelProvider);
      expect(state, isA<AsyncData>());
      expect(state!.value!.results.first.title, 'Test Article for 7 days');
    });


    test('should recover from error state when successful call is made', () async {
      final viewModel = container.read(articleViewModelProvider.notifier);
      

      fakeRepo.shouldFail = true;
      await viewModel.loadMostPopularArticles(days: 1);
      expect(container.read(articleViewModelProvider), isA<AsyncError>());
      
  
      fakeRepo.shouldFail = false;
      await viewModel.loadMostPopularArticles(days: 1);
      expect(container.read(articleViewModelProvider), isA<AsyncData>());
    });


    test('should have correct initial business state', () {
      final viewModel = container.read(articleViewModelProvider.notifier);
      
      expect(viewModel.selectedDays, 1);
      expect(viewModel.getAppBarTitle(), 'Most Popular Articles (1 day)');
      expect(viewModel.getDaysDisplayText(), 
             'Showing most popular articles from last 1 day');
      expect(container.read(articleViewModelProvider), isNull);
    });
  });
}
