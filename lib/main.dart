import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:worldcon/view/Downloads/Downloads.dart';
import 'package:worldcon/Login.dart';
import 'package:worldcon/view/Sample/sample.dart';
import 'package:worldcon/view/Attendees.dart';
import 'package:worldcon/view/Directory.dart';
import 'package:worldcon/view/Downloads/Gynaecology_highlight.dart';
import 'package:worldcon/view/Home.dart';
import 'package:worldcon/view/Info/About_venue.dart';
import 'package:worldcon/view/Info/Information.dart';
import 'package:worldcon/view/NavigationBar.dart';
import 'package:worldcon/view/Routemap_venue_layout.dart';
import 'package:worldcon/view/Venue%20Layout/VENUE.dart';
import 'package:worldcon/view/Venue%20Layout/Venue_layout.dart';
import 'package:worldcon/view/speakers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Worldcon',
      debugShowCheckedModeBanner: false,
      home: CustomNavigationBar(),
    );
  }
}
