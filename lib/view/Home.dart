import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:worldcon/view/Attendees.dart';
import 'package:worldcon/view/Attractions.dart';
import 'package:worldcon/view/Downloads/Downloads.dart';
import 'package:worldcon/view/Downloads/Parking_ins.dart';
import 'package:worldcon/view/Exhibitors.dart';
import 'package:worldcon/view/Feedback.dart';
import 'package:worldcon/view/Lost.dart';
import 'package:worldcon/view/Routemap_venue_layout.dart';
import 'package:worldcon/view/Sample/sample.dart';
import 'package:worldcon/view/Venue%20Layout/VENUE.dart';
import 'package:worldcon/view/Venue%20Layout/Venue_layout.dart';
import 'package:worldcon/view/speakers.dart';
import '../controller/Banner_control.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  MenuItem({required this.title, required this.icon, this.onTap});
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  final BannerController bannerController = Get.put(BannerController());

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBannerIndex = 0;

  final List<MenuItem> _horizontalMenuItems = [
    MenuItem(
      title: "Today's Program",
      icon: FontAwesomeIcons.calendarDay,
      onTap: () {},
    ),
    MenuItem(
      title: "Our Speakers",
      icon: FontAwesomeIcons.microphoneLines,
      onTap: () {
        Get.to(() => Speakers());
      },
    ),
    MenuItem(
      title: "Scientific Program",
      icon: FontAwesomeIcons.flaskVial,
      onTap: () {},
    ),
  ];

  final List<MenuItem> _quickLinks = [
    MenuItem(
      title: "Attendees",
      icon: FontAwesomeIcons.users,
      onTap: () {
        Get.to(() => Attendees());
      },
    ),
    MenuItem(
      title: "My Registration",
      icon: FontAwesomeIcons.solidRegistered,
      onTap: () {
        Get.to(()=> ProfileScreenAttendee());
      },
    ),
    MenuItem(title: "Quiz", icon: FontAwesomeIcons.linesLeaning, onTap: () {}),
    MenuItem(title: "Gallery", icon: FontAwesomeIcons.images, onTap: () {}),
    MenuItem(
      title: "Download Certificate",
      icon: FontAwesomeIcons.fileArrowDown,
      onTap: () {},
    ),
    MenuItem(
      title: "Root map to Venue",
      icon: FontAwesomeIcons.map,
      onTap: () {
        Get.to(() => RouteMap());
      },
    ),

    MenuItem(
      title: "Parking Instructions",
      icon: FontAwesomeIcons.squareVirus,
      onTap: () {
        Get.to(() => ParkingIns());
      },
    ),

    MenuItem(title: "Note", icon: FontAwesomeIcons.noteSticky, onTap: () {}),
    MenuItem(
      title: "Downloads",
      icon: FontAwesomeIcons.download,
      onTap: () {
        Get.to(() => DownloadScreen());
      },
    ),
    MenuItem(
      title: "Attractions",
      icon: FontAwesomeIcons.magnet,
      onTap: () {
        Get.to(AttractionScreen());
      },
    ),
    MenuItem(
      title: "Venue Layout",
      icon: FontAwesomeIcons.building,
      onTap: () {
        Get.to(() => VenueLayoutScreen());
      },
    ),
    MenuItem(
      title: "Exhibitors",
      icon: FontAwesomeIcons.layerGroup,
      onTap: () {
        Get.to(() => ExhibitorScreen());
      },
    ),
    MenuItem(
      title: "Lost & Found",
      icon: FontAwesomeIcons.question,
      onTap: () {
        Get.to(()=> LostScreen());
      },
    ),
    MenuItem(title: "Feedback", icon: FontAwesomeIcons.comment, onTap: () {
      Get.to(()=> FeedbackScreen()) ;
    }),

    MenuItem(
      title: "Refer Friend",
      icon: FontAwesomeIcons.userGroup,
      onTap: () {},
    ),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _startSlideshow();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _startSlideshow() {
    if (!mounted) return;
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      if (widget.bannerController.banners.isNotEmpty) {
        setState(() {
          _currentBannerIndex =
              (_currentBannerIndex + 1) %
              widget.bannerController.banners.length;
        });
      }
      _startSlideshow();
    });
  }

  Widget _buildQuickLinkItem(MenuItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: FaIcon(item.icon, color: Colors.red, size: 22),
        title: Text(
          item.title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: Colors.grey,
        ),
        onTap: item.onTap ?? () {},
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),
    );
  }

  Widget _buildHorizontalMenuItem(MenuItem item, BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: item.onTap ?? () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  shape: BoxShape.circle,
                ),
                child: FaIcon(item.icon, color: Colors.red, size: 30),
              ),
              const SizedBox(height: 8),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Colors.orange[700]!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        //automaticallyImplyLeading: false,

        title: Image.asset('Assets/img/logo.jpg'),
        actions: [
          _buildAppBarAction(FontAwesomeIcons.qrcode, () {}),
          _buildAppBarAction(FontAwesomeIcons.mapMarkerAlt, () {}),
          _buildAppBarAction(FontAwesomeIcons.globe, () {}),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(() {
              if (widget.bannerController.isLoading.value) {
                return _buildBannerPlaceholder(
                  context,
                  child: const Center(child: CircularProgressIndicator()),
                );
              } else if (widget.bannerController.errorMessage.value != null) {
                return _buildBannerPlaceholder(
                  context,
                  child: Center(
                    child: Text(
                      widget.bannerController.errorMessage.value!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  color: Colors.redAccent,
                );
              } else if (widget.bannerController.banners.isNotEmpty) {
                final currentBanner =
                    widget.bannerController.banners[_currentBannerIndex];
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.28,
                  child:
                      currentBanner.imagePath != null &&
                              currentBanner.imagePath!.isNotEmpty
                          ? Image.network(
                            currentBanner.imagePath!,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return _buildBannerPlaceholder(
                                context,
                                child: const Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Colors.grey,
                                    size: 50,
                                  ),
                                ),
                              );
                            },
                          )
                          : _buildBannerPlaceholder(
                            context,
                            child: const Center(
                              child: Text('Image not available'),
                            ),
                          ),
                );
              } else {
                return _buildBannerPlaceholder(
                  context,
                  child: const Center(child: Text('No banners available.')),
                );
              }
            }),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 8.0,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children:
                    _horizontalMenuItems
                        .map((item) => _buildHorizontalMenuItem(item, context))
                        .toList(),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 16.0,
                top: 8.0,
                bottom: 10.0,
              ),
              child: Text(
                'Quick Links',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),

            Column(
              children:
                  _quickLinks.map((item) => _buildQuickLinkItem(item)).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarAction(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: FaIcon(icon, color: Colors.orange[700], size: 20),
      splashRadius: 22,
      padding: const EdgeInsets.all(10),
    );
  }

  Widget _buildBannerPlaceholder(
    BuildContext context, {
    required Widget child,
    Color? color,
  }) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.28,
      color: color ?? Colors.grey[200],
      child: child,
    );
  }
}
