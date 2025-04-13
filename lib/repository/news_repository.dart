import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/models/news_models.dart';

class NewsRepository {
  Future<NewsChannelHeadLines> fetchNewsChannelHeadlines(
      String channelName) async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=$channelName&apiKey=be0837ad263c4390b3c9837d5e6b7647";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body.toString());
      return NewsChannelHeadLines.fromJson(decode);
    } else {
      throw Exception("Error");
    }
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    String url =
        "https://newsapi.org/v2/everything?q=$category&apiKey=be0837ad263c4390b3c9837d5e6b7647";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var decode = jsonDecode(response.body.toString());
      return CategoriesNewsModel.fromJson(decode);
    } else {
      throw Exception("Error");
    }
  }
}
