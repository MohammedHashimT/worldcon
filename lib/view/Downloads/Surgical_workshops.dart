import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SurgicalWorkshops extends StatelessWidget {
  const SurgicalWorkshops({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: Text(
          'Surgical Workshops',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SfPdfViewer.network(
        "http://app.worldcon2025kochi.com/storage/_1738903864.pdf",
        canShowScrollHead: true,
        canShowScrollStatus: true,
      ),
    );
  }
}
