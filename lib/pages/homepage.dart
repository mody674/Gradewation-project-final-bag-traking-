import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'search_page.dart';
import 'profile_page.dart';
import 'profile_page_photo.dart';
import 'lock_page.dart';
import 'notifications_page.dart';
import 'history_page.dart'; // تأكد من وجود هذا السطر

class Homepage extends StatefulWidget {
  // ignore: use_super_parameters
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  bool isTrackingOn = false;
  String trackingStatus = "Offline";
  final LatLng mansouraLocation = LatLng(31.0409, 31.3785);
  final LatLng egyptianInstituteLocation = LatLng(
    31.01631671777465,
    31.378688033307807,
  );
  final double initialZoom = 12.0;
  int _selectedIndex = 0;
  final double _defaultPanelPosition = 0.4;
  final double _expandedPanelPosition = 0.1;
  final MapController _mapController = MapController();
  final PanelController _panelController = PanelController();
  DateTime? _lastTap;
  int _tapCount = 0;
  final Color customRed = const Color(0xFF960912);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapController.move(mansouraLocation, initialZoom);
      _panelController.animatePanelToPosition(
        _defaultPanelPosition,
        duration: Duration(milliseconds: 300),
      );
    });
  }

  void _handleMapTap(TapPosition tapPosition, LatLng point) {
    final now = DateTime.now();
    if (_lastTap == null ||
        now.difference(_lastTap!) > Duration(milliseconds: 300)) {
      _tapCount = 1;
    } else {
      _tapCount++;
    }
    _lastTap = now;

    if (_tapCount == 2) {
      _tapCount = 0;
    } else if (_tapCount == 1) {
      _mapController.move(
        point,
        (_mapController.camera.zoom + 1).clamp(5.0, 22.0),
      );
    }
  }

  void toggleTracking() {
    setState(() {
      isTrackingOn = !isTrackingOn;
      trackingStatus = isTrackingOn ? "Online" : "Offline";
    });

    if (isTrackingOn) {
      _panelController.animatePanelToPosition(_expandedPanelPosition);
      _mapController.move(egyptianInstituteLocation, 15.0);
    } else {
      _panelController.animatePanelToPosition(_defaultPanelPosition);
    }
  }

  void showOnMap() {
    final bounds = LatLngBounds.fromPoints([
      mansouraLocation,
      LatLng(31.1833, 31.2361),
      LatLng(30.8000, 31.0000),
      LatLng(30.5333, 31.9500),
      LatLng(31.0523, 31.6364),
      LatLng(31.0167, 31.0167),
    ]);

    _mapController.fitCamera(
      CameraFit.bounds(bounds: bounds, padding: EdgeInsets.all(50)),
    );
    _panelController.animatePanelToPosition(_expandedPanelPosition);
  }

  Future<void> launchURL() async {
    final Uri url = Uri.parse("https://www.maptiler.com/copyright");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _onItemTapped(int index) {
    final int previousIndex = _selectedIndex;
    setState(() {
      _selectedIndex = index;
    });

    final pages = [
      null,
      NotificationsPage(isTrackingOn: isTrackingOn),
      LockPage(),
      HistoryPage(
        isTrackingOn: isTrackingOn,
      ), // تأكد من استخدام HistoryPage وليس history
      ProfilePage(),
    ];

    if (index != 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => pages[index]!),
      ).then((_) {
        if (mounted) {
          setState(() {
            _selectedIndex = previousIndex;
          });
        }
      });
    }
  }

  Widget _panelContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 60,
              height: 6,
              margin: const EdgeInsets.only(bottom: 6, left: 10),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: const Color(0xFF960912).withOpacity(0.7),
                borderRadius: BorderRadius.circular(2.5),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Your Last Location",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Mansoura",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: showOnMap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF960912),
                            minimumSize: const Size(0, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Show on Map",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Tracking Status",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        trackingStatus,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isTrackingOn ? Colors.green : customRed,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: toggleTracking,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isTrackingOn ? Colors.green : Color(0xFF960912),
                            minimumSize: const Size(0, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            isTrackingOn ? "Turn off" : "Turn on",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your details for Bag",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _bagInfoField(
                  "Owner",
                  isTrackingOn ? "Dr/ Hanny Khalifa" : "---",
                ),
                _bagInfoField("Bag ID", isTrackingOn ? "100" : "---"),
                _bagInfoField(
                  "Lng",
                  isTrackingOn
                      ? egyptianInstituteLocation.longitude.toStringAsFixed(4)
                      : "---",
                ),
                _bagInfoField(
                  "Lat",
                  isTrackingOn
                      ? egyptianInstituteLocation.latitude.toStringAsFixed(4)
                      : "---",
                ),
                _bagInfoField("Location", isTrackingOn ? "MET" : "---"),
                _bagInfoField(
                  "Time Stamp",
                  isTrackingOn
                      ? "${DateTime.now().toLocal()}".split('.')[0]
                      : "---",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bagInfoField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white)),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: mansouraLocation,
                initialZoom: initialZoom,
                interactionOptions: const InteractionOptions(
                  flags: InteractiveFlag.all & ~InteractiveFlag.doubleTapZoom,
                ),
                onTap: _handleMapTap,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}",
                  userAgentPackageName: 'com.example.app',
                  maxZoom: 22,
                ),
                if (isTrackingOn)
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 60,
                        height: 60,
                        point: egyptianInstituteLocation,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF960912),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                // ignore: deprecated_member_use
                                color: Colors.black.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.work,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 10,
                left: 16,
                right: 0,
                bottom: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.search, size: 30),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchPage(),
                        ),
                      );
                    },
                  ),
                  const Text(
                    "Home",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfilePagePhoto(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: const AssetImage(
                          'assets/imgs/download.png',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SlidingUpPanel(
            controller: _panelController,
            minHeight: 120,
            maxHeight: 800,
            defaultPanelState: PanelState.CLOSED,
            panelSnapping: false,
            onPanelClosed: () {
              _panelController.animatePanelToPosition(_defaultPanelPosition);
            },
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            panelBuilder:
                (ScrollController sc) => SingleChildScrollView(
                  controller: sc,
                  physics: const ClampingScrollPhysics(),
                  child: _panelContent(),
                ),
          ),
          Positioned(
            right: 0,
            bottom: MediaQuery.of(context).size.height * 0.4 + 20,
            child: FloatingActionButton(
              mini: true,
              heroTag: "zoomControls",
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder:
                      (context) => Container(
                        height: 100,
                        child: Column(
                          children: [
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                _mapController.move(
                                  _mapController.camera.center,
                                  (_mapController.camera.zoom + 1).clamp(
                                    5.0,
                                    22.0,
                                  ),
                                );
                                Navigator.pop(context);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                _mapController.move(
                                  _mapController.camera.center,
                                  (_mapController.camera.zoom - 1).clamp(
                                    5.0,
                                    22.0,
                                  ),
                                );
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                );
              },
              child: const Icon(Icons.zoom_out_map),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
        selectedItemColor: const Color(0xFF960912),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notifications",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.lock), label: "Lock"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
