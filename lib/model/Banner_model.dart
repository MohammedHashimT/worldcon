class BannerModel {
  final int id;
  final String imagePath;
  final String type;

  BannerModel({required this.id, required this.imagePath, required this.type});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      imagePath: json['image_path'],
      type: json['type'],
    );
  }
}

class BannerResponse {
  final String? status;
  final int? bannersCount;
  final List<BannerModel>? banners;

  BannerResponse({this.status, this.bannersCount, this.banners});

  factory BannerResponse.fromJson(Map<String, dynamic> json) {
    var list = json['banners'] as List;
    List<BannerModel> bannerList =
        list.map((i) => BannerModel.fromJson(i)).toList();

    return BannerResponse(
      status: json['status'],
      bannersCount: json['banners_count'],
      banners: bannerList,
    );
  }
}
