import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:worldcon/controller/dwnld_certificate_controller.dart'; // Make sure this path is correct
import 'package:worldcon/Feedback/feedback_controller.dart';
import 'package:worldcon/view/Attendees.dart';
import 'package:worldcon/view/Attractions.dart';
import 'package:worldcon/view/Downloads/Downloads.dart';
import 'package:worldcon/view/Downloads/Parking_ins.dart';
import 'package:worldcon/view/Exhibitors.dart';
import 'package:worldcon/Feedback/Feedback.dart';
import 'package:worldcon/view/Lost.dart';
import 'package:worldcon/view/My_registration.dart';
import 'package:worldcon/view/Routemap_venue_layout.dart';
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
  final CertificateController certificateController = Get.put(
    CertificateController(),
  );

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBannerIndex = 0;
  final double _horizontalMenuHeight = 120.0;

  late final List<MenuItem> _horizontalMenuItems;
  late final List<MenuItem> _quickLinks;

  @override
  void initState() {
    super.initState();

    _horizontalMenuItems = [
      MenuItem(
        title: "Today's Program",
        icon: FontAwesomeIcons.calendarDay,
        onTap: () {

        },
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
        onTap: () {
        },
      ),
    ];

    _quickLinks = [
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
          Get.to(() => MyRegstrScreen());
        },
      ),
      MenuItem(
        title: "Quiz",
        icon: FontAwesomeIcons.linesLeaning,
        onTap: () {
        },
      ),
      MenuItem(
        title: "Gallery",
        icon: FontAwesomeIcons.images,
        onTap: () {
        },
      ),
      MenuItem(
        title: "Download Certificate",
        icon: FontAwesomeIcons.fileArrowDown,
        onTap: () {
          widget.certificateController.shareCertificateFile();
          },
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
        icon: FontAwesomeIcons.squareParking,
        onTap: () {
          Get.to(() => ParkingIns());
        },
      ),
      MenuItem(
        title: "Note",
        icon: FontAwesomeIcons.noteSticky,
        onTap: () {
        },
      ),
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
          Get.to(() => AttractionScreen());
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
          Get.to(() => LostScreen());
        },
      ),
      MenuItem(
        title: "Feedback",
        icon: FontAwesomeIcons.comment,
        onTap: () {
          Get.to(() => FeedbackScreen());
        },
      ),
      MenuItem(
        title: "Refer Friend",
        icon: FontAwesomeIcons.userGroup,
        onTap: () {
        },
      ),
    ];

    if (widget.bannerController.banners.isEmpty &&
        !widget.bannerController.isLoading.value) {
      widget.bannerController.fetchBanners();
    }

    if (widget.certificateController.certificateInfo.value == null &&
        !widget.certificateController.isLoadingInfo.value) {
      widget.certificateController.fetchCertificateInfo();
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _startSlideshow();
      }
    });
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

  Widget _buildHorizontalMenuItem(MenuItem item, BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: item.onTap ?? () {},
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: FaIcon(item.icon, color: Colors.red, size: 26),
              ),
              const SizedBox(height: 6),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[800],
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

  Widget _buildQuickLinksCard() {
    List<Widget> linkWidgets = [];
    for (int i = 0; i < _quickLinks.length; i++) {
      linkWidgets.add(
        ListTile(
          leading: FaIcon(_quickLinks[i].icon, color: Colors.red, size: 22),
          title: Text(
            _quickLinks[i].title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Colors.grey.shade400,
          ),
          onTap: _quickLinks[i].onTap,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 6,
          ),
          dense: true,
        ),
      );
      if (i < _quickLinks.length - 1) {
        linkWidgets.add(
          const Divider(
            height: 0,
            thickness: 1,
            indent: 16,
            endIndent: 16,
            color: Color(0xFFF0F0F0),
          ),
        );
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(mainAxisSize: MainAxisSize.min, children: linkWidgets),
    );
  }

  Widget _buildAppBarAction(IconData icon, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: FaIcon(icon, color: Colors.orange.shade700, size: 20),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 1.0,
            floating: true,
            snap: false,
            title: Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Image.asset(
                'Assets/img/logo.jpg',
              ),
            ),
            centerTitle: false,
            actions: [
              _buildAppBarAction(FontAwesomeIcons.qrcode, () {}),
              _buildAppBarAction(FontAwesomeIcons.mapMarkerAlt, () {}),
              _buildAppBarAction(FontAwesomeIcons.globe, () {}),
              const SizedBox(width: 8),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Obx(() {
                if (widget.bannerController.isLoading.value &&
                    widget.bannerController.banners.isEmpty) {
                  return _buildBannerPlaceholder(
                    context,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.orange.shade700,
                      ),
                    ),
                  );
                } else if (widget.bannerController.errorMessage.value != null) {
                  return _buildBannerPlaceholder(
                    context,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.bannerController.errorMessage.value!,
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    color: Colors.red.withOpacity(0.1),
                  );
                } else if (widget.bannerController.banners.isNotEmpty) {
                  final currentBanner =
                      widget.bannerController.banners[_currentBannerIndex];
                  return SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.28,
                    child:
                        currentBanner.imagePath != null &&
                                currentBanner.imagePath!.isNotEmpty
                            ? Image.network(
                              currentBanner.imagePath!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              loadingBuilder: (
                                context,
                                child,
                                loadingProgress,
                              ) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.orange.shade700,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return _buildBannerPlaceholder(
                                  context,
                                  child: const Center(
                                    child: Icon(
                                      Icons.broken_image_outlined,
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
                                child: Text(
                                  'Image not available',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                  );
                } else {
                  return _buildBannerPlaceholder(
                    context,
                    child: const Center(
                      child: Text(
                        'No banners available.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }
              }),
              Transform.translate(
                offset: Offset(0, -_horizontalMenuHeight / 2.2),
                child: Container(
                  height: _horizontalMenuHeight,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 0,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:
                        _horizontalMenuItems
                            .map(
                              (item) => _buildHorizontalMenuItem(item, context),
                            )
                            .toList(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 16.0,
                  top: 0,
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
              _buildQuickLinksCard(),
              const SizedBox(height: 20),
            ]),
          ),
        ],
      ),
    );
  }
}
