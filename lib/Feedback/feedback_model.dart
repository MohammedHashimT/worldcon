class OptionModel {
  final int id;
  final int questionId;
  final String optionValue;

  OptionModel({
    required this.id,
    required this.questionId,
    required this.optionValue,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'] as int,
      questionId: json['question_id'] as int,
      optionValue: json['option_value'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'question_id': questionId, 'option_value': optionValue};
  }
}

class FeedbackModel {
  final int id;
  final String question;
  final String type;
  final int hasComments;
  final List<OptionModel> options;
  String? selectedOptionId;

  FeedbackModel({
    required this.id,
    required this.question,
    required this.type,
    required this.hasComments,
    required this.options,
    this.selectedOptionId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question_value': question,
      'type': type,
      'has_comments': hasComments,
      'options': options.map((o) => o.toJson()).toList(),
    };
  }

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    var optionsListFromJson = json['options'] as List<dynamic>?;
    List<OptionModel> parsedOptions =
        optionsListFromJson != null
            ? optionsListFromJson
                .map(
                  (optionJson) =>
                      OptionModel.fromJson(optionJson as Map<String, dynamic>),
                )
                .toList()
            : [];

    String? preSelectedValue;
    // if (json['feedback_submissions'] != null &&
    //     (json['feedback_submissions'] as List).isNotEmpty) {
    //   var firstSubmission =
    //       (json['feedback_submissions'] as List).first as Map<String, dynamic>?;
    //   if (firstSubmission != null) {
    //     if (json['type'] == 'multiple_choice' &&
    //         firstSubmission['option_id'] != null) {
    //       preSelectedValue = firstSubmission['option_id'].toString();
    //     } else if (json['type'] == 'descriptive' &&
    //         firstSubmission['submission_value'] != null) {
    //       preSelectedValue = firstSubmission['submission_value'] as String?;
    //     }
    //   }
    // }

    return FeedbackModel(
      id: json['id'] as int,
      question: json['question_value'] as String? ?? 'No question text',
      type: json['type'] as String? ?? 'unknown',
      hasComments: json['has_comments'] as int? ?? 0,
      options: parsedOptions,
      selectedOptionId: preSelectedValue,
    );
  }
}

class FeedbackResponse {
  final String status;
  final List<FeedbackModel> data;

  FeedbackResponse({required this.status, required this.data});

  factory FeedbackResponse.fromJson(Map<String, dynamic> json) {
    var dataListFromJson = json['data'] as List<dynamic>?;
    List<FeedbackModel> parsedData =
        dataListFromJson != null
            ? dataListFromJson
                .map(
                  (itemJson) =>
                      FeedbackModel.fromJson(itemJson as Map<String, dynamic>),
                )
                .toList()
            : [];

    return FeedbackResponse(
      status: json['status'] as String? ?? 'unknown',
      data: parsedData,
    );
  }
}

class FeedbackSubmissionModel {
  final int? questionid;
  final int? optionid;
  // final String? submissionValue;

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

class SubmissionPayload {
  final String status;
  final List<FeedbackSubmissionModel> data;

  SubmissionPayload({required this.status, required this.data});

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}
