import 'package:get/get.dart';
import 'package:worldcon/model/attraction_model.dart';
import 'package:worldcon/service/attraction_service.dart';

class AttractionController extends GetxController {
  final isLoading = true.obs;
  final attractionList = <AttractionModel>[].obs;
  final errorMessage = Rxn<String>();
  final AttractionService attractionService = AttractionService();

  @override
  void onInit() {
    super.onInit();
    fetchInfo();
  }

  Future<void> fetchInfo() async {
    try {
      isLoading(true);
      errorMessage(null);

      final responseModel =
          await attractionService.fetchAttractionData();

      if (responseModel.status.toLowerCase() == 'success' ||
          responseModel.status.toLowerCase() == 'ok') {
        if (responseModel.attlists.isNotEmpty) {
          attractionList.assignAll(responseModel.attlists);
        } else {
          attractionList.clear();
        }
      } else {
        errorMessage(
          'Failed to fetch Attraction Lists : ${responseModel.status}',
        );
      }
    } catch (e) {
      errorMessage('An error occurred: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }
}
