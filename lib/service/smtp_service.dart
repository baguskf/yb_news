import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class SmtpService {
  static Future<void> sendOtpEmail({
    required String recipientEmail,
    required String otp,
  }) async {
    final senderEmail = dotenv.env['SMTP_SENDER_EMAIL']!;
    final appPassword = dotenv.env['SMTP_APP_PASSWORD']!;

    final smtpServer = gmail(senderEmail, appPassword);

    final message = Message()
      ..from = Address(senderEmail, 'OTP Verification')
      ..recipients.add(recipientEmail)
      ..subject = 'Your OTP Code'
      ..text =
          '''
Your OTP Code is:

$otp

This code will expire in 3 minutes.
''';

    try {
      await send(message, smtpServer);
    } catch (e) {
      throw "Failed to send OTP email";
    }
  }
}
