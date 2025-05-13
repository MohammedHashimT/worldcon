import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class HandsOnTraining extends StatelessWidget {
  const HandsOnTraining({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: Text(
          'Hands - on - Training Sessions',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SfPdfViewer.network(
        "http://app.worldcon2025kochi.com/storage/_1738903991.pdf",
        canShowScrollHead: true,
        canShowScrollStatus: true,
      ),
    );
  }
}
