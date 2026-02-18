import 'dart:async';
import 'package:get/get.dart';
import 'package:yb_news/service/otp_service.dart';

class OtpController extends GetxController {
  RxInt remainingSeconds = 180.obs;
  Timer? _timer;

  void startCountdown() {
    _timer?.cancel();
    remainingSeconds.value = 180;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value == 0) {
        timer.cancel();
      } else {
        remainingSeconds.value--;
      }
    });
  }

  void resendOtp(String email) async {
    await OtpService.requestOtp(email);
    startCountdown();
  }

  String formatTime() {
    final minutes = remainingSeconds.value ~/ 60;
    final seconds = remainingSeconds.value % 60;

    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  void onInit() {
    super.onInit();
    startCountdown();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
