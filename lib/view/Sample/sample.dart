// profile_screen_attendee.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/profile_controller.dart';

class ProfileScreenAttendee extends StatelessWidget {
  ProfileScreenAttendee({super.key});

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.teal.shade700;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attendee Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Obx(() {
          // --- 1. Loading State ---
          if (profileController.isLoading.value) {
            return CircularProgressIndicator(color: primaryColor);
          }

          // --- 2. Error State ---
          if (profileController.errorMessage.value != null) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Error: ${profileController.errorMessage.value}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.red.shade700),
              ),
            );
          }


          final attendee = profileController.attendeeDetails;

          if (attendee == null) {
            return const Text(
              'Attendee information is unavailable.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            );
          }

          // --- 4. Data Display State ---
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailItem("Registration QR:", attendee.regno),
                _buildDetailItem("Name:", attendee.name),
                _buildDetailItem("Email:", attendee.email),
                _buildDetailItem("Phone Number:", attendee.number),
                _buildDetailItem("Address:", attendee.address, maxLines: 3), // Address can be longer
              ],
            ),
          );
        }),
      ),
    );
  }

  // Helper widget to display each detail item
  Widget _buildDetailItem(String label, String? value, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          const SizedBox(height: 2),
          Text(
            value ?? 'N/A', // Provide 'N/A' if value is null
            style: const TextStyle(fontSize: 17, color: Colors.black87),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}