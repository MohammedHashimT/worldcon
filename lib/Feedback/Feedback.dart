import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'feedback_controller.dart';

class FeedbackScreen extends StatelessWidget {
  FeedbackScreen({super.key});

  final FeedbackPageController controller = Get.put(FeedbackPageController());

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
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Obx(
            () => ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: primaryOrange),
              onPressed:
                  controller.isLoadingSubmit.value ||
                          controller.isLoadingFetch.value
                      ? null
                      : controller.submitFeedback,
              child:
                  controller.isLoadingSubmit.value
                      ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                      : const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
            ),
          ),
        ),
      ),
      body: Obx(() {
        // This outer Obx handles changes to controller.feedbackList
        if (controller.isLoadingFetch.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.value != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.errorMessage.value!,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => controller.refreshFeedbackPage(),
                    child: const Text("Retry"),
                  ),
                ],
              ),
            ),
          );
        }
        if (controller.feedbackList.isEmpty &&
            !controller.isLoadingFetch.value) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "No feedback questions available at the moment.",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => controller.refreshFeedbackPage(),
                    child: const Text("Refresh"),
                  ),
                ],
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.refreshFeedbackPage(),
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 80, top: 8),
            itemCount: controller.feedbackList.length,
            separatorBuilder:
                (context, index) => const Divider(
                  height: 1,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                  color: Color(0xFFE0E0E0),
                ),
            itemBuilder: (context, index) {
              final question = controller.feedbackList[index];

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
                        "${index + 1}. ${question.question}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // REMOVED Obx from here
                    Column(
                      children:
                          question.options.map((option) {
                            return RadioListTile<String>(
                              title: Text(option.optionValue),
                              value: option.id.toString(),
                              groupValue:
                                  question
                                      .selectedOptionId,
                              onChanged: (String? val) {
                                if (val != null) {
                                  controller.selectAnswer(question.id, val);
                                }
                              },
                              activeColor: primaryOrange,
                              dense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 0,
                              ),
                            );
                          }).toList(),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
