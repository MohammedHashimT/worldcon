import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/Directory_model.dart';

class DirectoryService {
  static const String baseUrl =
      'https://app.worldcon2025kochi.com/api/directory-list';

  Future<DirectoryResponse> fetchDirectoryData() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return DirectoryResponse.fromJson(jsonResponse);
      } else {
        throw Exception(
          'Failed to load data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error during data fetching: $e');
    }
  }
}
