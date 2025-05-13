import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worldcon/controller/noti_controller.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotiController notiController = Get.put(NotiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: const Text('Notifications',style: TextStyle(color: Colors.white),),
      ),
      body: Obx(() {
        if (notiController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (notiController.notiList.isEmpty) {
          return const Center(child: Text("No notifications found."));
        } else {
          return ListView.builder(
            itemCount: notiController.notiList.length,
            itemBuilder: (context, index) {
              final notification = notiController.notiList[index];
              return ListTile(
                leading: Icon(Icons.notifications, color: Colors.orange[700]),
                title: Text(notification.title),
                subtitle: Text(notification.message),
                onTap: () {},
              );
            },
          );
        }
      }),
    );
  }
}
