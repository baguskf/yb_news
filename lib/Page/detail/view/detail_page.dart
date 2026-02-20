import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_news/Page/detail/view/detail_large.dart';
import 'package:yb_news/Page/detail/view/detail_small.dart';
import 'package:yb_news/models/news_model.dart';
import 'package:yb_news/utils/responsiveness.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Article article = Get.arguments;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ResponsiveWidget(
          largeScreen: DetailLarge(article: article),
          smallScreen: DetailSmall(article: article),
        ),
      ),
    );
  }
}
