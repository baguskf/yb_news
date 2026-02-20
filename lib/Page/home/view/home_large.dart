import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:yb_news/Page/home/controller/home_controller.dart';

import 'package:yb_news/Page/home/view/news_page_large.dart';
import 'package:yb_news/Page/home/view/profile_page.dart';
import 'package:yb_news/style/colors/colors.dart';

class HomeLarge extends StatelessWidget {
  HomeLarge({super.key});
  final HomeController homeController = Get.find();

  final pages = [NewsPageLarge(), const ProfilePage()];

  @override
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.primaryWhite,
        body: pages[homeController.selectedIndex.value],

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.primaryWhite,
          currentIndex: homeController.selectedIndex.value,

          onTap: (index) {
            homeController.selectedIndex.value = index;
          },

          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.article), label: "News"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
