import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:worldcon/model/attraction_model.dart';

class AttractionService {
  static const String baseUrl =
      'https://app.worldcon2025kochi.com/api/places-to-visit';

  Future<AttractionResponse> fetchAttractionData() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return AttractionResponse.fromJson(jsonResponse);
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