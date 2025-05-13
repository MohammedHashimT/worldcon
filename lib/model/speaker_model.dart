class speakerModel {
  final String? name;
  final String? designation;
  final String? image;

  speakerModel({
    this.name,
    this.designation,
    this.image,
  });

  factory speakerModel.fromJson(Map<String, dynamic> json) {
    return speakerModel(
      name: json['name'] as String?,
      designation: json['designation'] as String?,
      image: json['image'] as String?,
    );
  }

  Map<String,dynamic> toJson(){
    return{
      'name': name,
      'designation': designation,
      'image': image
    };
  }
}

class speakerResponse {
  final String status;
  final int count;
  final List<speakerModel> personalities;

  speakerResponse({
    required this.status,
    required this.count,
    required this.personalities,
  });

  factory speakerResponse.fromJson(Map<String, dynamic> json) {
    return speakerResponse(
      status: json['status'],
      count: json['personality_count'],
      personalities:
          (json['personalities'] as List)
              .map((item) => speakerModel.fromJson(item))
              .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'personality_count': count,
      'personalities': personalities,
    };
  }
}
