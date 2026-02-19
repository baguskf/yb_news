import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:yb_news/models/user_models.dart';
import 'package:yb_news/service/auth_service.dart';

class RegisterController extends GetxController {
  final AuthService _authService = AuthService();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RxBool isLoading = false.obs;
  RxnString errorMessage = RxnString();

  final emailError = RxnString();
  final nameError = RxnString();
  final passwordError = RxnString();
  final confirmPasswordError = RxnString();
  Timer? _passwordDebounce;
  Timer? _passwordConfirmDebounce;
  Timer? _emailDebounce;
  Timer? _nameDebounce;

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

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Nama wajib diisi";
    }

    final name = value.trim();

    if (name.length < 2) {
      return "Nama minimal 2 karakter";
    }

    final regex = RegExp(r"^[a-zA-Z\s]+$");

    if (!regex.hasMatch(name)) {
      return "Nama hanya boleh huruf";
    }

    return null;
  }

  void validateNameRealtime(String value) {
    if (_nameDebounce?.isActive ?? false) {
      _nameDebounce!.cancel();
    }

    _nameDebounce = Timer(const Duration(milliseconds: 400), () {
      nameError.value = validateName(value);
    });
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

  Future<UserModel?> register() async {
    errorMessage.value = null;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final name = nameController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      errorMessage.value = "Please fill all fields";
      return null;
    }

    if (nameError.value != null ||
        emailError.value != null ||
        passwordError.value != null ||
        confirmPasswordError.value != null) {
      errorMessage.value = "Please fix form errors";
      return null;
    }

    isLoading.value = true;

    try {
      final user = await _authService.register(email, password);
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
    confirmPasswordController.dispose();
    super.onClose();
  }
}
