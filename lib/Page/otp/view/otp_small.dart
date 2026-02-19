import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:yb_news/Page/login/controller/login_controller.dart';
import 'package:yb_news/Page/otp/controller/otp_controller.dart';
import 'package:yb_news/routes/routes_name.dart';
import 'package:yb_news/service/otp_service.dart';

class OtpSmallPage extends StatelessWidget {
  OtpSmallPage({super.key});

  final LoginController loginController = Get.find();
  final OtpController otpController = Get.find();

  @override
  Widget build(BuildContext context) {
    final String email = Get.arguments;

    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            const Text(
              "OTP Verification",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xff3F3D56),
              ),
            ),

            const SizedBox(height: 12),

            Text(
              "Enter the OTP sent to $email",
              style: const TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            OtpTextField(
              numberOfFields: 8,
              borderColor: const Color(0xff3F3D56),
              focusedBorderColor: const Color(0xff3F3D56),
              showFieldAsBox: false,
              borderRadius: BorderRadius.circular(10),
              fieldWidth: 35,
              fieldHeight: 60,
              keyboardType: TextInputType.visiblePassword,
              textStyle: const TextStyle(fontSize: 14),
              inputFormatters: [
                TextInputFormatter.withFunction((oldValue, newValue) {
                  return newValue.copyWith(
                    text: newValue.text.toUpperCase(),
                    selection: newValue.selection,
                  );
                }),
              ],
              onSubmit: (String code) {
                final error = OtpService.verifyOtp(
                  email: email,
                  inputOtp: code.toUpperCase(),
                );

                if (error == null) {
                  Get.offAndToNamed(RoutesName.home);
                } else {
                  Get.snackbar("OTP Failed", error);
                }
              },
            ),

            Obx(() {
              final isDisabled = otpController.remainingSeconds.value > 0;

              return Column(
                children: [
                  TextButton(
                    onPressed: isDisabled
                        ? null
                        : () {
                            otpController.resendOtp(email);
                          },
                    child: const Text("Resend OTP"),
                  ),

                  if (isDisabled)
                    Text(
                      "Resend in ${otpController.formatTime()}",
                      style: const TextStyle(color: Colors.red, fontSize: 13),
                    ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
