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
  Map<String,dynamic>toJson(){
    return{
      'id':id,
      'question_id':questionId,
      'option_value':optionValue
    };
  }
}

class FeedbackModel {
  final int id;
  final String question;
  final String type;
  final int hasComments;
  final List<OptionModel> options;

  FeedbackModel({
    required this.id,
    required this.question,
    required this.type,
    required this.hasComments,
    required this.options, required String userId,
  });

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

    return FeedbackModel(
      id: json['id'] as int,
      question: json['question_value'] as String? ?? 'No question text',
      type: json['type'] as String? ?? 'unknown',
      hasComments: json['has_comments'] as int? ?? 0,
      options: parsedOptions, userId: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question_value': question,
      'type': type,
      'has_comments': hasComments,
      'options':options,
    };
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
