import 'package:get/get.dart';
import 'package:worldcon/model/download_model.dart';
import 'package:worldcon/service/download_service.dart';

class DownloadController extends GetxController {
  final isLoading = true.obs;
  final pdf = <DownloadModel>[].obs;
  final errorMessage = Rxn<String>();
  final DownloadService _downloadService = DownloadService();

  @override
  void onInit() {
    super.onInit();
    fetchDwnld();
  }

  Future<void> fetchDwnld() async {
    try {
      isLoading(true);
      errorMessage(null);

      final responseModel = await _downloadService.fetchDownloadData();

      if (responseModel.status.toLowerCase() == 'success' ||
          responseModel.status.toLowerCase() == 'ok') {
        if (responseModel.pdfList.isNotEmpty) {
          pdf.assignAll(responseModel.pdfList);
        } else {
          pdf.clear();
        }
      } else {
        errorMessage(
          'Failed to fetch PDF Lists Status: ${responseModel.status}',
        );
      }
    } catch (e) {
      errorMessage('An error occurred: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }
}
