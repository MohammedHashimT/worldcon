class AttendeeModel {
  String name;
  String email;
  String phoneNumber;

  AttendeeModel({
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  factory AttendeeModel.fromJson(Map<String, dynamic> json) {
    return AttendeeModel(
      name: json['full_name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_mobile'] as String,
    );
  }
}

class AttendeeList {
  final bool status;
  final List<AttendeeModel> attendees;

  AttendeeList({required this.status, required this.attendees});

  factory AttendeeList.fromJson(List<dynamic> json) {
    return AttendeeList(
      status: json[0]['status'] as bool,
      attendees:
          (json[0]['attendees'] as List)
              .map((item) => AttendeeModel.fromJson(item))
              .toList(),
    );
  }
}
