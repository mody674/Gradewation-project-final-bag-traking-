import 'account_setting.dart';
import 'profile_page_photo.dart';
import 'personal_information.dart';
import 'privacy_policy_screen.dart';
import 'package:flutter/material.dart';
import 'welback.dart';
import 'creat.dart';
import 'support_page.dart'; // تمت إضافة استيراد صفحة الدعم

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Log Out"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Welback()),
                );
              },
              child: const Text("OK", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Account"),
          content: const Text(
            "Are you sure you want to delete your account? All data will be permanently lost.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Creat()),
                );
              },
              child: const Text("OK", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Widget buildCard({required Widget child, Color? color}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF7F7F7);
    final textColor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          'Account',
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ),
        centerTitle: true,
        backgroundColor: cardColor,
        elevation: 1,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePagePhoto(),
                ),
              );
            },
            child: buildCard(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(
                            "assets/imgs/download.png",
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Samir Elmahdy",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "samirelmahdy22@gmail.com",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "01030745856",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                buildCard(
                  color: cardColor,
                  child: ListTile(
                    leading: Icon(Icons.person, color: textColor),
                    title: Text(
                      "Personal information",
                      style: TextStyle(color: textColor),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.red,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PersonalInformation(),
                        ),
                      );
                    },
                  ),
                ),
                buildCard(
                  color: cardColor,
                  child: ListTile(
                    leading: Icon(Icons.settings, color: textColor),
                    title: Text(
                      "Account setting",
                      style: TextStyle(color: textColor),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.red,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccountSetting(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                buildCard(
                  color: cardColor,
                  child: ListTile(
                    leading: Icon(Icons.support_agent, color: textColor),
                    title: Text("Support", style: TextStyle(color: textColor)),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.red,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SupportPage(),
                        ),
                      );
                    },
                  ),
                ),
                buildCard(
                  color: cardColor,
                  child: ListTile(
                    leading: Icon(Icons.privacy_tip, color: textColor),
                    title: Text(
                      "Privacy Policy",
                      style: TextStyle(color: textColor),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.red,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PrivacyPolicyScreen(),
                        ),
                      );
                    },
                  ),
                ),
                buildCard(
                  color: cardColor,
                  child: ListTile(
                    leading: Icon(Icons.logout, color: textColor),
                    title: Text("Log out", style: TextStyle(color: textColor)),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.red,
                    ),
                    onTap: () => _showLogoutDialog(context),
                  ),
                ),
                buildCard(
                  color: cardColor,
                  child: ListTile(
                    leading: Icon(Icons.delete, color: textColor),
                    title: Text(
                      "Delete account",
                      style: TextStyle(color: textColor),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.red,
                    ),
                    onTap: () => _showDeleteAccountDialog(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
