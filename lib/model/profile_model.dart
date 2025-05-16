class AttendeeModel {
  final String? regno;
  final String? name;
  final String? address;
  final String? number;
  final String? email;

  AttendeeModel({this.regno, this.name, this.address, this.number, this.email});
  factory AttendeeModel.fromJson(Map<String, dynamic> json) {
    return AttendeeModel(
      regno: json['registration_number'],
      name: json['full_name'],
      address: json['postal_address'],
      number: json['phone_mobile'],
      email: json['email'],
    );
  }
}

class ProfileModel {
  final AttendeeModel? attendee;

  ProfileModel({this.attendee});
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      attendee:
          json['attendee'] != null
              ? AttendeeModel.fromJson(json['attendee'] as Map<String, dynamic>)
              : null,
    );
  }
}

class ProfileResponse {
  final bool? status;
  final ProfileModel? user;

  ProfileResponse({this.status, this.user});

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      status: json['status'] as bool?,
      user:
          json['user'] != null
              ? ProfileModel.fromJson(json['user'] as Map<String, dynamic>)
              : null,
    );
  }
}
