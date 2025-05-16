import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worldcon/controller/profile_controller.dart';

class Demographics extends StatefulWidget {
  const Demographics({super.key});

  @override
  State<Demographics> createState() => _DemographicsState();
}

class _DemographicsState extends State<Demographics> {
  final ProfileController profileController = Get.put(ProfileController());

  bool isBasicDetailsExpanded = false;
  bool isAddressExpanded = false;
  bool isContactInfoExpanded = false;
  bool isPaymentExpanded = false;

  Widget buildExpandableBlock({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required Widget expandedContent,
    required Color borderColor,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.grey[700],
                    ),
                  ],
                ),
              ),
            ),
          ),
          ClipRect(
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 200),
              firstCurve: Curves.easeOut,
              secondCurve: Curves.easeIn,
              sizeCurve: Curves.fastOutSlowIn,
              crossFadeState: isExpanded
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
                child: expandedContent,
              ),
              secondChild: const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color activeBorderColor = Colors.orange.shade600;
    final Color inactiveBorderColor = Colors.grey.shade300;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: const Text(
          'Demographics',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: Colors.orange[700]));
        }

        final userData = profileController.attendeeDetails;

        if (userData == null) {
          return const Center(
            child: Text(
              'Information is unavailable.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        final String name = userData.name ?? 'N/A';
        final String email = userData.email ?? 'N/A';
        final String Address = userData.address ?? 'N/A';
        final String phone = userData.number ?? 'N/A';
        final String Email = userData.email ?? 'N/A';
        final String paymentMethod = "Visa **** 1234";
        final String paymentStatus = "Paid";

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            children: [
              buildExpandableBlock(
                title: "Basic details",
                isExpanded: isBasicDetailsExpanded,
                borderColor: isBasicDetailsExpanded
                    ? activeBorderColor
                    : inactiveBorderColor,
                onTap: () {
                  setState(() {
                    isBasicDetailsExpanded = !isBasicDetailsExpanded;
                  });
                },
                expandedContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Name: $name", style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 4),
                    Text("Email: $email", style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              buildExpandableBlock(
                title: "Address",
                isExpanded: isAddressExpanded,
                borderColor: isAddressExpanded
                    ? activeBorderColor
                    : inactiveBorderColor,
                onTap: () {
                  setState(() {
                    isAddressExpanded = !isAddressExpanded;
                  });
                },
                expandedContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Text("$Address", style: const TextStyle(fontSize: 14))),
                  ],
                ),
              ),
              buildExpandableBlock(
                title: "Contact info",
                isExpanded: isContactInfoExpanded,
                borderColor: isContactInfoExpanded
                    ? activeBorderColor
                    : inactiveBorderColor,
                onTap: () {
                  setState(() {
                    isContactInfoExpanded = !isContactInfoExpanded;
                  });
                },
                expandedContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Phone: $phone", style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 4),
                    Text("Email: $Email", style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              buildExpandableBlock(
                title: "Payment",
                isExpanded: isPaymentExpanded,
                borderColor: isPaymentExpanded
                    ? activeBorderColor
                    : inactiveBorderColor,
                onTap: () {
                  setState(() {
                    isPaymentExpanded = !isPaymentExpanded;
                  });
                },
                expandedContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Method: $paymentMethod", style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 4),
                    Text("Status: $paymentStatus", style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
