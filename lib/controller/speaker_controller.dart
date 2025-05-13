import 'package:get/get.dart';
import 'package:worldcon/model/speaker_model.dart';
import 'package:worldcon/service/speaker_service.dart';

class SpeakerController extends GetxController {
  final isLoading = true.obs;
  final speakerList = <speakerModel>[].obs;
  final errorMessage = Rxn<String>();
  final SpeakerService speakerService = SpeakerService();

  @override
  void onInit() {
    super.onInit();
    fetchdata();
  }

  Future<void> fetchdata() async {
    try {
      isLoading(true);
      errorMessage(null);

      final responseModel = await speakerService.fetchSpeakerData();

      if (responseModel.status.toLowerCase() == 'success' ||
          responseModel.status.toLowerCase() == 'ok') {
        if (responseModel.personalities.isNotEmpty) {
          speakerList.assignAll(responseModel.personalities);
        } else {
          speakerList.clear();
        }
      } else {
        errorMessage(
          'Failed to fetch Speakers Lists, Status: ${responseModel.status}',
        );
      }
    } catch (e) {
      errorMessage('An error occurred: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }
}
