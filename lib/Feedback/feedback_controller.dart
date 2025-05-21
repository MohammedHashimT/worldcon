import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worldcon/Feedback/feedback_model.dart';
import 'package:worldcon/Feedback/feedback_service.dart';

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
        print(responseModel.toString());
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

  Future<void> refreshFeedback() async {
    await fetchFeedbackItems();
  }
}
