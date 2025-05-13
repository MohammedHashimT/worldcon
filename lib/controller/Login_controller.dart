import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worldcon/view/NavigationBar.dart';

import '../service/Login_service.dart';

class LoginController extends GetxController {
  final ApiService _apiService = Get.put(ApiService());

  final emailController = TextEditingController();
  final otpController = TextEditingController();

  var isLoading = false.obs;
  var isOtpSent = false.obs;
  var errorMessage = RxnString();

  @override
  void onClose() {
    emailController.dispose();
    otpController.dispose();
    super.onClose();
  }

  Future<void> sendOtp() async {
    if (emailController.text.isEmpty ||
        !GetUtils.isEmail(emailController.text.trim())) {
      errorMessage.value = "Please enter a valid email address.";
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    try {
      final response = await _apiService.generateOtp(
        emailController.text.trim(),
      );

      if (response.isOk && response.body['status'] == true) {
        isOtpSent.value = true;
        Get.snackbar(
          "Success",
          response.body['message'] ??
              "OTP sent successfully to ${emailController.text}.",
        );
      } else {
        String apiError = "Failed to send OTP.";
        if (response.body != null && response.body['message'] != null) {
          apiError = response.body['message'];
        } else if (response.statusText != null &&
            response.statusText!.isNotEmpty) {
          apiError = response.statusText!;
        }
        errorMessage.value = apiError;
        isOtpSent.value = false;
      }
    } catch (e) {
      errorMessage.value = "An unexpected error occurred: ${e.toString()}";
      isOtpSent.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtpAndLogin() async {
    if (otpController.text.isEmpty || otpController.text.length < 4) {
      errorMessage.value = "Please enter a valid OTP.";
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    try {
      final response = await _apiService.verifyOtp(
        emailController.text.trim(),
        otpController.text.trim(),
      );

      if (response.isOk && response.body['status'] == true) {
        Get.snackbar(
          "Success",
          response.body['message'] ?? "Login successful!",
        );
        Get.offAll(() => CustomNavigationBar());
      } else {
        String apiError = "Login failed. Invalid OTP or an error occurred.";
        if (response.body != null && response.body['message'] != null) {
          apiError = response.body['message'];
        } else if (response.statusText != null &&
            response.statusText!.isNotEmpty) {
          apiError = response.statusText!;
        }
        errorMessage.value = apiError;
      }
    } catch (e) {
      errorMessage.value = "An unexpected error occurred: ${e.toString()}";
    } finally {
      isLoading.value = false;
    }
  }
}
