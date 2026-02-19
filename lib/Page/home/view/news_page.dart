import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:yb_news/Page/home/controller/home_controller.dart';
import 'package:yb_news/routes/routes_name.dart';

class NewsPage extends StatelessWidget {
  NewsPage({super.key});
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          if (homeController.isOnline.value) return const SizedBox();

          return Container(
            width: double.infinity,
            color: Colors.red,
            padding: const EdgeInsets.all(8),
            child: const Text(
              "Offline Mode",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          );
        }),
        const Gap(60),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: homeController.searchController,
                    onChanged: homeController.searchNews,
                    decoration: const InputDecoration(
                      hintText: "Search",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Obx(() {
                  final selected = homeController.selectedCategory.value;

                  return PopupMenuButton<String>(
                    icon: const Icon(Icons.tune, color: Colors.grey),

                    onSelected: (value) {
                      homeController.selectedCategory.value = value;
                      homeController.fetchNews(category: value);
                    },

                    itemBuilder: (context) => homeController.categories
                        .map(
                          (cat) => PopupMenuItem(
                            value: cat,
                            child: Row(
                              children: [
                                if (selected == cat)
                                  const Icon(Icons.check, size: 18),

                                if (selected == cat) const SizedBox(width: 8),

                                Text(cat.toUpperCase()),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  );
                }),
              ],
            ),
          ),
        ),
        const Gap(15),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: FutureBuilder(
              future: homeController.fetchNews(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 40,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Failed to fetch news",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          snapshot.error.toString(),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            homeController.fetchNews();
                          },
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(child: Text("No data available"));
                }

                return Obx(() {
                  final articles = homeController.filteredArticles;

                  if (articles.isEmpty) {
                    return const Center(child: Text("No results found"));
                  }

                  return ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];

                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(RoutesName.detail, arguments: article);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    article.urlToImage ?? '',
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      width: 90,
                                      height: 90,
                                      color: Colors.grey,
                                      child: const Icon(
                                        Icons.image,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        article.title ?? '-',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 6),

                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.access_time,
                                            size: 14,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(width: 4),

                                          Flexible(
                                            child: Text(
                                              homeController.formatDate(
                                                article.publishedAt,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(width: 8),

                                          Flexible(
                                            child: Text(
                                              article.source?.name ?? 'Unknown',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 8),

                                      Text(
                                        article.description ?? '-',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
