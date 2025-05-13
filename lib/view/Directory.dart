import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worldcon/controller/Directory_controller.dart';

class DirectoryScreen extends StatelessWidget {
  DirectoryScreen({super.key});

  final DirectoryController directoryController = Get.put(
    DirectoryController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: const Text('Directory',style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          if (directoryController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (directoryController.errorMessage.value != null) {
            return Center(
              child: Text('Error: ${directoryController.errorMessage.value!}'),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NATIONAL ADVISORY COMMITEE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      directoryController
                          .nationalAdvisoryCommitteeList
                          .length,
                  itemBuilder: (context, index) {
                    final entry =
                        directoryController
                            .nationalAdvisoryCommitteeList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),

                        child: SizedBox(
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: ListTile(
                              leading: SizedBox(
                                height: 100,
                                child: Image.network(
                                  entry.profile,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    entry.designation,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'PATRONS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      directoryController
                          .patronsList
                          .length,
                  itemBuilder: (context, index) {
                    final entry =
                        directoryController
                            .patronsList[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 6,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        child: SizedBox(
                          height: 100,
                          child: ListTile(
                            leading: Image.network(entry.profile),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entry.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  entry.designation,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
