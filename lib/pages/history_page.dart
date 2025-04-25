import 'package:bag_tracking/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'lock_page.dart';
import 'notifications_page.dart';
import 'profile_page.dart';
import 'profile_page_photo.dart';
import 'search_page.dart';
// ignore: duplicate_import
import 'homepage.dart';

class HistoryPage extends StatefulWidget {
  final bool isTrackingOn;
  const HistoryPage({super.key, required this.isTrackingOn});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  final LatLng mansouraLocation = const LatLng(31.0409, 31.3785);
  final LatLng portSaidLocation = const LatLng(31.2653, 32.3019);
  final LatLng hurghadaLocation = const LatLng(27.2579, 33.8116);
  final double initialZoom = 12.0;
  final MapController _mapController = MapController();
  final PanelController _panelController = PanelController();
  int _selectedIndex = 3;
  final double _defaultPanelPosition = 0.4;
  final double _expandedPanelPosition = 0.1;
  DateTime? _lastTap;
  int _tapCount = 0;
  int _stepsCount = 0;
  final ScrollController _scrollController = ScrollController();
  // ignore: unused_field
  bool _showScrollToTopButton = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  LatLng? _selectedLocation;
  LatLng? _previousLocation;
  double? _distanceInKm;

  final List<LatLng> dummyLocations = [
    const LatLng(31.0409, 31.3785),
    const LatLng(31.2653, 32.3019),
    const LatLng(27.2579, 33.8116),
  ];

  final Map<String, int> locationSteps = {
    'Mansoura': 1250,
    'Port Said': 850,
    'Hurghada': 3200,
  };

  List<Map<String, String>> locations = [
    {'title': 'Start Location', 'value': 'Start Point'},
    {'title': 'End Location', 'value': 'End Point'},
    {'title': 'Time Stamp', 'value': 'In Transit'},
    {'title': 'Distance from last location', 'value': ''},
    {'title': 'Steps Count', 'value': '0'},
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scrollController.addListener(() {
      setState(() {
        _showScrollToTopButton = _scrollController.offset > 100;
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mapController.move(mansouraLocation, initialZoom);
      if (_panelController.isAttached) {
        _panelController.animatePanelToPosition(
          _defaultPanelPosition,
          duration: const Duration(milliseconds: 300),
        );
      }
      _updateTimeStamp();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _updateTimeStamp() {
    final now = DateTime.now();
    final timeString = '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
    setState(() {
      locations[2]['value'] = timeString;
    });
  }

  void _handleMapTap(TapPosition tapPosition, LatLng point) {
    final now = DateTime.now();
    if (_lastTap == null ||
        now.difference(_lastTap!) > const Duration(milliseconds: 300)) {
      _tapCount = 1;
    } else {
      _tapCount++;
    }
    _lastTap = now;

    if (_tapCount == 2) {
      _tapCount = 0;
      _mapController.move(
        point,
        (_mapController.camera.zoom + 1).clamp(5.0, 22.0),
      );
    } else if (_tapCount == 1) {
      _mapController.move(point, _mapController.camera.zoom);
    }
  }

  void showOnMap() {
    final bounds = LatLngBounds.fromPoints(dummyLocations);
    _mapController.fitCamera(
      CameraFit.bounds(bounds: bounds, padding: const EdgeInsets.all(50)),
    );
    if (_panelController.isAttached) {
      _panelController.animatePanelToPosition(_expandedPanelPosition);
    }
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
          (route) => false,
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    NotificationsPage(isTrackingOn: widget.isTrackingOn),
          ),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LockPage()),
        );
        break;
      case 3:
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
    }
  }

  Widget _buildLocationItem(String title, String value) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 6),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                widget.isTrackingOn ? value : '----',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (title == 'Distance from last location' &&
                  _distanceInKm != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    "${_distanceInKm!.toStringAsFixed(2)} km",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (title == 'Steps Count' && _stepsCount > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    "$_stepsCount steps",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showHistoryDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Select Location"),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: [
                  _buildDialogItem("Mansoura", Icons.location_on, 0),
                  const Divider(height: 1, thickness: 1),
                  _buildDialogItem("Port Said", Icons.flag, 1),
                  const Divider(height: 1, thickness: 1),
                  _buildDialogItem("Hurghada", Icons.location_city, 2),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildDialogItem(String title, IconData icon, int index) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF960912)),
      title: Text(title),
      onTap: () => _handleLocationSelection(index),
    );
  }

  void _handleLocationSelection(int index) {
    setState(() {
      if (_selectedLocation == null) {
        _selectedLocation = dummyLocations[index];
        locations[0]['value'] = _getLocationName(index);
        _stepsCount = locationSteps[_getLocationName(index)] ?? 0;
        locations[4]['value'] = _stepsCount.toString();
      } else {
        _previousLocation = _selectedLocation;
        _selectedLocation = dummyLocations[index];
        locations[1]['value'] = _getLocationName(index);

        final distance = Distance();
        _distanceInKm = distance.as(
          LengthUnit.Kilometer,
          _previousLocation!,
          _selectedLocation!,
        );

        _stepsCount = locationSteps[_getLocationName(index)] ?? 0;
        locations[4]['value'] = _stepsCount.toString();
      }
      _mapController.move(_selectedLocation!, 13.0);
      if (_panelController.isAttached) {
        _panelController.animatePanelToPosition(_defaultPanelPosition);
      }
    });
    _animationController.forward(from: 0.0);
    Navigator.pop(context);
  }

  String _getLocationName(int index) {
    switch (index) {
      case 0:
        return 'Mansoura';
      case 1:
        return 'Port Said';
      case 2:
        return 'Hurghada';
      default:
        return 'Location ${index + 1}';
    }
  }

  Widget _panelContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Center(
              child: Container(
                width: 60,
                height: 6,
                margin: const EdgeInsets.only(top: 8,left: 10,right: 10),
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
          ],
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 3000),
          child:
              _panelController.panelPosition == _expandedPanelPosition
                  ? Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Center(
                      child: Text(
                        "You're viewing detailed history",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                  : Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Center(
                      child: Text(
                        "Swipe up for details",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 13, top: 13),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  const Text(
                    "Tracking Status",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.isTrackingOn ? "Online" : "Offline",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: widget.isTrackingOn ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: showOnMap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF960912),
                        shadowColor: Color.fromARGB(255, 12, 12, 12),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Show Last Location",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.keyboard_arrow_up, size: 24),
                  color: const Color(0xFF960912),
                  onPressed: () {
                    if (_panelController.isAttached) {
                      _panelController.animatePanelToPosition(
                        _defaultPanelPosition,
                        duration: const Duration(milliseconds: 300),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Location Tracking",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...locations.map(
                    (location) => _buildLocationItem(
                      location['title']!,
                      location['value']!,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              locations[0]['value'] = 'Mansoura';
                              locations[1]['value'] = 'Hurghada';
                              _stepsCount = 3200;
                              locations[4]['value'] = _stepsCount.toString();
                              _updateTimeStamp();
                            });
                            _animationController.forward(from: 0.0);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF960912),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Refresh",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _showHistoryDialog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF960912),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Show History",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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
                  flags: InteractiveFlag.all,
                ),
                onTap: _handleMapTap,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}",
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 60,
                      height: 60,
                      point: _selectedLocation ?? mansouraLocation,
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
                if (_previousLocation != null && _selectedLocation != null)
                  PolylineLayer(
                    polylines: [
                      Polyline(
                        points: [_previousLocation!, _selectedLocation!],
                        color: Colors.blue,
                        strokeWidth: 4.0,
                      ),
                    ],
                  ),
              ],
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
                              icon: const Icon(Icons.add),
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
                              icon: const Icon(Icons.remove),
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
                    "Bag History",
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
            panelSnapping: true,
            snapPoint: 0.25,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            panelBuilder: (scrollController) => _panelContent(),
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