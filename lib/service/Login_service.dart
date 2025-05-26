import 'package:get/get.dart';

class ApiService extends GetConnect {
  final String _baseUrl = 'https://app.worldcon2025kochi.com/api';

  Future<Response> generateOtp(String email) {
    final body = {'email': email};
    return post('$_baseUrl/generate-otp', body);
  }

  Future<Response> verifyOtp(String email, String otp) {
    final body = {'email': email, 'otp': otp};
    return post('$_baseUrl/api-login', body);
  }
}
