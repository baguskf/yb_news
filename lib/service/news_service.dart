import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:yb_news/models/news_model.dart';

class NewsService {
  static final client = http.Client();
  static String get newsKey => dotenv.env['NEWS_API_KEY'] ?? '';

  static String newsUrl({String? category}) {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=$newsKey";

    if (category != null && category != "all") {
      url += "&category=$category";
    }

    return url;
  }

  static Future<List<Article>> getNews({String? category}) async {
    final res = await client.get(Uri.parse(newsUrl(category: category)));

    if (res.statusCode == 200) {
      final body = res.body;

      final articles = newsModelFromJson(body).articles;

      return articles ?? [];
    } else {
      throw Exception("Failed to load news (${res.statusCode})");
    }
  }
}
