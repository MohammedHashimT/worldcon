class InfoModel {
  final String name;
  final String content;
  final String icon;

  InfoModel({required this.name, required this.content, required this.icon});

  factory InfoModel.fromJson(Map<String, dynamic> json) {
    return InfoModel(
      name: json['name'],
      content: json['content'],
      icon: json['icon'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'name': name, 'content': content, 'icon': icon};
  }
}

class InfoResponse {
  final String status;
  final int count;
  final List<InfoModel> infolists;

  InfoResponse({
    required this.status,
    required this.count,
    required this.infolists,
  });

  factory InfoResponse.fromJson(Map<String, dynamic> json) {
    return InfoResponse(
      status: json['status'],
      count: json['info_lists_count'],
      infolists:
          (json['infoLists'] as List)
              .map((item) => InfoModel.fromJson(item))
              .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'info_lists_count': count,
      'infoLists': infolists,
    };
  }
}
