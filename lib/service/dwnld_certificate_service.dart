import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:worldcon/model/dwnld_certificate_model.dart';

class DwnldCertificateService {
  static const String baseUrl =
      'https://app.worldcon2025kochi.com/api/certificate-download';

  Future<CertificateDownloadInfo> fetchCertificateData() async {
    try {
      final response = await http.get(Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer 798|u01pfrfw9LooW0jrIlftRRWizLjCdavOUY9wBKC1',
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return CertificateDownloadInfo.fromJson(jsonResponse);
      } else {
        throw Exception(
          'Failed to load data . Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error during data fetching: $e');
    }
  }
}