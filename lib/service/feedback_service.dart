// feedback_service.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:worldcon/model/feedback_model.dart';

class FeedbackService {
  static const String _baseUrl =
      'https://app.worldcon2025kochi.com/api/feedback';
  static const String _fetchAllQuestionsUrl = '$_baseUrl/all-questions';
  static const String _submitResponseUrl = '$_baseUrl/submit-response';

  Future<String?> _getAuthToken() async {
    // IMPORTANT: Replace with your actual token retrieval mechanism.
    return '801|7HxHnVQKoMEBW4orIUDVzQ8RVdJIBvGJv9xD7Z6n'; // Placeholder
  }

  Future<FeedbackResponse> fetchFeedbackData() async {
    final token = await _getAuthToken();
    if (token == null) {
      throw Exception('Authentication token not found.');
    }
    try {
      debugPrint("Fetching feedback questions from: $_fetchAllQuestionsUrl");
      final response = await http
          .get(
        Uri.parse(_fetchAllQuestionsUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      )
          .timeout(const Duration(seconds: 20));

      debugPrint("Fetch Questions - Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return FeedbackResponse.fromJson(jsonResponse);
      } else {
        String errorMsg =
            'Failed to load feedback questions. Status code: ${response.statusCode}.';
        try {
          final errorBody = json.decode(response.body);
          if (errorBody['message'] != null) {
            errorMsg += ' Message: ${errorBody['message']}';
          }
        } catch (_) {}
        debugPrint(
          "Fetch Questions Error: $errorMsg --- Body: ${response.body}",
        );
        throw Exception(errorMsg);
      }
    } catch (e) {
      debugPrint("Error during fetchFeedbackData: $e");
      throw Exception('Error during data fetching: ${e.toString()}');
    }
  }

  Future<bool> submitFeedbackData(
      List<Map<String, dynamic>> submissions,
      ) async {
    final token = await _getAuthToken();
    if (token == null) {
      throw Exception('Authentication token not found for submission.');
    }


    final Map<String, dynamic> requestBodyPayload = {
      "responses": submissions
    };


    try {
      debugPrint("Submitting feedback to: $_submitResponseUrl");
      debugPrint(
        "Submission Headers: ${{'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'}}",
      );
      debugPrint("Submission Body: ${json.encode(requestBodyPayload)}");

      final response = await http
          .post(
        Uri.parse(_submitResponseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(requestBodyPayload),
      )
          .timeout(const Duration(seconds: 20));

      debugPrint("Submit Feedback - Status: ${response.statusCode}");
      debugPrint("Submit Feedback - Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        String errorMessage =
            'Failed to submit feedback. Status code: ${response.statusCode}.';
        try {
          final errorJson = json.decode(response.body);
          if (errorJson['message'] != null) {
            errorMessage = errorJson['message'];
          } else if (errorJson['errors'] != null &&
              errorJson['errors'] is Map && // Check if errors is a map
              errorJson['errors']['question_id'] != null) {
            errorMessage = (errorJson['errors']['question_id'] as List).join(", ");
          } else if (errorJson['errors'] != null && errorJson['errors'] is Map) {
            // Generic way to show validation errors if 'question_id' specific one isn't there
            List<String> errorMessages = [];
            (errorJson['errors'] as Map).forEach((key, value) {
              if (value is List) {
                errorMessages.add("$key: ${value.join(', ')}");
              } else {
                errorMessages.add("$key: $value");
              }
            });
            if (errorMessages.isNotEmpty) {
              errorMessage = errorMessages.join('; ');
            }
          }
        } catch (_) {
        }
        if (response.body.isNotEmpty && errorMessage.startsWith('Failed to submit feedback')) {
          errorMessage += " Server response: ${response.body.substring(0, (response.body.length > 200 ? 200 : response.body.length))}";
        }
        debugPrint("Submit Feedback Error: $errorMessage");
        throw Exception(errorMessage);
      }
    } catch (e) {
      debugPrint("Error during submitFeedbackData (outer catch): $e");
      throw Exception('Error during feedback submission: ${e.toString()}');
    }
  }
}