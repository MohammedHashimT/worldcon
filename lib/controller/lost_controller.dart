import 'package:get/get.dart';
import 'package:worldcon/model/lost_Model.dart';
import 'package:worldcon/service/lost_Service.dart';


class LostController extends GetxController {
  var isLoading = true.obs;
  var lostList = <LostModel>[].obs;
  var errorMessage = RxnString();

  final LostService _lostService = LostService();

  @override
  void onInit() {
    super.onInit();
    fetchLostItems();
  }

  Future<void> fetchLostItems() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;

      final responseModel = await _lostService.fetchLostData();

      if (responseModel.lostitems.isNotEmpty) {
        lostList.assignAll(responseModel.lostitems);
      } else {
        lostList.clear();
      }
    } on FormatException catch (e) {
      errorMessage.value = 'Failed to process data from server (Invalid Format). Please try again later. Details: ${e.message}';
      lostList.clear();
    } catch (e) {
      errorMessage.value = 'An error occurred while fetching lost items: ${e.toString()}';
      lostList.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshLostItems() async {
    await fetchLostItems();
  }
}