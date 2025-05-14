import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Proctocure extends StatelessWidget {
  const Proctocure({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: Text('Proctocure 2024', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SfPdfViewer.network(
        "http://app.worldcon2025kochi.com/storage/_1738905136.pdf",
        canShowScrollHead: true,
        canShowScrollStatus: true,
      ),
    );
  }
}
