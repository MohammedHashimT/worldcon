import 'package:flutter/material.dart';

class AccompanyingPersons extends StatelessWidget {
  const AccompanyingPersons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    appBar:   AppBar(
        backgroundColor: Colors.orange[700],
        title: const Text('Accompanying Persons', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_off_sharp, size: 100,),
              Text('No accompanying persons added')
            ],
          ),
        ],
      ),
    );
  }
}
