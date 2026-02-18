import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class EmailJsService {
  static final serviceId = dotenv.env['EMAILJS_SERVICE_ID']!;
  static final templateId = dotenv.env['EMAILJS_TEMPLATE_ID']!;
  static final publicKey = dotenv.env['EMAILJS_PUBLIC_KEY']!;

  static Future<void> sendOtpEmail({
    required String recipientEmail,
    required String otp,
  }) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': publicKey,
        'template_params': {'email': recipientEmail, 'otp': otp},
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("EmailJS failed: ${response.body}");
    }
  }
}
