import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:worldcon/Feedback/feedback_submission_model.dart';

class FeedbackPostService {
  static const String baseUrl = "https://app.worldcon2025kochi.com";

  static Future<bool> sendFeedback(SubmissionResponse submission, String token) async {
    final url = Uri.parse('$baseUrl/api/feedback/all-questions');

    try {
      final response = await http.post(
        url,
        headers: {
          'token': token,
          'Accept': 'application/json',
          'Authorization':'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(submission.toJson()),
      );

      if (response.statusCode == 200) {
       // print("Feedback submitted successfully.");
        return true;
      } else {
      // print("Failed to post: ${response.statusCode} - ${response.body}");
        return false;
      }
    } catch (e) {
    //  print("Error during POST: $e");
      return false;
    }
  }
}
