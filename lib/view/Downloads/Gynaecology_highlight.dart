import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:worldcon/controller/download_controller.dart';

class GynaecologyHighlight extends StatelessWidget {
  const GynaecologyHighlight({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: Text(
          'Gynaecology - Highlight',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Colors.grey,
        child: SfPdfViewer.network(
          "http://app.worldcon2025kochi.com/storage/_1738903504.pdf",
          canShowScrollHead: true,
          canShowScrollStatus: true,
        ),
      ),
    );
  }
}
