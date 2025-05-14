class AttractionModel {
  final String name;
  final String description;
  final String content;
  final String image;

  AttractionModel({
    required this.name,
    required this.description,
    required this.content,
    required this.image,
  });
  factory AttractionModel.fromJson(Map<String, dynamic> json) {
    return AttractionModel(
      name: json['name'],
      description: json['short_description'],
      content: json['content'],
      image: json['image'],
    );
  }
  // Map<String, dynamic> toJson() {
  //   return {'name': name,'short_description':description, 'content': content, 'image': image};
  // }
}

class AttractionResponse {
  final String status;
  final int count;
  final List<AttractionModel> attlists;

  AttractionResponse({
    required this.status,
    required this.count,
    required this.attlists,
  });
  factory AttractionResponse.fromJson(Map<String, dynamic> json) {
    return AttractionResponse(
      status: json['status'],
      count: json['places_to_visit_count'],
      attlists:
          (json['places_to_visit_lists'] as List)
              .map((item) => AttractionModel.fromJson(item))
              .toList(),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'status': status,
  //     'places_to_visit_count': count,
  //     'places_to_visit_lists': attlists,
  //   };
  // }
}
