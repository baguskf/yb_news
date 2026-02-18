import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:yb_news/home/view/home_page.dart';
import 'package:yb_news/login/controller/login_binding.dart';
import 'package:yb_news/login/view/login_page.dart';
import 'package:yb_news/register/controller/register_binding.dart';
import 'package:yb_news/register/view/register_page.dart';
import 'package:yb_news/routes/routes_name.dart';

class Routes {
  static final pages = [
    GetPage(name: RoutesName.home, page: () => const HomePage()),
    GetPage(
      name: RoutesName.login,
      binding: LoginBinding(),
      page: () => const LoginPage(),
    ),
    GetPage(
      name: RoutesName.register,
      binding: RegisterBinding(),
      page: () => const RegisterPage(),
    ),
  ];
}
