import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:worldcon/model/profile_model.dart';

class ProfileService {
  static const String baseUrl =
      'https://app.worldcon2025kochi.com/api/my-account';

  Future<ProfileResponse> fetchProfileData() async {
    try {
      final response = await http.get(Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer 790|svF1vv0IciVkdp0L9BHAu7gQJojDDsmtExKJu9p3',
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return ProfileResponse.fromJson(jsonResponse);
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