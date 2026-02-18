import 'package:get/get.dart';
import 'package:yb_news/Page/otp/controller/otp_controller.dart';

class OtpBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpController>(() => OtpController());
  }
}
