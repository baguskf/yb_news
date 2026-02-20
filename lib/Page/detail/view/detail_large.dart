import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yb_news/Page/home/controller/home_controller.dart';
import 'package:yb_news/models/news_model.dart';
import 'package:yb_news/style/colors/colors.dart';

class DetailLarge extends StatelessWidget {
  DetailLarge({super.key, required this.article});

  final Article article;

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Article article = Get.arguments;

    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      appBar: AppBar(
        title: const Text("Detail News"),
        backgroundColor: AppColors.primaryWhite,
      ),
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: Image.network(
                  article.urlToImage ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey,
                    child: const Icon(Icons.image, color: Colors.white),
                  ),
                ),
              ),

              Expanded(
                flex: 5,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title ?? '-',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 16),
                          const SizedBox(width: 6),
                          Text(homeController.formatDate(article.publishedAt)),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Expanded(
                        child: Text(
                          article.content ??
                              article.description ??
                              "No content available",
                          style: const TextStyle(fontSize: 16, height: 1.6),
                        ),
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Source",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      InkWell(
                        onTap: () async {
                          final url = Uri.parse(article.url ?? '');

                          if (await canLaunchUrl(url)) {
                            await launchUrl(
                              url,
                              mode: LaunchMode.externalApplication,
                            );
                          }
                        },
                        child: Text(
                          article.url ?? '',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
