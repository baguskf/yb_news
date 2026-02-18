import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yb_news/models/user_models.dart';
import 'package:yb_news/service/auth_service.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool isLoading = false.obs;
  RxnString errorMessage = RxnString();

  final emailError = RxnString();
  final passwordError = RxnString();

  Timer? _emailDebounce;
  Timer? _passwordDebounce;

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

  String? validateLoginPassword(String? value) {
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
      passwordError.value = validateLoginPassword(value);
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

  Future<UserModel?> login() async {
    errorMessage.value = null;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      errorMessage.value = "Email & Password required";
      return null;
    }

    if (emailError.value != null || passwordError.value != null) {
      errorMessage.value = "Please fix form errors";
      return null;
    }

    isLoading.value = true;

    try {
      final user = await _authService.login(email, password);
      return user;
    } catch (e) {
      errorMessage.value = e.toString();
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
