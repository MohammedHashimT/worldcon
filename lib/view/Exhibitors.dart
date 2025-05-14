import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worldcon/controller/exhibitor_controller.dart';

class ExhibitorScreen extends StatelessWidget {
  ExhibitorScreen({super.key});

  final ExhibitorController exhibitorController = Get.put(
    ExhibitorController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: const Text('Exhibitors', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (exhibitorController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (exhibitorController.errorMessage.value != null) {
          return Center(
            child: Text('Error: ${exhibitorController.errorMessage.value}'),
          );
        } else {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: exhibitorController.exhibitorList.length,
            itemBuilder: (context, index) {
              final exhibitors = exhibitorController.exhibitorList[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8, left: 8),
                child: Card(
                  color: Colors.white,
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Container(
                      height: 30,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.orange[700],
                        borderRadius: const BorderRadius.all(
                          Radius.elliptical(50, 50),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Stall ${exhibitors.stall}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Company:',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: Icon(
                              Icons.apartment,
                              size: 14,
                              color: Colors.grey,
                            ),
                          ),
                          TextSpan(
                            text: " ${exhibitors.name}",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    subtitle: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Category: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ),

                          TextSpan(
                            text: exhibitors.category,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
