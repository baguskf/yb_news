import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:yb_news/style/colors/colors.dart';
import 'package:yb_news/widget/form_filed_widget.dart';

class RegisterSmall extends StatelessWidget {
  const RegisterSmall({super.key});

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
              const FromFieldWidget(
                label: 'Email',
                hint: 'Enter an email address',
                isRequired: true,
              ),
              const Gap(20),
              const FromFieldWidget(
                label: 'Password',
                hint: 'Enter an password',
                isRequired: true,
              ),
              const Gap(20),
              const FromFieldWidget(
                label: 'Password Confrimation',
                hint: 'Enter an password confirmation',
                isRequired: true,
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
