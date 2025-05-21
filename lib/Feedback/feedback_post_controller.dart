import 'package:get/get.dart';

import 'feedback_submission_model.dart';
import 'feedback_post_service.dart';

class FeedbackPostController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;

  // Example dummy token, ideally retrieve from secure storage
  final token = "803|5ZL8X01ZxbnfWrLC4iSXZW1LY2xXQIsmQgUiz291";

  Future<void> submitFeedback(List<FeedbackSubmissionModel> answers) async {
    isLoading.value = true;

    final payload = SubmissionResponse(status: "success", data: answers);
    final result = await FeedbackPostService.sendFeedback(payload, token);

    isSuccess.value = result;
    isLoading.value = false;

    if (result) {
      Get.snackbar("Success", "Feedback submitted!");
    } else {
      Get.snackbar("Error", "Failed to submit feedback.");
    }
  }
}
