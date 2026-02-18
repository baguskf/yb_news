import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

const int largeScreenSize = 1280;
const int mediumScreenSize = 768;
const int smallScreenSize = 360;

class ResponsiveWidget extends StatelessWidget {
  final Widget largeScreen;
  final Widget? mediumScreen;
  final Widget smallScreen;

  const ResponsiveWidget({
    Key? key,
    required this.largeScreen,
    this.mediumScreen,
    required this.smallScreen,
  }) : super(key: key);

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < mediumScreenSize;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= mediumScreenSize &&
        MediaQuery.of(context).size.width < largeScreenSize;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > largeScreenSize;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (kIsWeb) {
          if (constraints.maxWidth >= largeScreenSize) {
            return largeScreen;
          } else if (constraints.maxWidth < largeScreenSize &&
              constraints.maxWidth > mediumScreenSize) {
            return mediumScreen ?? largeScreen;
          } else {
            return smallScreen;
          }
        } else {
          return smallScreen;
        }
      },
    );
  }
}
