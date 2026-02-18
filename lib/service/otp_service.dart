import 'package:yb_news/service/email_service.dart';

import '../utils/otp_generator.dart';

class OtpData {
  final String code;
  final DateTime expiredAt;

  OtpData({required this.code, required this.expiredAt});
}

class OtpService {
  static final Map<String, OtpData> otpStorage = {};

  static Future<void> requestOtp(String email) async {
    final otp = OtpGenerator.generate().toUpperCase();

    otpStorage[email] = OtpData(
      code: otp,
      expiredAt: DateTime.now().add(const Duration(minutes: 3)),
    );

    await EmailService.sendOtp(recipientEmail: email, otp: otp);
  }

  static String? verifyOtp({required String email, required String inputOtp}) {
    final data = otpStorage[email];

    if (data == null) {
      return "OTP not found";
    }

    if (DateTime.now().isAfter(data.expiredAt)) {
      otpStorage.remove(email);
      return "OTP expired, please request a new one";
    }

    if (data.code != inputOtp) {
      return "Invalid OTP";
    }

    otpStorage.remove(email);
    return null; // success
  }

  static Duration? getRemainingTime(String email) {
    final data = otpStorage[email];
    if (data == null) return null;
    return data.expiredAt.difference(DateTime.now());
  }
}
