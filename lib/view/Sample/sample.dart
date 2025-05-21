// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// void showLogoutDialog() {
//   Get.dialog(
//     Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               "Logout?",
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               "Do you really want to logout?",
//               style: TextStyle(fontSize: 15),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             Divider(height: 1),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextButton(
//                     onPressed: () async {
//                       final tokenService = Get.find<TokenService>();
//                       await tokenService.removeToken();
//                       Get.offAll(() => LoginScreen());
//                     },
//                     child: Text(
//                       "Yes",
//                       style: TextStyle(color: Colors.red),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: 48,
//                   width: 1,
//                   color: Colors.grey[300],
//                 ),
//                 Expanded(
//                   child: TextButton(
//                     onPressed: () => Get.back(),
//                     child: Text(
//                       "No",
//                       style: TextStyle(color: Colors.green),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     ),
//     barrierDismissible: false,
//   );
// }
