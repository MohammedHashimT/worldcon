import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class FeedbackPostService extends GetConnect {
  final String _apiBaseUrl = 'https://app.worldcon2025kochi.com/api';
  final String _submitFeedbackPath = '/feedback/submit-response';

  Future<String?> _getAuthToken() async {
    return 'user_token_here';
  }

  @override
  void onInit() {
    httpClient.baseUrl = _apiBaseUrl;
    httpClient.timeout = const Duration(seconds: 20);

    httpClient.addRequestModifier<dynamic>((request) async {
      final token = await _getAuthToken();
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      request.headers['Accept'] = 'application/json';

      debugPrint("Request URL: ${request.url}");
      debugPrint("Request Method: ${request.method}");
      debugPrint("Request Headers: ${request.headers}");
      if (request.method == 'POST' || request.method == 'PUT') {}
      return request;
    });

    httpClient.addResponseModifier((request, response) {
      debugPrint(
        "API Response: ${request.method} ${request.url} - ${response.statusCode}\nBody: ${response.bodyString}",
      );
      return response;
    });
    super.onInit();
  }

  Future<Response> submitMultipleFeedbackResponses(
    List<Map<String, dynamic>> submissions,
  ) {
    final Map<String, dynamic> requestBody = {"responses": submissions};

    debugPrint(
      "Preparing to POST to: $_submitFeedbackPath with body structure: ${requestBody.keys}",
    );
    if (kDebugMode) {
      try {
        debugPrint(
          "Detailed Request Body prepared for GetConnect: ${json.encode(requestBody)}",
        );
      } catch (e) {
        debugPrint("Could not json encode requestBody for debug print: $e");
      }
    }
    return post(_submitFeedbackPath, requestBody);
  }
}
