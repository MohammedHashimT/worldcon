class UserModel {
  final String? name;

  UserModel({this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(name: json['name']);
  }
}

class LostModel {
  final String? lostname;
  final String? description;
  final String? status;
  final UserModel? user;

  LostModel({this.lostname, this.description, this.status, this.user});

  factory LostModel.fromJson(Map<String, dynamic> json) {
    return LostModel(
      lostname: json['name'],
      description: json['description'],
      status: json['status'],
      user:
          json['user'] != null
              ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': lostname, 'description': description};
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
