import 'package:flutter/material.dart';

class ExpandableDetails extends StatefulWidget {
  @override
  _ExpandableDetailsState createState() => _ExpandableDetailsState();
}

class _ExpandableDetailsState extends State<ExpandableDetails> {
  bool isExpanded1 = false;
  bool isExpanded2 = false;

  final String name = "John Doe";
  final String email = "john@example.com";
  final String phone = "+1234567890";
  final String address = "123, Main Street";

  Widget buildExpandableBlock({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required Widget expandedContent,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.orange),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Icon(
                    isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: Colors.orange,
                  )
                ],
              ),
            ),
          ),
          if (isExpanded)
            Divider(color: Colors.orange[300], height: 1),
          AnimatedCrossFade(
            duration: Duration(milliseconds: 250),
            crossFadeState: isExpanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10)),
              ),
              child: expandedContent,
            ),
            secondChild: SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildExpandableBlock(
              title: "Basic Details",
              isExpanded: isExpanded1,
              onTap: () {
                setState(() {
                  isExpanded1 = !isExpanded1;
                });
              },
              expandedContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: $name", style: TextStyle(fontSize: 14)),
                  SizedBox(height: 6),
                  Text("Email: $email", style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            buildExpandableBlock(
              title: "Contact Info",
              isExpanded: isExpanded2,
              onTap: () {
                setState(() {
                  isExpanded2 = !isExpanded2;
                });
              },
              expandedContent: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Phone: $phone", style: TextStyle(fontSize: 14)),
                  SizedBox(height: 6),
                  Text("Address: $address", style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
