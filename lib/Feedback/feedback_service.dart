
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'feedback_model.dart';

class FeedbackGetService {
  static const String baseUrl =
      'https://app.worldcon2025kochi.com/api/feedback/all-questions';
  static const String _token =
      '801|7HxHnVQKoMEBW4orIUDVzQ8RVdJIBvGJv9xD7Z6n';

  Future<FeedbackResponse> fetchFeedbackData() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Accept-Encoding': 'gzip, deflate, br',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return FeedbackResponse.fromJson(jsonResponse);
      } else {
        throw Exception(
          'Failed to load feedback questions. Status code: ${response.statusCode}, Body: ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error during data fetching: $e');
    }
  }
}

class FeedbackPostService {
  static const String _baseUrlDomain =
      "app.worldcon2025kochi.com";
  static const String _submissionPath = "/api/feedback/submit-response";
  static const String _token =
      "808|J8236JIC86DcxMbf1hwxIZ5fcAgzmSEQu0stNgWV";

  static Future<bool> sendSingleFeedbackAnswer({
    required int questionId,
    String?
    optionId,
    String? submissionValue,
  }) async {
    final url = Uri.https(
      _baseUrlDomain,
      _submissionPath,
    );

    Map<String, dynamic> body = {
      'question_id': questionId.toString(),
    };

    if (optionId != null) {
      body['option_id'] = optionId;
    }
    if (submissionValue != null) {
      body['submission_value'] = submissionValue;
    }

    debugPrint("Submitting feedback answer: $body");

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept-Encoding': 'gzip, deflate, br',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
          'Content-Type':
              'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(
          "Answer for QID $questionId submitted successfully: ${response.body}",
        );
        return true;
      } else {
        debugPrint(
          "Failed to post answer for QID $questionId: ${response.statusCode} - ${response.body}",
        );
        return false;
      }
    } catch (e) {
      debugPrint("Error during POST request for QID $questionId: $e");
      return false;
    }
  }

}
