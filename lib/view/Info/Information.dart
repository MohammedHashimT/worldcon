import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:worldcon/controller/Directory_controller.dart';
import 'package:worldcon/controller/info_controller.dart';
import 'package:worldcon/view/Info/About_ISCP.dart';
import 'package:worldcon/view/Info/About_kerala.dart';
import 'package:worldcon/view/Info/About_kochi.dart';
import 'package:worldcon/view/Info/About_venue.dart';
import 'package:worldcon/view/Info/About_worldcon.dart';
import 'package:worldcon/view/Info/Accomodation.dart';
import 'package:worldcon/view/Info/Lunch.dart';
import 'package:worldcon/view/Info/Registration_information.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final InfoController infoController = Get.put(InfoController());

  final List<Widget> Screens = [
    Iscp(),
    Worldcon(),
    Venue(),
    Kochi(),
    RegstrInfo(),
    Kerala(),
    Accomodation(),
    lunch(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: Text('Information', style: TextStyle(color: Colors.white)),
      ),
      body: Obx(() {
        if (infoController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (infoController.errorMessage.value != null) {
          return Center(
            child: Text('Error: ${infoController.errorMessage.value}'),
          );
        } else {
          return Column(
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: infoController.infoList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final information = infoController.infoList[index];
                  final originalIndex = infoController.infoList.indexOf(
                    information,
                  );

                  return ListTile(
                    leading: Image.network(
                      information.icon,
                      width: 24,
                      height: 24,
                    ),
                    title: Text(information.name),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.orange[700],
                    ),
                    onTap: () {
                      if (originalIndex < Screens.length) {
                        Get.to(() => Screens[originalIndex]);
                      }
                    },
                  );
                },
              ),
            ],
          );
        }
      }),
    );
  }
}
