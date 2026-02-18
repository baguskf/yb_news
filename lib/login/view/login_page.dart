import 'package:flutter/material.dart';
import 'package:yb_news/login/view/login_large.dart';
import 'package:yb_news/login/view/login_small.dart';
import 'package:yb_news/utils/responsiveness.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ResponsiveWidget(
          largeScreen: const LoginPageLarge(),
          smallScreen: LoginPageSmall(),
        ),
      ),
    );
  }
}
