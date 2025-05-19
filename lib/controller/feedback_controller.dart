import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worldcon/model/feedback_model.dart';
import 'package:worldcon/service/feedback_service.dart';

class FeedbackController extends GetxController {
  var isLoading = true.obs;
  var feedbackList = <FeedbackModel>[].obs;
  var errorMessage = RxnString();
  var selectedAnswers = <int, int>{}.obs;

  final FeedbackService _feedbackService = FeedbackService();

  @override
  void onInit() {
    super.onInit();
    fetchFeedbackItems();
  }

  Future<void> fetchFeedbackItems() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;
      feedbackList.clear();
      selectedAnswers.clear();

      final FeedbackResponse responseModel =
      await _feedbackService.fetchFeedbackData();

      if (responseModel.status.toLowerCase() == "success" &&
          responseModel.data.isNotEmpty) {
        feedbackList.assignAll(responseModel.data);
      } else if (responseModel.status.toLowerCase() == "success" &&
          responseModel.data.isEmpty) {
        feedbackList.clear();
      } else {
        errorMessage.value =
        "Failed to load feedback questions (API status: ${responseModel.status}).";
        feedbackList.clear();
      }
    } on FormatException catch (e) {
      debugPrint("Controller FormatException: ${e.message}");
      errorMessage.value =
      'Data from server is not in the expected format. Details: ${e.message}';
      feedbackList.clear();
    } catch (e) {
      debugPrint("Controller Exception: ${e.toString()}");
      errorMessage.value =
      'An error occurred while fetching feedback: ${e.toString()}';
      feedbackList.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void selectAnswer(int questionId, int optionId) {
    selectedAnswers[questionId] = optionId;
    debugPrint("Answer selected for QID $questionId: OptionID $optionId");
    debugPrint("Current selectedAnswers: $selectedAnswers");
  }

  Future<void> submitFeedback() async {
    if (selectedAnswers.isEmpty) {
      Get.snackbar(
        "Info",
        "Please answer at least one question before submitting.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    List<Map<String, dynamic>> submissions = [];
    bool hasValidSubmissions = true; // Flag to check data integrity

    selectedAnswers.forEach((questionId, optionId) {
      // **CRUCIAL DEBUG PRINT AND CHECK**
      debugPrint("Processing for submission - Question ID: $questionId, Option ID: $optionId");
      submissions.add({
        "question_id": questionId, // This is the key being sent. Verify with API.
        "option_id": optionId,
        // "comment": "some_comment_if_you_collect_it"
      });
    });

    if (!hasValidSubmissions) {
      Get.snackbar(
        "Data Error",
        "There was an issue with the selected answers. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }


    debugPrint("Submitting feedback payload: $submissions");
    isLoading.value = true;
    errorMessage.value = null;

    try {
      bool success = await _feedbackService.submitFeedbackData(submissions);

      if (success) {
        Get.snackbar(
          "Success",
          "Feedback submitted successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        selectedAnswers.clear();
        // Optionally: fetchFeedbackItems(); // To refresh or show a "thank you" state
      } else {
        // This else block might not be reached if _feedbackService.submitFeedbackData throws an Exception on failure
        errorMessage.value = "Failed to submit feedback. Please try again.";
        Get.snackbar(
          "Error",
          "Failed to submit feedback.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      // The exception 'e' from the service will be caught here
      debugPrint("Controller submitFeedback Exception: ${e.toString()}");
      errorMessage.value = e.toString(); // Show the specific error from the service
      Get.snackbar(
        "Error",
        e.toString(), // Display the more specific error message from the exception
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshFeedback() async {
    await fetchFeedbackItems();
  }
}