import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/models/news_models.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel {
  final _repo = NewsRepository();
  Future<NewsChannelHeadLines> fetchNewsChannelHeadlines(
      String channelName) async {
    final response = await _repo.fetchNewsChannelHeadlines(channelName);
    return response;
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    final response = await _repo.fetchCategoriesNewsApi(category);
    return response;
  }
}
