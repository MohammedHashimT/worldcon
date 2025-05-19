import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worldcon/controller/feedback_controller.dart';
import 'package:worldcon/controller/feedback_post_controller.dart';
import 'package:worldcon/model/feedback_model.dart';

class FeedbackScreen extends StatelessWidget {
  FeedbackScreen({super.key});

  final FeedbackController feedbackController = Get.put(FeedbackController());
  final FeedbackPostController feedbackPostController = Get.put(
    FeedbackPostController(),
  );

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
        if (feedbackController.isLoading.value &&
            feedbackController.feedbackList.isEmpty) {
          return Center(child: CircularProgressIndicator(color: primaryOrange));
        }

        if (feedbackController.errorMessage.value != null &&
            feedbackController.feedbackList.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red.shade700,
                    size: 50,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Error: ${feedbackController.errorMessage.value}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.red.shade700),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                    onPressed: () => feedbackController.fetchFeedbackItems(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryOrange,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (feedbackController.feedbackList.isEmpty) {
          return const Center(
            child: Text(
              'No feedback questions available at the moment.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        List<Widget> feedbackWidgets = [];
        for (int i = 0; i < feedbackController.feedbackList.length; i++) {
          final FeedbackModel questionItem = feedbackController.feedbackList[i];

          feedbackWidgets.add(
            Padding(
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
                      questionItem.question,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (questionItem.options.isNotEmpty)
                    Obx(
                      () => Column(
                        children:
                            questionItem.options.map((OptionModel option) {
                              return RadioListTile<int>(
                                title: Text(
                                  option.optionValue,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                value: option.id,
                                groupValue:
                                    feedbackController
                                        .selectedAnswers[questionItem.id],
                                onChanged: (int? newSelectedOptionId) {
                                  if (newSelectedOptionId != null) {
                                    feedbackController.selectAnswer(
                                      questionItem.id,
                                      newSelectedOptionId,
                                    );
                                  }
                                },
                                activeColor: primaryOrange,
                                dense: true,
                                contentPadding: const EdgeInsets.only(
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                ),
                                visualDensity: VisualDensity.compact,
                              );
                            }).toList(),
                      ),
                    )
                  else
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0, top: 4.0),
                      child: Text(
                        "No options available for this question.",
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  if (questionItem.hasComments == 1) ...[
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, right: 0.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Optional comments...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: primaryOrange,
                              width: 1.5,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                        onChanged: (text) {
                          print("Comment for QID ${questionItem.id}: $text");
                        },
                        maxLines: 2,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );

          if (i < feedbackController.feedbackList.length - 1) {
            feedbackWidgets.add(
              const Divider(
                height: 1,
                thickness: 1,
                indent: 16,
                endIndent: 16,
                color: Color(0xFFE0E0E0),
              ),
            );
          }
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: feedbackWidgets,
          ),
        );
      }),
      bottomNavigationBar: Obx(
        () =>
            feedbackController.feedbackList.isNotEmpty &&
                    feedbackController.errorMessage.value == null &&
                    !feedbackController.isLoading.value &&
                    !feedbackPostController.isSubmitting.value
                ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryOrange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      minimumSize: const Size(double.infinity, 48),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      List<Map<String, dynamic>> submissionsData = [];
                      feedbackController.selectedAnswers.forEach((
                        questionId,
                        optionId,
                      ) {
                        submissionsData.add({
                          "question_id": questionId,
                          "option_id": optionId,
                        });
                      });

                      if (submissionsData.isEmpty &&
                          feedbackController.feedbackList.any(
                            (q) => q.options.isNotEmpty,
                          )) {
                        Get.snackbar(
                          "Info",
                          "Please answer at least one question.",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        return;
                      }
                      feedbackPostController
                          .submitFeedback(submissionsData)
                          .then((_) {
                            if (feedbackPostController
                                .submissionSuccess
                                .value) {
                              feedbackController.selectedAnswers.clear();
                            }
                          });
                    },
                    child: const Text('Submit Feedback'),
                  ),
                )
                : (feedbackPostController.isSubmitting.value
                    ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade400,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          minimumSize: const Size(double.infinity, 48),
                        ),
                        onPressed: null,
                        child: const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                    : const SizedBox.shrink()),
      ),
    );
  }
}
