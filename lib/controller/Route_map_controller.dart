import 'package:get/get.dart';
import 'package:worldcon/model/Route_map_model.dart';
import 'package:worldcon/service/Route_map_service.dart';

class RouteMapController extends GetxController {
  final isLoading = true.obs;
  final venue = <RouteMapModel>[].obs;
  final errorMessage = Rxn<String>();
  final RouteMapService _routeMapService = RouteMapService();

  @override
  void onInit() {
    super.onInit();
    fetchRoute();
  }

  Future<void> fetchRoute() async {
    try {
      isLoading(true);
      errorMessage(null);

      final responseModel = await _routeMapService.fetchRouteData();

      if (responseModel.status.toLowerCase() == 'success' ||
          responseModel.status.toLowerCase() == 'ok') {
        if (responseModel.venue.isNotEmpty) {
          venue.assignAll(responseModel.venue);
        } else {
          venue.clear();
        }
      } else {
        errorMessage(
          'Failed to fetch Venue Route Map. Status: ${responseModel.status}',
        );
      }
    } catch (e) {
      errorMessage('An error occurred: ${e.toString()}');
      print('Error in RouteMapController fetchRoute: $e');
    } finally {
      isLoading(false);
    }
  }
}
