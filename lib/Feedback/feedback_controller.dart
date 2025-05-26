import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worldcon/view/NavigationBar.dart';
import '../Shared_Preferences/shared_preferences.dart';
import 'feedback_model.dart';
import 'feedback_service.dart';

class FeedbackPageController extends GetxController {
  final TokenService _tokenService = Get.find<TokenService>();
  final FeedbackGetService _feedbackGetService = FeedbackGetService();

  var isLoadingFetch = true.obs;
  var isLoadingSubmit = false.obs;
  var feedbackList = <FeedbackModel>[].obs;
  var errorMessage = RxnString();
  var isSubmitSuccess = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFeedbackItems();
  }

  Future<void> fetchFeedbackItems() async {
    isLoadingFetch.value = true;
    errorMessage.value = null;

    final String? currentToken = await _tokenService.getToken();

    if (currentToken == null || currentToken.isEmpty) {
      errorMessage.value =
          "Authentication token not found or is empty. Please log in again.";
      isLoadingFetch.value = false;
      feedbackList.clear();
      return;
    }

    try {
      feedbackList.clear();
      final FeedbackResponse responseModel = await _feedbackGetService
          .fetchFeedbackData(authToken: currentToken);

      if (responseModel.status.toLowerCase() == "success") {
        if (responseModel.data.isNotEmpty) {
          feedbackList.assignAll(responseModel.data);
        } else {
        }
      } else {
        errorMessage.value =
            "Failed to load feedback questions (API status: ${responseModel.status}).";
      }
    } on FormatException catch (e) {
      errorMessage.value =
          'Data from server is not in the expected format. Details: ${e.message}';
      feedbackList.clear();
    } catch (e) {
      errorMessage.value =
          'An error occurred while fetching feedback: ${e.toString()}';
      feedbackList.clear();
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
    int submittedCount = 0;
    String? lastReceivedNewToken;

    final String? currentToken = await _tokenService.getToken();
    if (currentToken == null || currentToken.isEmpty) {
      Get.snackbar(
        "Authentication Error",
        "Your session has expired or token is missing. Please log in again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        duration: const Duration(seconds: 4),
      );
      isLoadingSubmit.value = false;
      return;
    }

    List<Future<FeedbackPostServiceResponse>> submissionFutures = [];

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
            continue;
          }
        } else if (question.type.toLowerCase() == "descriptive") {
          submissionTextValue = question.selectedOptionId;
        } else {
          continue;
        }

        submissionFutures.add(
          FeedbackPostService.sendSingleFeedbackAnswer(
            questionId: question.id,
            optionId: optionIdValue,
            submissionValue: submissionTextValue,
            currentAuthToken: currentToken,
          ).then((response) {
            if (response.success) {
              submittedCount++;
              if (response.newToken != null && response.newToken!.isNotEmpty) {
                lastReceivedNewToken = response.newToken;
              }
            }
            return response;
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
    bool allIndividualSubmissionsSuccessful = results.every(
      (response) => response.success,
    );

    if (allIndividualSubmissionsSuccessful && submittedCount > 0) {
      isSubmitSuccess.value = true;
      Get.snackbar(
        "Success",
        "$submittedCount feedback answer(s) submitted successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade100,
        colorText: Colors.green.shade900,
      );

      if (lastReceivedNewToken != null) {
        await _tokenService.saveToken(lastReceivedNewToken!);
      }

      Future.delayed(const Duration(milliseconds: 500), () {
        isLoadingSubmit.value = false;
        Get.offAll(() => CustomNavigationBar()); // Navigates to homepage
      });
    } else if (submittedCount > 0 && !allIndividualSubmissionsSuccessful) {
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
        "Submission Error",
        "Failed to submit feedback. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
      isLoadingSubmit.value = false;
    }
  }

  Future<void> refreshFeedbackPage() async {
    await fetchFeedbackItems();
  }
}
