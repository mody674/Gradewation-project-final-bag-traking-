import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  final bool isTrackingOn;

  const NotificationsPage({super.key, required this.isTrackingOn});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<String> notifications = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isTrackingOn) {
      fetchNotifications();
    }
  }

  Future<void> fetchNotifications() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      notifications = [
        "The bag has been delivered to the site",
        "The bag was removed from the site",
        "Warning about changing the location of the bag",
        "Your bag has been locked",
      ];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // الخلفية مع تحسين الشفافية
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications,
                  size: 100,
                  color:
                      widget.isTrackingOn
                          // ignore: deprecated_member_use
                          ? const Color(0xFF960912).withOpacity(
                            0.50,
                          ) // زيادة الشفافية
                          // ignore: deprecated_member_use
                          : Colors.grey.withOpacity(0.2),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.isTrackingOn
                      ? "Tracking is ON"
                      : "Tracking is turned off",
                  style: TextStyle(
                    fontSize: 18,
                    color:
                        widget.isTrackingOn
                            // ignore: deprecated_member_use
                            ? const Color(0xFF960912).withOpacity(
                              0.9,
                            ) // زيادة الشفافية
                            // ignore: deprecated_member_use
                            : Colors.grey.withOpacity(0.5),
                  ),
                ),
                if (!widget.isTrackingOn) ...[
                  const SizedBox(height: 10),
                  const Text(
                    'There are no notifications',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ],
            ),
          ),

          // قائمة الإشعارات
          if (widget.isTrackingOn && !isLoading)
            ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color(0xFF960912),
                      width: 1.5, // زيادة سمك الحدود
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2, // إضافة ظل خفيف
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF960912),
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16, // زيادة حجم النص
                        ),
                      ),
                    ),
                    title: Text(
                      notifications[index],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: const Color(0xFF960912),
                      size: 28, // زيادة حجم الأيقونة
                    ),
                  ),
                );
              },
            ),

          if (isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
