import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_news/routes/routes_name.dart';
import 'package:yb_news/service/auth_service.dart';
import 'package:yb_news/style/colors/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                _logout();
              },
              icon: const Icon(Icons.logout, color: AppColors.primaryWhite),
              label: const Text(
                "Logout",
                style: TextStyle(color: AppColors.primaryWhite),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logout() {
    AuthService().logout();
    Get.snackbar(
      "Logout",
      "You have been logged out",
      snackPosition: SnackPosition.BOTTOM,
    );

    Get.offAllNamed(RoutesName.login);
  }
}
