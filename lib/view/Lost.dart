import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worldcon/controller/lost_controller.dart';

class LostScreen extends StatelessWidget {
  LostScreen({super.key});
  final LostController lostController = Get.put(LostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: const Text(
          'Lost & Found',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.add_circle_outline)),
        ],

        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Obx(() {
        if (lostController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (lostController.errorMessage.value != null) {
          return Center(
            child: Text('Error: ${lostController.errorMessage.value}'),
          );
        }

        final data = lostController.lostList;

        return ListView.builder(
          itemCount: data.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = data[index];


            return Card(
              color: Colors.white,
              elevation: 2,
              child: ListTile(
                title: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Name:',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      TextSpan(text: item.lostname),
                    ],
                  ),
                ),

                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Submitted by:',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          TextSpan(text: ' '),
                        ],
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Status:',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          TextSpan(text: item.status),
                        ],
                      ),
                    ),

                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Description:',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          TextSpan(text: item.description),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
