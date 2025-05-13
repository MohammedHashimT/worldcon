import 'package:get/get.dart';
import '../model/Banner_model.dart';
import '../service/Banner_service.dart';

class BannerController extends GetxController {
  final isLoading = true.obs;
  final banners = <BannerModel>[].obs;
  final errorMessage = Rxn<String>();
  final BannerService _bannerService = BannerService();

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  Future<void> fetchBanners() async {
    try {
      isLoading(true);
      errorMessage(null);
      final response = await _bannerService.getBanners();
      if (response.isOk && response.body?.banners != null) {
        banners.assignAll(response.body!.banners!);
      } else {
        errorMessage('Failed to fetch banners: ${response.statusText}');
      }
    } catch (e) {
      errorMessage(e.toString());
      print('Error fetching banners: $e');
    } finally {
      isLoading(false);
    }
  }
}
