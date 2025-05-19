import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../controller/dwnld_certificate_controller.dart';

class CertificateDownloadScreen extends StatelessWidget {
  CertificateDownloadScreen({super.key});

  final CertificateController controller = Get.put(CertificateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Certificate'),
        backgroundColor: Colors.orange.shade700,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(() {
            if (controller.isLoadingInfo.value) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.orange.shade700),
                  const SizedBox(height: 10),
                  const Text("Fetching certificate details...", style: TextStyle(fontSize: 16)),
                ],
              );
            }

            if (controller.infoErrorMessage.value != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red.shade700, size: 40),
                  const SizedBox(height: 10),
                  Text(
                    controller.infoErrorMessage.value!,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red.shade700, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(onPressed: () => controller.fetchCertificateInfo(), child: const Text("Retry"))
                ],
              );
            }

            if (controller.certificateInfo.value == null || controller.certificateInfo.value!.downloadUrl == null) {
              return const Text("Certificate information not found or URL is missing.", textAlign: TextAlign.center);
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (controller.isProcessingFile.value) ...[
                  CircularProgressIndicator(
                    value: controller.processProgress.value > 0.0 ? controller.processProgress.value : null,
                    color: Colors.orange.shade700,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    controller.processProgress.value > 0.0
                        ? "Preparing... ${(controller.processProgress.value * 100).toStringAsFixed(0)}%" // Text changed
                        : "Starting process...",
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),
                ] else ...[
                  // Assuming isEnableDownload now implies isEnableShare
                  if(controller.certificateInfo.value!.isEnableDownload == true)
                    ElevatedButton.icon(
                      // Icon changed for sharing
                      icon: const FaIcon(FontAwesomeIcons.shareNodes, size: 20), // Or Icons.share
                      label: const Text('Share Certificate PDF'), // Text changed
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: controller.shareCertificateFile, // Action changed
                    )
                  else
                    Text("Sharing is currently disabled for this certificate.", style: TextStyle(color: Colors.orange.shade700)),
                ],
                // The section to show downloaded file path and open button can be removed
                // if you no longer persist the file or offer an "Open" option.
                // const SizedBox(height: 30),
                // if (controller.downloadedFilePath.value != null && !controller.isProcessingFile.value) ...[
                //   // ...
                // ]
              ],
            );
          }),
        ),
      ),
    );
  }
}