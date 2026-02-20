import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:yb_news/routes/routes_name.dart';
import 'package:yb_news/style/colors/colors.dart';
import 'package:yb_news/widget/form_filed_widget.dart';

import '../controller/register_controller.dart';

class RegisterLarge extends StatelessWidget {
  RegisterLarge({super.key});
  final RegisterController registerController = Get.find();

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
                          "Hello!",
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
                          "Signup to get Started",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const Gap(70),
                      FromFieldWidget(
                        label: 'Name',
                        hint: 'Enter your name',
                        isRequired: true,
                        controller: registerController.nameController,
                        validator: registerController.validateName,
                        onChanged: registerController.validateNameRealtime,
                        errorText: registerController.nameError,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const Gap(20),
                      FromFieldWidget(
                        label: 'Email',
                        hint: 'Enter an email address',
                        isRequired: true,
                        controller: registerController.emailController,
                        validator: registerController.validateEmail,
                        onChanged: registerController.validateEmailRealtime,
                        errorText: registerController.emailError,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const Gap(20),
                      FromFieldWidget(
                        label: 'Password',
                        hint: 'Enter an password',
                        isRequired: true,
                        controller: registerController.passwordController,
                        validator: registerController.validateRegisterPassword,
                        onChanged: registerController.validatePasswordRealtime,
                        errorText: registerController.passwordError,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const Gap(20),
                      FromFieldWidget(
                        label: 'Password Confrimation',
                        hint: 'Enter an password confirmation',
                        isRequired: true,
                        controller:
                            registerController.confirmPasswordController,
                        validator: registerController.validateConfirmPassword,
                        onChanged:
                            registerController.validateConfirmPasswordRealtime,
                        errorText: registerController.confirmPasswordError,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const Gap(20),
                      Obx(() {
                        final loading = registerController.isLoading.value;

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
                                    final user = await registerController
                                        .register();

                                    if (user != null) {
                                      Get.offNamed(
                                        RoutesName.login,
                                        arguments: registerController
                                            .emailController
                                            .text
                                            .trim(),
                                      );
                                    } else {
                                      Get.snackbar(
                                        "Register Failed",
                                        registerController.errorMessage.value ??
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
                                    'Register',
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
                          text: "Already have an account ?",
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                          children: [
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  Get.offNamed('/login');
                                },
                                child: const Text(
                                  " Login",
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
