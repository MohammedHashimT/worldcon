import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:worldcon/service/dwnld_certificate_service.dart';
import '../model/dwnld_certificate_model.dart';

class CertificateController extends GetxController {
  var isLoadingInfo = true.obs;
  var certificateInfo = Rxn<CertificateDownloadInfo>();
  var infoErrorMessage = RxnString();

  var isProcessingFile = false.obs;
  var processProgress = 0.0.obs;

  final DwnldCertificateService _certificateService = DwnldCertificateService();
  final Dio _dio = Dio();

  @override
  void onInit() {
    super.onInit();
    fetchCertificateInfo();
  }

  Future<void> fetchCertificateInfo() async {
    try {
      isLoadingInfo.value = true;
      infoErrorMessage.value = null;
      certificateInfo.value = null;

      final info = await _certificateService.fetchCertificateData();
      certificateInfo.value = info;

      if (certificateInfo.value?.status == false) {
        infoErrorMessage.value =
            "API indicated failure to get certificate info.";
      } else if (certificateInfo.value?.isEnableDownload == false) {
        infoErrorMessage.value =
            "Certificate sharing is currently not enabled.";
      } else if (certificateInfo.value?.downloadUrl == null ||
          certificateInfo.value!.downloadUrl!.isEmpty) {
        infoErrorMessage.value = "Certificate URL is missing.";
      }
    } catch (e) {
      infoErrorMessage.value =
          "Error fetching certificate info: ${e.toString()}";
    } finally {
      isLoadingInfo.value = false;
    }
  }

  Future<bool> _requestTemporaryStoragePermissions() async {
    if (Platform.isAndroid) {
      return true;
    }
    return true;
  }

  Future<void> shareCertificateFile() async {
    if (isProcessingFile.value) return;
    if (certificateInfo.value?.downloadUrl == null ||
        certificateInfo.value!.downloadUrl!.isEmpty) {
      Get.snackbar(
        "Error",
        "No certificate URL available.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }
    if (certificateInfo.value?.isEnableDownload == false) {
      Get.snackbar(
        "Info",
        "Certificate sharing is not enabled.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
      return;
    }

    isProcessingFile.value = true;
    processProgress.value = 0.0;
    String? tempFilePath;

    bool hasPermission = await _requestTemporaryStoragePermissions();
    if (!hasPermission) {
      isProcessingFile.value = false;
      Get.snackbar(
        "Permission Denied",
        "Storage access denied.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Directory tempDir;
    try {
      tempDir = await getTemporaryDirectory();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Could not get temporary directory.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      isProcessingFile.value = false;
      return;
    }

    String fileName = certificateInfo.value!.downloadUrl!.split('/').last;
    if (fileName.isEmpty || !fileName.toLowerCase().endsWith('.pdf')) {
      fileName =
          "certificate_to_share_${DateTime.now().millisecondsSinceEpoch}.pdf";
    }
    tempFilePath = "${tempDir.path}/$fileName";
    debugPrint(
      "Downloading PDF to temporary path: $tempFilePath for sharing from URL: ${certificateInfo.value!.downloadUrl!}",
    );

    try {
      await _dio.download(
        certificateInfo.value!.downloadUrl!,
        tempFilePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            processProgress.value = (received / total);
            debugPrint(
              "Download Progress: ${(processProgress.value * 100).toStringAsFixed(0)}%",
            );
          }
        },
      );

      final xFile = XFile(tempFilePath);
      await Share.shareXFiles(
        [xFile],
        text: 'Here is my certificate!',
        subject: 'Certificate Share',
      );

    } on DioException catch (e) {
      debugPrint("DioException downloading for share: $e");
      Get.snackbar(
        "Download Error",
        "Failed to download certificate for sharing.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      debugPrint("Error during share process: $e");
      Get.snackbar(
        "Share Error",
        "Could not share certificate: ${e.toString()}",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isProcessingFile.value = false;
      if (tempFilePath != null) {
        try {
          final file = File(tempFilePath);
          if (await file.exists()) {
            await file.delete();
            debugPrint("Temporary file deleted: $tempFilePath");
          }
        } catch (e) {
          debugPrint("Error deleting temporary file: $e");
        }
      }
    }
  }
}
