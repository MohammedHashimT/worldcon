import 'package:flutter/material.dart';

class AccompanyingPersons extends StatelessWidget {
  const AccompanyingPersons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:   AppBar(
        backgroundColor: Colors.orange[700],
        title: const Text('Accompanying Persons', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
    );
  }
}
