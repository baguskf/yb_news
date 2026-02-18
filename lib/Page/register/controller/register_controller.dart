import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final emailError = RxnString();
  final passwordError = RxnString();
  final confirmPasswordError = RxnString();
  Timer? _passwordDebounce;
  Timer? _passwordConfirmDebounce;
  Timer? _emailDebounce;

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

    if (!emailRegex.hasMatch(value)) {
      return "Invalid email format";
    }

    return null;
  }

  void validateEmailRealtime(String value) {
    if (_emailDebounce?.isActive ?? false) {
      _emailDebounce!.cancel();
    }

    _emailDebounce = Timer(const Duration(milliseconds: 400), () {
      emailError.value = validateEmail(value);
    });
  }

  String? validateRegisterPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Password is required";
    }

    if (value.length < 8) {
      return "Minimum 8 characters";
    }

    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(value);
    final hasNumber = RegExp(r'[0-9]').hasMatch(value);

    if (!hasLetter || !hasNumber) {
      return "Must contain letters & numbers";
    }

    return null;
  }

  void validatePasswordRealtime(String value) {
    if (_passwordDebounce?.isActive ?? false) {
      _passwordDebounce!.cancel();
    }

    _passwordDebounce = Timer(const Duration(milliseconds: 400), () {
      passwordError.value = validateRegisterPassword(value);

      if (confirmPasswordController.text.isNotEmpty) {
        confirmPasswordError.value = validateConfirmPassword(
          confirmPasswordController.text,
        );
      }
    });
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Confirm password is required";
    }

    if (value != passwordController.text) {
      return "Password does not match";
    }

    return null;
  }

  void validateConfirmPasswordRealtime(String value) {
    if (_passwordConfirmDebounce?.isActive ?? false) {
      _passwordConfirmDebounce!.cancel();
    }

    _passwordConfirmDebounce = Timer(const Duration(milliseconds: 400), () {
      confirmPasswordError.value = validateConfirmPassword(value);
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
