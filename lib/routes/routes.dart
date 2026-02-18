import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:yb_news/home/view/home_page.dart';
import 'package:yb_news/login/view/login_page.dart';

class Routes {
  static const home = '/home';
  static const login = '/login';

  static final pages = [
    GetPage(name: home, page: () => const HomePage()),
    GetPage(name: login, page: () => const LoginPage()),
  ];
}
