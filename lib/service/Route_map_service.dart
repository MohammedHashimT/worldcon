import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:worldcon/model/Route_map_model.dart';

class RouteMapService {
  static const String baseUrl =
      'https://app.worldcon2025kochi.com/api/route-map-to-venue';

  Future<ResponseModel> fetchRouteData() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return ResponseModel.fromJson(jsonResponse);
      } else {
        throw Exception(
          'Failed to load data . Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error during data fetching: $e');
    }
  }
}
