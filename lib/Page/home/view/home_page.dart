import 'package:flutter/material.dart';
import 'package:yb_news/Page/home/view/home_large.dart';
import 'package:yb_news/Page/home/view/home_small.dart';
import 'package:yb_news/utils/responsiveness.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ResponsiveWidget(
          largeScreen: HomeLarge(),
          smallScreen: HomeSmall(),
        ),
      ),
    );
  }
}
