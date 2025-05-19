import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worldcon/service/feedback_post_service.dart';

class FeedbackPostController extends GetxController {
  var isSubmitting = false.obs;
  var submissionErrorMessage = RxnString();
  var submissionSuccess = false.obs;

  final FeedbackPostService _submitService = FeedbackPostService();

  Future<void> submitFeedback(
    List<Map<String, dynamic>> submissionsData,
  ) async {
    if (submissionsData.isEmpty) {
      Get.snackbar(
        "Info",
        "No answers to submit.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isSubmitting.value = true;
    submissionErrorMessage.value = null;
    submissionSuccess.value = false;

    try {
      final Response response = await _submitService
          .submitMultipleFeedbackResponses(submissionsData);

      if (response.isOk) {
        if (response.body != null && response.body is Map) {
          final Map<String, dynamic> responseBody = response.body;
          final String apiStatus =
              responseBody['status']?.toString().toLowerCase() ?? 'unknown';
          final String apiMessage =
              responseBody['message'] ?? 'No message from server.';

          if (apiStatus == 'success') {
            submissionSuccess.value = true;
            Get.snackbar(
              "Success",
              apiMessage,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
          } else {
            submissionErrorMessage.value = apiMessage;
            Get.snackbar(
              "Info",
              apiMessage,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.orange.shade700,
              colorText: Colors.white,
            );
          }
        } else {
          submissionErrorMessage.value =
              "Received an unexpected successful response from the server.";
          Get.snackbar(
            "Server Error",
            submissionErrorMessage.value!,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        String apiErrorMessage = "Failed to submit feedback.";
        if (response.body != null && response.body is Map) {
          final Map<String, dynamic> errorData = response.body;
          if (errorData['message'] != null) {
            apiErrorMessage = errorData['message'];
          } else if (errorData['errors'] != null &&
              errorData['errors'] is Map) {
            List<String> errorMessages = [];
            (errorData['errors'] as Map).forEach((key, value) {
              if (value is List) {
                errorMessages.add("$key: ${value.join(', ')}");
              } else {
                errorMessages.add("$key: $value");
              }
            });
            if (errorMessages.isNotEmpty)
              apiErrorMessage = errorMessages.join('; ');
          }
        } else if (response.bodyString != null &&
            response.bodyString!.isNotEmpty) {
          apiErrorMessage +=
              " Server: ${response.bodyString!.substring(0, (response.bodyString!.length > 100 ? 100 : response.bodyString!.length))}";
        } else {
          apiErrorMessage += " (Status: ${response.statusCode})";
        }
        submissionErrorMessage.value = apiErrorMessage;
        Get.snackbar(
          "Error",
          apiErrorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      debugPrint(
        "FeedbackPostController submitFeedback Exception: ${e.toString()}",
      );
      submissionErrorMessage.value = e.toString();
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSubmitting.value = false;
    }
  }
}
