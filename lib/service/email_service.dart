import 'package:flutter/foundation.dart' show kIsWeb;
import 'email_js_service.dart';
import 'smtp_service.dart';

class EmailService {
  static Future<void> sendOtp({
    required String recipientEmail,
    required String otp,
  }) async {
    if (kIsWeb) {
      await EmailJsService.sendOtpEmail(
        recipientEmail: recipientEmail,
        otp: otp,
      );
    } else {
      await SmtpService.sendOtpEmail(recipientEmail: recipientEmail, otp: otp);
    }
  }
}
