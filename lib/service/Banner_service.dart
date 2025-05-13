import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/Banner_model.dart';

class BannerService extends GetConnect {
  final String bannerUrl = 'http://app.worldcon2025kochi.com/api/banners';

  Future<Response<BannerResponse>> getBanners() async {
    try {
      final response = await http.get(Uri.parse(bannerUrl));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final bannerResponse = BannerResponse.fromJson(jsonResponse);
        return Response<BannerResponse>(
          body: bannerResponse,
          statusCode: response.statusCode,
          statusText: response.reasonPhrase,
        );
      } else {
        return Response<BannerResponse>(
          statusCode: response.statusCode,
          statusText:
              'Failed to load data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      return Response<BannerResponse>(
        statusText: 'Error during data fetching: $e',
        statusCode: 500,
      );
    }
    // return await get<BannerResponse>(bannerUrl, decoder: (json) => BannerResponse.fromJson(json));
  }
}
