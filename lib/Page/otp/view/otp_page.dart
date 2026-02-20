import 'package:flutter/material.dart';
import 'package:yb_news/Page/otp/view/otp_large.dart';
import 'package:yb_news/Page/otp/view/otp_small.dart';
import 'package:yb_news/utils/responsiveness.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ResponsiveWidget(
          largeScreen: OtpLargePage(),
          smallScreen: OtpSmallPage(),
        ),
      ),
    );
  }
}
