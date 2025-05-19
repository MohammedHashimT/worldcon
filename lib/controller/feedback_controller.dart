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
    bool hasValidSubmissions = true;

    selectedAnswers.forEach((questionId, optionId) {
      debugPrint(
        "Processing for submission - Question ID: $questionId, Option ID: $optionId",
      );
      submissions.add({"question_id": questionId, "option_id": optionId});
    });

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
      } else {
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
      debugPrint("Controller submitFeedback Exception: ${e.toString()}");
      errorMessage.value = e.toString();
      Get.snackbar(
        "Error",
        e.toString(),
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
