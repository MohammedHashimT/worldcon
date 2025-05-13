import 'package:flutter/material.dart';

class VenueScreen extends StatelessWidget {
  const VenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: const Text('VENUE LAYOUT'),
      ),
      body: Center(
        child: Container(
          child: Image.asset('Assets/img/logo.jpg', fit: BoxFit.cover),
        ),
      ),
    );
  }
}
