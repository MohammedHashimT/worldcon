import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'feedback_model.dart';

class FeedbackGetService {
  static const String baseUrl =
      'https://app.worldcon2025kochi.com/api/feedback/all-questions';

  Future<FeedbackResponse> fetchFeedbackData({
    required String authToken,
  }) async {
    try {
      // debugPrint("Fetching feedback questions with token: $authToken");
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Accept-Encoding': 'gzip, deflate, br',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
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

class FeedbackPostServiceResponse {
  final bool success;
  final String? newToken;

  FeedbackPostServiceResponse({required this.success, this.newToken});
}

class FeedbackPostService {
  static const String _baseUrlDomain = "app.worldcon2025kochi.com";
  static const String _submissionPath = "/api/feedback/submit-response";

  static Future<FeedbackPostServiceResponse> sendSingleFeedbackAnswer({
    required int questionId,
    String? optionId,
    String? submissionValue,
    required String currentAuthToken,
  }) async {
    final url = Uri.https(_baseUrlDomain, _submissionPath);
    Map<String, dynamic> body = {'question_id': questionId.toString()};
    if (optionId != null) body['option_id'] = optionId;
    if (submissionValue != null) body['submission_value'] = submissionValue;

    // debugPrint(
    //   "Submitting feedback answer with token: $currentAuthToken, body: $body",
    // );

    try {
      final response = await http.post(
        url,
        headers: {
          'Accept-Encoding': 'gzip, deflate, br',
          'Accept': 'application/json',
          'Authorization': 'Bearer $currentAuthToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // debugPrint(
        //   "Answer for QID $questionId submitted successfully: ${response.body}",
        // );
        String? newTokenFromResponse;
        final responseBody = jsonDecode(response.body);
        if (responseBody is Map &&
            responseBody.containsKey('data') &&
            responseBody['data'] is Map &&
            responseBody['data'].containsKey('new_token')) {
          newTokenFromResponse = responseBody['data']['new_token'];
        }
        return FeedbackPostServiceResponse(
          success: true,
          newToken: newTokenFromResponse,
        );
      } else {
        // debugPrint(
        //   "Failed to post answer for QID $questionId: ${response.statusCode} - ${response.body}",
        // );
        return FeedbackPostServiceResponse(success: false);
      }
    } catch (e) {
      // debugPrint("Error during POST request for QID $questionId: $e");
      return FeedbackPostServiceResponse(success: false);
    }
  }
}
