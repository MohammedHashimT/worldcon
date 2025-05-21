import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worldcon/Login.dart';
import '../Shared_Preferences/shared_preferences.dart';
import '../service/delete_service.dart';

class DeleteController extends GetxController {
  final DeleteService _deleteService = DeleteService();
  final TokenService _tokenService = Get.find<TokenService>();

  var isDeleting = false.obs;
  var errorMessage = RxnString();

  Future<void> deleteAccount() async {
    final token = await _tokenService.getToken();
    if (token == null) {
      errorMessage.value = "No user token found.";
      return;
    }

    isDeleting.value = true;
    errorMessage.value = null;

    try {
      final success = await _deleteService.deleteAccount(token);

      if (success) {
        await _tokenService.removeToken();
        Get.offAll(() => LoginScreen());
        Get.snackbar("Success", "Your account has been deleted.");
      } else {
        errorMessage.value = "Account deletion failed.";
      }
    } catch (e) {
      errorMessage.value = "Error: ${e.toString()}";
    } finally {
      isDeleting.value = false;
    }
  }

  void confirmDeleteDialog() {
    Get.defaultDialog(
      backgroundColor: Colors.white,
      title: "Delete Account",
      middleText: "Are you sure you want to delete your account?",
      textConfirm: "Yes",
      textCancel: "No",
      buttonColor: Colors.white,
      confirmTextColor:Colors.red,
      cancelTextColor: Colors.green,
      onConfirm: () {
        Get.back();
        deleteAccount();
      },
      onCancel: () => Get.back(),
    );
  }
}
