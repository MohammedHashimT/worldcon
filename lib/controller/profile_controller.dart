// profile_controller.dart
import 'package:get/get.dart';
import 'package:worldcon/model/profile_model.dart'; // Adjust path (where AttendeeModel, ProfileModel, ProfileResponse are)
import 'package:worldcon/service/profile_service.dart'; // Adjust path

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var profileResponseData = Rxn<ProfileResponse>(); // Stores the whole API response
  var errorMessage = RxnString();

  AttendeeModel? get attendeeDetails => profileResponseData.value?.user?.attendee;

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
      profileResponseData.value = null; // Clear previous data

      // Assuming _profileService.fetchProfileData() returns Future<ProfileResponse>
      final fetchedData = await _profileService.fetchProfileData();
      profileResponseData.value = fetchedData;

      if (profileResponseData.value?.status == false) {
        // Handle API-level error if status is false
        // Example: errorMessage.value = profileResponseData.value?.message ?? "API returned an error.";
      } else if (attendeeDetails == null && profileResponseData.value?.status == true) {
        // Successfully fetched, but the attendee data is missing for some reason
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