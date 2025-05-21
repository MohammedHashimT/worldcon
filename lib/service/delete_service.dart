import 'package:http/http.dart' as http;

class DeleteService {
  final String baseUrl = 'https://app.worldcon2025kochi.com/api/delete-account';

  Future<bool> deleteAccount(String token) async {
    final response = await http.get(
      Uri.parse(baseUrl),

      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete account');
    }
  }
}
