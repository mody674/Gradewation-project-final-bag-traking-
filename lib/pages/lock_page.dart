
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'dart:convert';

// استيراد الصفحات المطلوبة
import 'homepage.dart';
import 'notifications_page.dart';
import 'history_page.dart';
import 'profile_page.dart';

class LockPage extends StatefulWidget {
  const LockPage({super.key});

  @override
  State<LockPage> createState() => _LockPageState();
}

class _LockPageState extends State<LockPage> {
  bool isLocked = false;
  bool isLoading = false;
  String? alertMessage;
  int _selectedIndex = 2; // Index for Lock page
  final Color customRed = const Color(0xFF960912);

  Future<void> toggleLock() async {
    setState(() {
      isLoading = true;
      alertMessage = null;
    });

    try {
      // محاكاة للـ API - سيتم استبدالها بالاتصال الحقيقي لاحقاً
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        isLocked = !isLocked;
        alertMessage =
            isLocked ? "Your Bag has been locked" : "Your Bag has been Open";
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        alertMessage = "Error: Unable to toggle lock.";
        isLoading = false;
      });
    }
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index;
    });

    // التنقل بين الصفحات باستخدام Navigator.push
    switch (index) {
      case 0: // Home
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
        break;
      case 1: // Notifications
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const NotificationsPage(isTrackingOn: false),
          ),
        );
        break;
      case 3: // History
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HistoryPage(isTrackingOn:true,)),
        );
        break;
      case 4: // Profile
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bag Lock"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // الرسالة العلوية
                if (alertMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Text(
                      alertMessage!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:
                            alertMessage!.contains("Error")
                                ? Colors.red
                                : (isLocked ? customRed : Colors.green),
                      ),
                    ),
                  ),

                // أيقونة القفل/الفتح
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: GestureDetector(
                    onTap: isLoading ? null : toggleLock,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isLocked ? customRed : Colors.green[800],
                        border: Border.all(
                          color: isLocked ? customRed : Colors.green,
                          width: 5,
                        ),
                      ),
                      child: Center(
                        child:
                            isLoading
                                ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                                : Icon(
                                  isLocked ? Icons.lock : Icons.lock_open,
                                  size: 80,
                                  color: Colors.white,
                                ),
                      ),
                    ),
                  ),
                ),

                // الأزرار
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.9,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading || isLocked ? null : toggleLock,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isLocked ? Colors.grey[600] : customRed,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Lock the bag",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading || !isLocked ? null : toggleLock,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isLocked ? Colors.green[800] : Colors.grey[600],
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Open the bag",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
        selectedItemColor: customRed,
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
