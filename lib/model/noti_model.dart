class NotiModel {
  final String title;
  final String message;

  NotiModel({required this.title, required this.message});

  factory NotiModel.fromJson(Map<String, dynamic> json) {
    return NotiModel(title: json['title'], message: json['message']);
  }
}

class NotiResponse {
  final bool status;
  final String messages;
  final List<NotiModel> data;

  NotiResponse({
    required this.status,
    required this.messages,
    required this.data,
  });

  factory NotiResponse.fromJson(Map<String, dynamic> json) {
    return NotiResponse(
      status: json[0]['status'] as bool,
      messages: json['message'],
      data:
          (json['data'] as List)
              .map((item) => NotiModel.fromJson(item))
              .toList(),
    );
  }
}
