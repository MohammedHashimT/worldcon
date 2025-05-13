class DownloadModel {
  final String name;
  final String pdf;

  DownloadModel({required this.name, required this.pdf});
  factory DownloadModel.fromJson(Map<String, dynamic> json) {
    return DownloadModel(name: json['name'], pdf: json['pdf']);
  }
  Map<String, dynamic> toJson() {
    return {'name': name, 'pdf': pdf};
  }
}

class DownloadResponse {
  final String status;
  final int listCount;
  final List<DownloadModel> pdfList;

  DownloadResponse({
    required this.status,
    required this.listCount,
    required this.pdfList,
  });

  factory DownloadResponse.fromJson(Map<String, dynamic> json) {
    return DownloadResponse(
      status: json['status'],
      listCount: json['pdf_list_count'],
      pdfList:
          (json['pdf_lists'] as List)
              .map((item) => DownloadModel.fromJson(item))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'pdf_list_count': listCount,
      'pdf_lists': pdfList,
    };
  }
}
