import 'package:flutter/material.dart';
import 'package:worldcon/view/Profile/accompanying_persons.dart';
import 'package:worldcon/view/Profile/demographics.dart';
import 'package:worldcon/view/Profile/virtual_badge.dart';

class MyRegstrScreen extends StatelessWidget {
  const MyRegstrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color iconColor = Colors.orange.shade700;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange.shade700,
        title: const Text(
          'My Registration',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 1.0, // Subtle elevation
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          ListTile(
            title: const Text(
              'Virtual badge',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: iconColor,
              size: 18,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VirtualBadge()),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Demographics',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: iconColor,
              size: 18,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Demographics()),
              );
            },
          ),

          ListTile(
            title: const Text(
              'Accompanying persons',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: iconColor,
              size: 18,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccompanyingPersons()),
              );
            },
          ),

        ],
      ),
    );
  }
}
