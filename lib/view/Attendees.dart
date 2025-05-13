import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/Atendee_control.dart';

class Attendees extends StatelessWidget {
  Attendees({super.key});
  final controller = Get.put(AttendeeController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchAttendees();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: const Text('Attendees', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.attendees.length,
                itemBuilder: (context, index) {
                  final attendee = controller.attendees[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey, // Background color
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            (attendee.name.isNotEmpty)
                                ? attendee.name[0].toUpperCase()
                                : '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        title: Text(
                          attendee.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          '${attendee.email} \n ${attendee.phoneNumber}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
