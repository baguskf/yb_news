import 'package:get/get.dart';
import 'package:yb_news/Page/login/controller/login_controller.dart';
import 'package:yb_news/Page/otp/controller/otp_controller.dart';

class OtpBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpController>(() => OtpController());
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
