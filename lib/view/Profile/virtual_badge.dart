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

      body: Obx(() {
        if (profileController.isLoading.value) {
          return CircularProgressIndicator(color: Colors.orange[700]);
        }

        final userData = profileController.attendeeDetails;
        if (userData == null) {
          return const Text(
            'Information is unavailable.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('Assets/img/logo.jpg'),
            Text(userData.name ?? '', style: TextStyle(
              color: Colors.grey[600], fontSize: 24,fontWeight: FontWeight.w500
            ),),
            Text('Reg No:${userData.regno}',style: TextStyle(
                color: Colors.grey[600], fontSize: 14,fontWeight: FontWeight.w500
            ),),
            Text('ISCP Non Member',style: TextStyle(
                color: Colors.grey[600], fontSize: 24,fontWeight: FontWeight.w500
            ),),
            Text(
              '10th World Congress of Coloproctology',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w400,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10,),
            Row(
              children:  [
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Icon(Icons.calendar_month, color: Colors.grey[500]),
                ),
                Text('April 3rd-6th, 2025'),
              ],
            ),
            const SizedBox(height: 5),
            Row(

              children:  [
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Icon(Icons.location_on, color: Colors.grey[500]),
                ),
                Expanded(
                  child: Text(
                    'Gokulam Park Convention Centre, Kochi, Kerala',
                    overflow: TextOverflow.ellipsis,

                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
