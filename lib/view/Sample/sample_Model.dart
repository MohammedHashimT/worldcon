// class LoginResponse {
//   final String name;
//   final Map<String, dynamic> userDetails;
//
//   LoginResponse({
//     required this.name,
//     required this.userDetails
//   });
//
//   factory LoginResponse.fromJson(Map<String, dynamic> json) {
//     return LoginResponse(
//       name: json['full_name'],
//       userDetails: json['user'],
//     );
//   }
// }



// class SampleModel {
//   final String fullName;
//   final int phoneMobile;
//   final String email;
//
//   SampleModel({
//     required this.fullName,
//     required this.phoneMobile,
//     required this.email,
//   });
//
//   factory SampleModel.fromJson(Map<String, dynamic> json) {
//     return SampleModel(
//       fullName: json['full_name'] ,
//       phoneMobile: json['phone_mobile'] ,
//       email: json['email'] ,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'full_name': fullName,
//       'phone_mobile': phoneMobile,
//       'email': email,
//     };
//   }
// }
//
// class MinimalApiResponse {
//   final SampleModel? attendee;
//
//   MinimalApiResponse({this.attendee});
//
//   factory MinimalApiResponse.fromJson(Map<String, dynamic> json) {
//     return MinimalApiResponse(
//       attendee: json['attendee'] != null
//           ? SampleModel.fromJson(json['attendee'])
//           : null,
//     );
//   }
// }
