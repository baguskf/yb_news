import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:yb_news/models/news_model.dart';

class NewsService {
  static final client = http.Client();
  static String get newsKey => dotenv.env['NEWS_API_KEY'] ?? '';

  static String get newsUrl =>
      "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=$newsKey";

  static Future<List<Article>?> getNews() async {
    final res = await client.get(Uri.parse(newsUrl));

    if (res.statusCode == 200) {
      var responBody = res.body;

      return newsModelFromJson(responBody).articles;
    } else {
      throw Exception("Failed to load news: ${res.statusCode}");
    }
  }
}
