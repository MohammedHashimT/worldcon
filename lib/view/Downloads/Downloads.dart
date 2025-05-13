import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:worldcon/controller/download_controller.dart';
import 'package:worldcon/view/Downloads/Convocation_cermony.dart';
import 'package:worldcon/view/Downloads/Gynaecology_highlight.dart';
import 'package:worldcon/view/Downloads/Hands_on_training.dart';
import 'package:worldcon/view/Downloads/Highlights.dart';
import 'package:worldcon/view/Downloads/Parking_ins.dart';
import 'package:worldcon/view/Downloads/Procto_surg.dart';
import 'package:worldcon/view/Downloads/Proctocure.dart';
import 'package:worldcon/view/Downloads/Surgical_mapping.dart';
import 'package:worldcon/view/Downloads/Surgical_workshops.dart';
import 'package:worldcon/view/Downloads/Trade Brochure.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  final DownloadController _downloadController = Get.put(DownloadController());
  final TextEditingController searchController = TextEditingController();
  final RxList filteredList = [].obs;

  bool isSearching = false;

  final List<Widget> screens = [
    GynaecologyHighlight(),
    SurgicalMapping(),
    SurgicalWorkshops(),
    HandsOnTraining(),
    ProctoSurg(),
    ConvocationCeremony(),
    Highlights(),
    TradeBrochure(),
    Proctocure(),
    ParkingIns(),
  ];

  @override
  void initState() {
    super.initState();
    ever(_downloadController.pdf, (_) {
      filteredList.assignAll(_downloadController.pdf);
    });
  }

  void filterSearch(String query) {
    final allItems = _downloadController.pdf;
    if (query.isEmpty) {
      filteredList.assignAll(allItems);
    } else {
      filteredList.assignAll(
        allItems.where(
          (entry) => entry.name.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title:
            isSearching
                ? TextFormField(
                  controller: searchController,
                  autofocus: true,
                  onChanged: filterSearch,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                )
                : const Text(
                  'Downloads',
                  style: TextStyle(color: Colors.white),
                ),
        actions: [
          IconButton(
            icon: Icon(
              isSearching ? Icons.close : Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                if (isSearching) {
                  searchController.clear();
                  filteredList.assignAll(_downloadController.pdf);
                }
                isSearching = !isSearching;
              });
            },
          ),
        ],
      ),
      body: Obx(() {
        if (_downloadController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (_downloadController.errorMessage.value != null) {
          return Center(
            child: Text('Error: ${_downloadController.errorMessage.value}'),
          );
        } else {
          return ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final entry = filteredList[index];
              final originalIndex = _downloadController.pdf.indexOf(entry);

              return ListTile(
                leading: Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.orange[700],
                ),
                title: Text(entry.name, style: const TextStyle(fontSize: 20)),
                onTap: () {
                  if (originalIndex < screens.length) {
                    Get.to(() => screens[originalIndex]);
                  }
                },
              );
            },
          );
        }
      }),
    );
  }
}
