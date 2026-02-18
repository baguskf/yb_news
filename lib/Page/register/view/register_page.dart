import 'package:flutter/material.dart';
import 'package:yb_news/Page/register/view/register_large.dart';
import 'package:yb_news/Page/register/view/register_small.dart';
import 'package:yb_news/utils/responsiveness.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ResponsiveWidget(
          largeScreen: const RegisterLarge(),
          smallScreen: RegisterSmall(),
        ),
      ),
    );
  }
}
