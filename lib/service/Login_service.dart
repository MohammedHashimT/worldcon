import 'package:get/get.dart';

class ApiService extends GetConnect {
  final String _baseUrl = 'https://app.worldcon2025kochi.com/api';

  Future<Response> generateOtp(String email) {
    final body = {'email': email};
    return post('$_baseUrl/generate-otp', body);
  }

  Future<Response> verifyOtp(String email, String otp) {
    final body = {'email': email, 'otp': otp};
    if (otp == "123456") {
      return Future.value(
        Response(
          statusCode: 200,
          body: {
            'status': true,
            'message': 'Login successful',
            'token': 'user_token_here',
          },
        ),
      );
    } else {
      return Future.value(
        Response(
          statusCode: 400,
          body: {'status': false, 'message': 'Invalid OTP'},
        ),
      );
    }
  }
}
