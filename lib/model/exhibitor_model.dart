class ExhibitorModel {
  final String name;
  final String stall;
  final String category;

  ExhibitorModel({
    required this.name,
    required this.stall,
    required this.category,
  });
  factory ExhibitorModel.fromJson(Map<String, dynamic> json) {
    return ExhibitorModel(
      name: json['name'],
      stall: json['stall'],
      category: json['stallCategoryName'],
    );
  }

  // Map<String,dynamic> toJson(){
  //   return{
  //     'name': name,
  //     'stall': stall,
  //     'stallCategoryName': category
  //   };
  // }
}

class ExhibitorResponse {
  final String status;
  final int count;
  final List<ExhibitorModel> exhibitors;

  ExhibitorResponse({
    required this.status,
    required this.count,
    required this.exhibitors,
  });
  factory ExhibitorResponse.fromJson(Map<String, dynamic> json) {
    return ExhibitorResponse(
      status: json['status'],
      count: json['exhibitor_count'],
      exhibitors:
          (json['exhibitors'] as List)
              .map((item) => ExhibitorModel.fromJson(item))
              .toList(),
    );
  }
  // Map<String,dynamic> toJson(){
  //   return{
  //     'status': status,
  //     'exhibitor_count': count,
  //     'exhibitors': exhibitor
  //   };
  // }
}
