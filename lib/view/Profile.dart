import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:worldcon/Login.dart';
import 'package:worldcon/Shared_Preferences/shared_preferences.dart';
import 'package:worldcon/controller/delete_controller.dart';
import 'package:worldcon/controller/profile_controller.dart';
import 'package:worldcon/view/Profile/accompanying_persons.dart';
import 'package:worldcon/view/Profile/demographics.dart';
import 'package:worldcon/view/Profile/virtual_badge.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final ProfileController profileController = Get.put(ProfileController());
  final DeleteController deleteController=Get.put(DeleteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Obx(() {
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
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
              SizedBox(height: 20),
              Text(
                userData.name ?? 'Name not found',
                style: TextStyle(
                  color: Colors.orange[700],
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(userData.email ?? 'No email found'),
              SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VirtualBadge()),
                    );
                  },
                  child: Container(
                    height: 20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Virtual badge', style: TextStyle(fontSize: 16)),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: Colors.orange[700],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Demographics()),
                    );
                  },
                  child: Container(
                    height: 20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Demographics', style: TextStyle(fontSize: 16)),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: Colors.orange[700],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0.0,
                  vertical: 8.0,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccompanyingPersons(),
                      ),
                    );
                  },

                  child: SizedBox(
                    height: 20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Accompanying persons',
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: Colors.orange[700],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),

              InkWell(
                onTap: (){
                  deleteController.confirmDeleteDialog();
                },
                child: Container(
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Delete Account',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              SizedBox(height: 10),

              InkWell(

                onTap: (){
                  Get.defaultDialog(
                    backgroundColor: Colors.white,
                    title: 'Logout?',
                    middleText: 'Are you sure you want to logout?',
                    textCancel: 'No',
                      textConfirm: 'Yes',
                    buttonColor: Colors.white,
                    confirmTextColor: Colors.red,
                    cancelTextColor: Colors.green,
                    onConfirm: ()async{
                      final tokenService=Get.find<TokenService>();
                      await tokenService.removeToken();

                      Get.offAll(()=> LoginScreen());
                    },
                    onCancel: (){
                      Get.back();
                    }
                  );
                },

                child: Container(
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

}
