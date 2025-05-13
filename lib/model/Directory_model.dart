class DirectoryModel {
  final String name;
  final String designation;
  final String profile;

  DirectoryModel({
    required this.name,
    required this.designation,
    required this.profile,
  });
  factory DirectoryModel.fromJson(Map<String, dynamic> json) {
    return DirectoryModel(
      name: json['name'],
      designation: json['designation'],
      profile: json['profile'],
    );
  }
}

class AdvisoryCommittee {
  final String categoryName;
  final List<DirectoryModel> directoryList;

  AdvisoryCommittee({required this.categoryName, required this.directoryList});

  factory AdvisoryCommittee.fromJson(Map<String, dynamic> json) {
    return AdvisoryCommittee(
      categoryName: json['category_name'],
      directoryList:
          (json['directoryList'] as List)
              .map((item) => DirectoryModel.fromJson(item))
              .toList(),
    );
  }
}

class Patrons {
  final String categoryName;
  final List<DirectoryModel> directoryList;

  Patrons({required this.categoryName, required this.directoryList});

  factory Patrons.fromJson(Map<String, dynamic> json) {
    return Patrons(
      categoryName: json['category_name'],
      directoryList:
          (json['directoryList'] as List)
              .map((item) => DirectoryModel.fromJson(item))
              .toList(),
    );
  }
}

class DirectoryResponse {
  final String status;
  final int directoryCount;
  final List<AdvisoryCommittee> directoryLists;

  DirectoryResponse({
    required this.status,
    required this.directoryCount,
    required this.directoryLists,
  });

  factory DirectoryResponse.fromJson(Map<String, dynamic> json) {
    return DirectoryResponse(
      status: json['status'],
      directoryCount: json['directory_count'],
      directoryLists:
          (json['directoryLists'] as List)
              .map((item) => AdvisoryCommittee.fromJson(item))
              .toList(),
    );
  }
}
