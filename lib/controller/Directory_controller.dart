import 'package:get/get.dart';
import '../model/Directory_model.dart';
import '../service/Directory_service.dart';

class DirectoryController extends GetxController {
  final isLoading = true.obs;
  final nationalAdvisoryCommitteeList = <DirectoryModel>[].obs;
  final patronsList = <DirectoryModel>[].obs;
  final errorMessage = Rxn<String>();

  final DirectoryService _directoryService = DirectoryService();

  Future<void> fetchDirectoryData() async {
    try {
      isLoading(true);
      errorMessage(null);
      final directoryResponse = await _directoryService.fetchDirectoryData();

      final advisoryCommitteeData = directoryResponse.directoryLists.firstWhere(
        (committee) => committee.categoryName == 'NATIONAL ADVISORY COMMITTEE',
        orElse: () => AdvisoryCommittee(categoryName: '', directoryList: []),
      );
      nationalAdvisoryCommitteeList.assignAll(
        advisoryCommitteeData.directoryList,
      );

      final patronsData = directoryResponse.directoryLists.firstWhere(
        (patron) => patron.categoryName == 'PATRONS',
        orElse: () => AdvisoryCommittee(categoryName: '', directoryList: []),
      );
      patronsList.assignAll(patronsData.directoryList);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    fetchDirectoryData();
    super.onInit();
  }
}
