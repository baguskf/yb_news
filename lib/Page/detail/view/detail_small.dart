import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yb_news/Page/home/controller/home_controller.dart';
import 'package:yb_news/models/news_model.dart';

class DetailSmall extends StatelessWidget {
  DetailSmall({super.key, required this.article});

  final Article article;

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Article article = Get.arguments;

    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(title: const Text("Detail News")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              article.urlToImage ?? '',
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 240,
                color: Colors.grey,
                child: const Icon(Icons.image, color: Colors.white),
              ),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 📰 Judul
                  Text(
                    article.title ?? '-',
                    style: const TextStyle(
                      fontSize: 22,
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

                  Text(
                    article.content ??
                        article.description ??
                        "No content available",
                    style: const TextStyle(fontSize: 16, height: 1.6),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Source",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
