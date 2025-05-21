import 'package:get/get.dart';
import '../model/Atendee_model.dart';
import '../service/Atendee_service.dart';

class AttendeeController extends GetxController {
  var attendees = <AttendeeModel>[].obs;
  var isLoading = false.obs;

  Future<void> fetchAttendees() async {
    try {
      isLoading.value = true;
      final service = AttendeeService();
      final fetched = await service.fetchAttendeeData();
      attendees.assignAll(fetched);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch attendees');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addAttendee(AttendeeModel attendee) async {
    try {
      final success = await AttendeeService.addAttendee(attendee);
      if (success) {
        attendees.add(attendee);
      } else {
        Get.snackbar('Error', 'Failed to add attendee');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add attendee');
    }
  }


}
