import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worldcon/Feedback/feedback_controller.dart';
import 'package:worldcon/Feedback/feedback_post_controller.dart';
import 'package:worldcon/Feedback/feedback_model.dart';
import 'package:worldcon/view/NavigationBar.dart';
import 'feedback_submission_model.dart';


class FeedbackScreen extends StatelessWidget {
  FeedbackScreen({super.key});

  final FeedbackController feedbackController = Get.put(FeedbackController());
  final FeedbackPostController feedbackPostController=Get.put(FeedbackPostController());

  final selectedAnswers = [
    FeedbackSubmissionModel(questionid: 5, optionid: 15),
    FeedbackSubmissionModel(questionid: 6, optionid: 17),
    FeedbackSubmissionModel(questionid: 7, optionid: 21),
    FeedbackSubmissionModel(questionid: 12, optionid: 40),
    FeedbackSubmissionModel(questionid: 13, optionid: 47),
    FeedbackSubmissionModel(questionid: 14, optionid: 50),
    FeedbackSubmissionModel(questionid: 15, optionid: 52),
  ];


  @override
  Widget build(BuildContext context) {
    final Color primaryOrange = Colors.orange.shade700;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryOrange,
        title: const Text(
          'Feedback',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Obx(() {
        if (feedbackController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (feedbackController.errorMessage.value != null) {
          return Center(child: Text(feedbackController.errorMessage.value!));
        }
        if (feedbackController.feedbackList.isEmpty && !feedbackController.isLoading.value) {
          return const Center(child: Text("No feedback questions available."));
        }

        return ListView.separated(
          padding: const EdgeInsets.only(
            bottom: 80,
          ),
          itemCount: feedbackController.feedbackList.length,
          separatorBuilder:
              (context, index) => const Divider(
            height: 1,
            thickness: 1,
            indent: 16,
            endIndent: 16,
            color: Color(0xFFE0E0E0),
          ),
          itemBuilder: (context, index) {
            final question = feedbackController.feedbackList[index];

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      question.question,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ...question.options.map((option) {
                    return Obx(
                          () => RadioListTile<int>(
                        title: Text(option.optionValue),
                        value: option.id,
                        groupValue:
                        feedbackController.selectedAnswers[question.id],
                        onChanged: (val) {
                          if (val != null) {
                            feedbackController.selectedAnswers[question.id] = val;
                          }
                        },
                        activeColor: primaryOrange,
                        dense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        );
      }),



      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Obx(() => ElevatedButton(
            onPressed: feedbackPostController.isLoading.value
                ? null
                : () async {
              List<FeedbackSubmissionModel> submissionsToPost = [];
              feedbackController.selectedAnswers.forEach((questionId, optionId) {
                submissionsToPost.add(FeedbackSubmissionModel(
                  questionid: questionId,
                  optionid: optionId,
                ));
              });

              if (submissionsToPost.isEmpty && feedbackController.feedbackList.isNotEmpty) {
                Get.snackbar(
                    "No Answers",
                    "Please select an answer for at least one question.",
                    snackPosition: SnackPosition.BOTTOM
                );
                return;
              }

              await feedbackPostController.submitFeedback(submissionsToPost);

              if (feedbackPostController.isSuccess.value) {
                Get.offAll(() => CustomNavigationBar());
                Future.delayed(const Duration(milliseconds: 200), () {
                  Get.snackbar(
                      "Success",
                      "Feedback submitted successfully!",
                      snackPosition: SnackPosition.BOTTOM
                  );
                });
              } else {
                Get.snackbar(
                    "Error",
                    "Failed to submit feedback. Please try again.",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
              feedbackPostController.isLoading.value ? Colors.grey : primaryOrange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: feedbackPostController.isLoading.value
                ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 3,
              ),
            )
                : const Text(
              'Submit',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )),
        ),
      ),
    );
  }
}