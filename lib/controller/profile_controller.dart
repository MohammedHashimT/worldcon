// profile_controller.dart
import 'package:get/get.dart';
import 'package:worldcon/model/profile_model.dart';
import 'package:worldcon/service/profile_service.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var profileResponseData = Rxn<ProfileResponse>();
  var errorMessage = RxnString();

  AttendeeModel? get attendeeDetails =>
      profileResponseData.value?.user?.attendee;

  final ProfileService _profileService = ProfileService();

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;
      errorMessage.value = null;
      profileResponseData.value = null;
      final fetchedData = await _profileService.fetchProfileData();
      profileResponseData.value = fetchedData;

      if (profileResponseData.value?.status == false) {
      } else if (attendeeDetails == null &&
          profileResponseData.value?.status == true) {
        errorMessage.value = "Attendee profile data is not available.";
      }
    } catch (e) {
      errorMessage.value = "An error occurred: ${e.toString()}";
      profileResponseData.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshUserProfile() async {
    await fetchUserProfile();
  }
}
