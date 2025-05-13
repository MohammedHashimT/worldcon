import 'package:flutter/material.dart';
import 'package:worldcon/view/Info/About_venue.dart';
import 'package:worldcon/view/Venue%20Layout/VENUE.dart';

class VenueLayoutScreen extends StatelessWidget {
  const VenueLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: const Text('Venue Layout'),
      ),

      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VenueScreen()),
              );
            },
            child: ListTile(
              leading: Text('VENUE LAYOUT', style: TextStyle(fontSize: 16)),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.orange[700],
              ),
            ),
          );
        },
      ),
    );
  }
}
