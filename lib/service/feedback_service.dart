import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:worldcon/model/feedback_model.dart';

class FeedbackService {
  static const String baseUrl =
      'https://app.worldcon2025kochi.com/api/feedback/all-questions';

  Future<FeedbackResponse> fetchFeedbackData() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'Bearer 801|7HxHnVQKoMEBW4orIUDVzQ8RVdJIBvGJv9xD7Z6n',
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return FeedbackResponse.fromJson(jsonResponse);
      } else {
        throw Exception(
          'Failed to load data . Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error during data fetching: $e');
    }
  }

  submitFeedbackData(List<Map<String, dynamic>> submissions) {}
}
