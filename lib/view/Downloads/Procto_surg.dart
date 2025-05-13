import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ProctoSurg extends StatelessWidget {
  const ProctoSurg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: Text(
          'Procto - Surg - 2024',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SfPdfViewer.network(
        "http://app.worldcon2025kochi.com/storage/_1738904318.pdf",
        canShowScrollHead: true,
        canShowScrollStatus: true,
      ),
    );
  }
}
