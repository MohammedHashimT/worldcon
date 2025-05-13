import 'package:get/get.dart';
import 'package:worldcon/model/info_model.dart';
import 'package:worldcon/service/info_service.dart';

class InfoController extends GetxController {
  final isLoading = true.obs;
  final infoList = <InfoModel>[].obs;
  final errorMessage = Rxn<String>();
  final InfoService infoService = InfoService();

  @override
  void onInit() {
    super.onInit();
    fetchInfo();
  }

  Future<void> fetchInfo() async {
    try {
      isLoading(true);
      errorMessage(null);

      final responseModel = await infoService.fetchInfoData();

      if (responseModel.status.toLowerCase() == 'success' ||
          responseModel.status.toLowerCase() == 'ok') {
        if (responseModel.infolists.isNotEmpty) {
          infoList.assignAll(responseModel.infolists);
        } else {
          infoList.clear();
        }
      } else {
        errorMessage(
          'Failed to fetch Info Lists Status: ${responseModel.status}',
        );
      }
    } catch (e) {
      errorMessage('An error occurred: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }
}
