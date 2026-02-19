import 'package:get/get.dart';
import 'package:yb_news/Page/home/controller/home_controller.dart';

import 'package:yb_news/Page/login/controller/login_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
