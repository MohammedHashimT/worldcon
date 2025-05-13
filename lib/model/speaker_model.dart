class speakerModel {
  final String? name; // Allow null
  final String? designation; // Allow null
  final String? image; // Allow null

  speakerModel({
    this.name,
    this.designation,
    this.image,
  });

  factory speakerModel.fromJson(Map<String, dynamic> json) {
    return speakerModel(
      name: json['name'] as String?, // Cast to String?
      designation: json['designation'] as String?, // Cast to String?
      image: json['image'] as String?, // Cast to String?
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
