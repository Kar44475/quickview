import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:quickview/core/constants/server_constant.dart';
import 'package:quickview/core/failure/failure.dart';
import 'package:quickview/features/article_list_and_details_view/model/article_list_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'lastest_article_repository.g.dart';

class LastestArticleRepository {
  Future<Either<AppFailure, ArticleListModel>> getMostPopularArticles({
    required int days,
  }) async {
    try {
      final url =
          '${ServerConstant.serverURL}/emailed/$days.json?api-key=${ServerConstant.apiKey}'; 

      final res = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );
      if (res.statusCode != 200) {
        var resBodyMap = jsonDecode(res.body);
        return Left(
          AppFailure(
            resBodyMap['fault']?['faultstring'] ?? 'Failed to load articles',
          ),
        );
      }
      final articleModel = articleModelFromJson(res.body);
      return Right(articleModel);
    } catch (e) {
      return Left(AppFailure(e.toString()));
    }
  }
}

@riverpod
LastestArticleRepository lastestArticleRepository(Ref ref) {
  return LastestArticleRepository();
}
