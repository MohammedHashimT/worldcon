import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worldcon/view/Home.dart';
import 'package:worldcon/view/NavigationBar.dart';
import 'feedback_model.dart';
import 'feedback_service.dart';

class FeedbackPageController extends GetxController {
  var isLoadingFetch = true.obs;
  var isLoadingSubmit = false.obs;
  var feedbackList = <FeedbackModel>[].obs;
  var errorMessage = RxnString();
  var isSubmitSuccess = false.obs;

  final FeedbackGetService _feedbackGetService = FeedbackGetService();

  @override
  void onInit() {
    super.onInit();
    fetchFeedbackItems();
  }

  Future<void> fetchFeedbackItems() async {
    try {
      isLoadingFetch.value = true;
      errorMessage.value = null;
      feedbackList.clear();

      final FeedbackResponse responseModel =
          await _feedbackGetService.fetchFeedbackData();

      if (responseModel.status.toLowerCase() == "success") {
        if (responseModel.data.isNotEmpty) {
          feedbackList.assignAll(responseModel.data);
        } else {
          debugPrint("No feedback questions available from API.");
        }
      } else {
        errorMessage.value =
            "Failed to load feedback questions (API status: ${responseModel.status}).";
      }
    } on FormatException catch (e) {
      debugPrint("Controller FormatException: ${e.message}");
      errorMessage.value =
          'Data from server is not in the expected format. Details: ${e.message}';
    } catch (e) {
      debugPrint("Controller Exception: ${e.toString()}");
      errorMessage.value =
          'An error occurred while fetching feedback: ${e.toString()}';
    } finally {
      isLoadingFetch.value = false;
    }
  }

  void selectAnswer(int questionId, String? value) {
    final questionIndex = feedbackList.indexWhere((q) => q.id == questionId);
    if (questionIndex != -1) {
      feedbackList[questionIndex].selectedOptionId = value;
      feedbackList.refresh();
    }
  }

  Future<void> submitFeedback() async {
    isLoadingSubmit.value = true;
    isSubmitSuccess.value = false;
    bool allSubmissionsSuccessful = true;
    int submittedCount = 0;

    List<Future<bool>> submissionFutures = [];

    for (var question in feedbackList) {
      if (question.selectedOptionId != null &&
          question.selectedOptionId!.isNotEmpty) {
        String? optionIdValue;
        String? submissionTextValue;

        if (question.type.toLowerCase() == "multiple_choice") {
          final parsedOptionId = int.tryParse(question.selectedOptionId!);
          if (parsedOptionId != null) {
            optionIdValue = parsedOptionId.toString();
          } else {
            debugPrint(
              "Warning: Could not parse optionId: ${question.selectedOptionId} for multiple_choice QID: ${question.id}",
            );
            allSubmissionsSuccessful = false;
            continue;
          }
        } else if (question.type.toLowerCase() == "descriptive") {
          submissionTextValue = question.selectedOptionId;
        } else {
          debugPrint(
            "Warning: Unknown question type '${question.type}' for QID: ${question.id}. Skipping submission.",
          );
          continue;
        }

        submissionFutures.add(
          FeedbackPostService.sendSingleFeedbackAnswer(
            questionId: question.id,
            optionId: optionIdValue,
            submissionValue: submissionTextValue,
          ).then((success) {
            if (success) submittedCount++;
            return success;
          }),
        );
      }
    }

    if (submissionFutures.isEmpty) {
      Get.snackbar(
        "No Selection",
        "Please answer at least one question.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.shade100,
      );
      isLoadingSubmit.value = false;
      return;
    }

    final results = await Future.wait(submissionFutures);
    allSubmissionsSuccessful = results.every((success) => success);

    isSubmitSuccess.value = allSubmissionsSuccessful;


    if (allSubmissionsSuccessful && submittedCount > 0) {
      Get.snackbar(
        "Success",
        "$submittedCount feedback answer(s) submitted successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
        colorText: Colors.green.shade900,
      );

      Future.delayed(const Duration(milliseconds: 200), () {
        isLoadingSubmit.value = false;

         Get.offAll(() => CustomNavigationBar());
      });
    } else if (submittedCount > 0 && !allSubmissionsSuccessful) {
      Get.snackbar(
        "Partial Success",
        "Some feedback answers failed to submit. $submittedCount submitted.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.shade100,
        colorText: Colors.orange.shade900,
      );
      isLoadingSubmit.value = false;
    } else {
      Get.snackbar(
        "Error",
        "Failed to submit feedback. Please check your selections or try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
      isLoadingSubmit.value = false;
    }
  }

  Future<void> refreshFeedbackPage() async {
    // ... (implementation remains the same)
    await fetchFeedbackItems();
  }
}
