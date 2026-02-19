import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:yb_news/models/news_model.dart';
import 'package:yb_news/service/news_service.dart';

class HomeController extends GetxController {
  RxList<Article> newsListData = <Article>[].obs;
  RxList<Article> filteredArticles = <Article>[].obs;

  final TextEditingController searchController = TextEditingController();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<List<Article>> fetchNews() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final res = await NewsService.getNews();
      newsListData.assignAll(res!);
      filteredArticles.assignAll(res);

      return res;
    } catch (e) {
      errorMessage.value = e.toString();
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Timer? _debounce;

  void searchNews(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      if (query.isEmpty) {
        filteredArticles.assignAll(newsListData);
      } else {
        filteredArticles.assignAll(
          newsListData
              .where(
                (article) => (article.title ?? '').toLowerCase().contains(
                  query.toLowerCase(),
                ),
              )
              .toList(),
        );
      }
    });
  }

  String formatDate(DateTime? date) {
    if (date == null) return '-';

    return "${date.day}/${date.month}/${date.year}";
  }
}
