class FeedbackSubmissionModel {
  final int? questionid;
  final int? optionid;

  FeedbackSubmissionModel({this.optionid, this.questionid});

  factory FeedbackSubmissionModel.fromJson(Map<String, dynamic> json) {
    return FeedbackSubmissionModel(
      questionid: json['question_id'],
      optionid: json['option_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'question_id': questionid, 'option_id': optionid};
  }
}

class SubmissionResponse {
  final String status;
  final List<FeedbackSubmissionModel> data;

  SubmissionResponse({required this.status, required this.data});

  factory SubmissionResponse.fromJson(Map<String, dynamic> json) {
    return SubmissionResponse(
      status: json['status'],
      data:
          (json['data'] as List)
              .map((item) => FeedbackSubmissionModel.fromJson(item))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}
