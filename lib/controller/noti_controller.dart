import 'package:get/get.dart';
import 'package:worldcon/model/noti_model.dart';
import 'package:worldcon/service/noti_service.dart';

class NotiController extends GetxController {
  var notiList = <NotiModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotification();
  }

  Future<void> fetchNotification() async {
    try {
      isLoading.value = true;
      final service = NotiService();
      final fetched = await service.fetchNotiData();
      notiList.assignAll(fetched);
    } catch (e) {
      print("Error fetching notifications: $e");
      Get.snackbar(
        'Error',
        'Failed to fetch Notifications: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addNotification(NotiModel notify) async {
    try {
      final success = await NotiService.addNotification(notify);
      if (success) {
        notiList.add(notify);
        Get.snackbar(
          'Success',
          'Notification added successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to add notification',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print("Error adding notification: $e");
      Get.snackbar(
        'Error',
        'Failed to add notification: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
