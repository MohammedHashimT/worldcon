import 'package:get/get.dart';
import 'package:worldcon/model/exhibitor_model.dart';
import 'package:worldcon/service/exhibitor_service.dart';

class ExhibitorController extends GetxController {
  final isLoading = true.obs;
  final exhibitorList = <ExhibitorModel>[].obs;
  final errorMessage = Rxn<String>();
  final ExhibitorService exhibitorService = ExhibitorService();

  @override
  void onInit() {
    super.onInit();
    fetchdata();
  }

  Future<void> fetchdata() async {
    try {
      isLoading(true);
      errorMessage(null);

      final responseModel = await exhibitorService.fetchExhibitorData();

      if (responseModel.status.toLowerCase() == 'success' ||
          responseModel.status.toLowerCase() == 'ok') {
        if (responseModel.exhibitors.isNotEmpty) {
          exhibitorList.assignAll(responseModel.exhibitors);
        } else {
          exhibitorList.clear();
        }
      } else {
        errorMessage(
          'Failed to fetch Exhibitors Lists, Status: ${responseModel.status}',
        );
      }
    } catch (e) {
      errorMessage('An error occurred: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }
}
