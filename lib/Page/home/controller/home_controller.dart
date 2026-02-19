import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:yb_news/models/news_model.dart';
import 'package:yb_news/service/news_service.dart';

class HomeController extends GetxController {
  RxList<Article> newsListData = <Article>[].obs;
  RxList<Article> filteredArticles = <Article>[].obs;

  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  final RxInt selectedIndex = 0.obs;

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var selectedCategory = "all".obs;

  final categories = [
    "all",
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology",
  ];

  //network state
  var isOnline = true.obs;

  late StreamSubscription _networkSub;

  @override
  void onInit() {
    super.onInit();

    _initNetworkListener();

    fetchNews(category: selectedCategory.value);
  }

  void _initNetworkListener() async {
    final connectivity = Connectivity();

    final results = await connectivity.checkConnectivity();
    _updateConnection(results);

    _networkSub = connectivity.onConnectivityChanged.listen((results) {
      _updateConnection(results);
    });
  }

  void _updateConnection(List<ConnectivityResult> results) {
    final wasOffline = !isOnline.value;

    if (kIsWeb) {
      isOnline.value =
          results.isNotEmpty && !results.contains(ConnectivityResult.none);
    } else {
      isOnline.value = !results.contains(ConnectivityResult.none);
    }

    if (wasOffline && isOnline.value) {
      fetchNews(category: selectedCategory.value);
      searchNews(searchController.text);
    }
  }

  Future<List<Article>> fetchNews({String? category}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final res = await NewsService.getNews(
        category: category ?? selectedCategory.value,
      );

      newsListData.assignAll(res);
      filteredArticles.assignAll(res);
      isOnline.value = true;
      return res;
    } catch (e) {
      errorMessage.value = e.toString();

      throw Exception(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

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

  @override
  void onClose() {
    _networkSub.cancel();
    super.onClose();
  }
}
