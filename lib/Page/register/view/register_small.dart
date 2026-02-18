import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:yb_news/Page/register/controller/register_controller.dart';
import 'package:yb_news/style/colors/colors.dart';
import 'package:yb_news/widget/form_filed_widget.dart';

class RegisterSmall extends StatelessWidget {
  RegisterSmall({super.key});

  final RegisterController registerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
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
                controller: registerController.confirmPasswordController,
                validator: registerController.validateConfirmPassword,
                onChanged: registerController.validateConfirmPasswordRealtime,
                errorText: registerController.confirmPasswordError,
                keyboardType: TextInputType.visiblePassword,
              ),
              const Gap(20),
              Container(
                width: double.infinity,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.transparent,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      color: AppColors.primaryWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Gap(20),
              RichText(
                text: TextSpan(
                  text: "Already have an account ?",
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
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
    );
  }
}
