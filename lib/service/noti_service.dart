import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:worldcon/model/noti_model.dart';

class NotiService {
  static const String baseUrl =
      'https://app.worldcon2025kochi.com/api/attendees';

  Future<List<NotiModel>> fetchNotiData() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer 785|uPhf1eeJkZ3itFAYx5NJzcHQRSb75HUdELJS8fOR',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final attendeesJson = decoded['attendees'] as List;
      return attendeesJson.map((e) => NotiModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<bool> addNotification(NotiModel notify) async {
    return true;
  }

  static Future<bool> removeNotification(String id) async {
    return true;
  }
}
