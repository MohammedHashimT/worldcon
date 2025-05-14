import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../controller/attraction_controller.dart';

class HillPalaceMuseum extends StatelessWidget {
  HillPalaceMuseum({super.key});

  final AttractionController attractionController = Get.put(
    AttractionController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: Center(
          child: const Text(
            'Hill Palace Museum',
            style: TextStyle(color: Colors.white),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Html(
            data:
                attractionController.attractionList.isNotEmpty
                    ? attractionController.attractionList[2].content
                    : 'No Content Available',
          ),
        );
      }),
    );
  }
}
