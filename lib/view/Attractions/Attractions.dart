import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:worldcon/controller/attraction_controller.dart';

class AttractionScreen extends StatelessWidget {
  AttractionScreen({super.key});

  final AttractionController attractionController = Get.put(
    AttractionController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: const Text('Attractions', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (attractionController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final data = attractionController.attractionList;
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: data.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 0,
            childAspectRatio: 3,
          ),
          itemBuilder: (context, index) {
            final item = data[index];
            return GridItem(
              image: Image.network(
                item.image,
                fit: BoxFit.cover,
                width: 80,
                height: 80,
              ),
              title: item.description,
              heading: item.name,
              onTap: () {
                Get.to(
                      () => Scaffold(
                    appBar: AppBar(
                      title: Text(
                        item.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.orange[700],
                      iconTheme: const IconThemeData(color: Colors.white),
                    ),
                    body: Html(data: item.content),
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}

class GridItem extends StatelessWidget {
  final Image image;
  final String title;
  final String heading;
  final VoidCallback onTap;

  const GridItem({
    super.key,
    required this.image,
    required this.title,
    required this.heading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),

          child: Text(
            heading,
            style:  TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.orange[700],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // Main container
        Container(
          color: Colors.white,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 110,
                    height: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: image,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
