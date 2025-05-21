import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worldcon/controller/profile_controller.dart';

class VirtualBadge extends StatelessWidget {
  VirtualBadge({super.key});
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          if (profileController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(color: Colors.orange[700]),
            );
          }

          final userData = profileController.attendeeDetails;
          if (userData == null) {
            return const Center(
              child: Text(
                'Information is unavailable.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('Assets/img/logo.jpg', height: 100),
                const SizedBox(height: 20),

                // NativeQr(
                //   data: "Reg No: 12345",
                //   color: Colors.black,
                //   backgroundColor: Colors.white,
                //   errorCorrectionLevel: ErrorCorrectionLevel.low,
                // )
                const SizedBox(height: 16),
                Text(
                  userData.name ?? '',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Reg No: ${userData.regno}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'ISCP Non Member',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '10th World Congress of Coloproctology',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(Icons.calendar_month, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      'April 3rd–6th, 2025',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Gokulam Park Convention Centre, Kochi, Kerala',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
