import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:yb_news/Page/login/controller/login_controller.dart';
import 'package:yb_news/routes/routes_name.dart';
import 'package:yb_news/service/otp_service.dart';
import 'package:yb_news/style/colors/colors.dart';
import 'package:yb_news/widget/form_filed_widget.dart';

class LoginPageLarge extends StatelessWidget {
  LoginPageLarge({super.key});

  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(40),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const Gap(40),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Hello",
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Again!",
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D6CDF),
                          ),
                        ),
                      ),
                      const Gap(20),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Welcome back you’ve\nbeen missed",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const Gap(50),
                      FromFieldWidget(
                        controller: loginController.emailController,
                        validator: loginController.validateEmail,
                        onChanged: loginController.validateEmailRealtime,
                        errorText: loginController.emailError,
                        keyboardType: TextInputType.emailAddress,
                        label: 'Email',
                        hint: 'Enter an email address',
                        isRequired: true,
                      ),
                      const Gap(20),
                      FromFieldWidget(
                        controller: loginController.passwordController,
                        validator: loginController.validateLoginPassword,
                        onChanged: loginController.validatePasswordRealtime,
                        errorText: loginController.passwordError,
                        keyboardType: TextInputType.visiblePassword,
                        label: 'Password',
                        hint: 'Enter Password',
                        isRequired: true,
                      ),
                      const Gap(20),
                      Obx(() {
                        final loading = loginController.isLoading.value;

                        return Container(
                          width: double.infinity,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.blue,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: FilledButton(
                            onPressed: loading
                                ? null
                                : () async {
                                    final user = await loginController.login();

                                    if (user != null) {
                                      OtpService.requestOtp(
                                        loginController.emailController.text
                                            .trim(),
                                      );

                                      if (user.isFisrtLogin == true) {
                                        OtpService.requestOtp(
                                          loginController.emailController.text
                                              .trim(),
                                        );

                                        Get.offAllNamed(RoutesName.otp);
                                      } else {
                                        Get.offAllNamed(RoutesName.home);
                                      }
                                    } else {
                                      Get.snackbar(
                                        "Login Failed",
                                        loginController.errorMessage.value ??
                                            "An error occurred",
                                        backgroundColor: Colors.redAccent,
                                        colorText: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 12,
                                        ),
                                      );
                                    }
                                  },
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              elevation: 0,
                            ),
                            child: loading
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.primaryWhite,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        );
                      }),
                      const Gap(20),
                      RichText(
                        text: TextSpan(
                          text: "don’t have an account ?",
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                          children: [
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed('/register');
                                },
                                child: const Text(
                                  " Sign Up",
                                  style: TextStyle(
                                    color: Color(0xFF2D6CDF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
