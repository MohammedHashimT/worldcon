import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worldcon/controller/speaker_controller.dart';

class Speakers extends StatefulWidget {
  const Speakers({super.key});

  @override
  State<Speakers> createState() => _SpeakersState();
}

class _SpeakersState extends State<Speakers> {
  final SpeakerController speakerController = Get.put(SpeakerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: const Text('Speakers', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (speakerController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (speakerController.errorMessage.value != null) {
          return Center(
            child: Text('Error: ${speakerController.errorMessage.value}'),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: speakerController.speakerList.length,
                  itemBuilder: (context, index) {
                    final speakers = speakerController.speakerList[index];
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

                          leading:
                              (speakers.image != null &&
                                      speakers.image!.isNotEmpty)
                                  ? Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(speakers.image!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                  : CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.grey,
                                    child: Text(
                                      (speakers.name?.isNotEmpty ?? false)
                                          ? speakers.name![0].toUpperCase()
                                          : '',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),

                          title: Text(
                            speakers.name ?? 'N/A',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            speakers.designation ?? '',
                            style: TextStyle(fontSize: 12),
                          ),
                          onTap: (){
                            (context);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
