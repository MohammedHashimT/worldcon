import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Highlights extends StatelessWidget {
  const Highlights({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: Text('Highlights', style: TextStyle(color: Colors.white)),
      ),
      body: SfPdfViewer.network(
        "http://app.worldcon2025kochi.com/storage/_1738904794.pdf",
        canShowScrollHead: true,
        canShowScrollStatus: true,
      ),
    );
  }
}
