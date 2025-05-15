class LostModel {
  final String? name;
  final String? description;
  final String? status;

  LostModel({this.name, this.description, this.status});

  factory LostModel.fromJson(Map<String, dynamic> json) {
    return LostModel(
      name: json['name'],
      description: json['description'],
      status: json['status'],
    );
  }

  Map<String,dynamic>toJson(){
    return{
      'name':name,
      'description': description,

    };
}
}

class LostResponse {
  final List<LostModel> lostitems;

  LostResponse({required this.lostitems});

  factory LostResponse.fromJson(Map<String, dynamic> json) {
    return LostResponse(
      lostitems:
          (json['lost_items'] as List)
              .map((item) => LostModel.fromJson(item))
              .toList(),
    );
  }
}
