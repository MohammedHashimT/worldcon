import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worldcon/controller/Route_map_controller.dart';

class RouteMap extends StatelessWidget {
  RouteMap({super.key});
  final RouteMapController _routeMapController = Get.put(RouteMapController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: const Text(
          'Route Map to Venue',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          if (_routeMapController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (_routeMapController.errorMessage.value != null) {
            return Center(
              child: Text('Error: ${_routeMapController.errorMessage.value}'),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _routeMapController.venue.length,
                  itemBuilder: (context, index) {
                    final entry = _routeMapController.venue[index];
                    return ListTile(
                      contentPadding: EdgeInsets.all(12),
                      leading: Image.network(
                        entry.image,
                        width: 24,
                        height: 24,
                      ),
                      title: Text(entry.name, style: TextStyle(fontSize: 16)),
                      trailing: Icon(
                        Icons.keyboard_double_arrow_right,
                        color: Colors.orange[700],
                      ),
                      onTap: () {},
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
