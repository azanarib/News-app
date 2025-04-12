import 'package:news_app/models/news_models.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel {
  final _repo = NewsRepository();
  Future<NewsChannelHeadLines> fetchNewsChannelHeadlines(
      String channelName) async {
    final response = await _repo.fetchNewsChannelHeadlines(channelName);
    return response;
  }
}
