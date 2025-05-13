import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:worldcon/controller/info_controller.dart';

class lunch extends StatelessWidget {
  lunch({super.key});

  final InfoController infoController = Get.put(InfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: const Text('Lunch', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (infoController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (infoController.errorMessage.value != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Error: ${infoController.errorMessage.value}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          );
        }
        return SingleChildScrollView(
          child: Html(
            data:
                infoController.infoList.isNotEmpty
                    ? infoController.infoList[7].content ??
                        'No content available'
                    : 'No content available',
          ),
        );
      }),
    );
  }
}
