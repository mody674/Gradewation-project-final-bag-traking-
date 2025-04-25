import 'package:flutter/material.dart';
import 'change_language.dart';
import 'password_change.dart';
import 'welback.dart';
import 'creat.dart'; // تم إضافة استيراد صفحة Creat

class AccountSetting extends StatelessWidget {
  const AccountSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Account Settings",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            _buildSettingCard(
              context,
              icon: Icons.lock_outlined,
              title: "Change Password",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PasswordChangePage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildSettingCard(
              context,
              icon: Icons.language_outlined,
              title: "Language",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChangeLanguagePage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _buildSettingCard(
              context,
              icon: Icons.logout,
              title: "Log Out",
              isLogout: true,
              onTap: () => _showLogoutConfirmationDialog(context),
            ),
            const SizedBox(height: 12),
            _buildSettingCard(
              context,
              icon: Icons.delete_outline,
              title: "Delete Account",
              isDelete: true,
              onTap: () => _showDeleteConfirmationDialog(context),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    bool isDelete = false,
    bool isLogout = false,
    required VoidCallback onTap,
  }) {
    final Color iconColor =
        isDelete
            ? Colors.red
            : isLogout
            ? Colors.orange
            : Colors.black87;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200, width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(icon, color: iconColor, size: 24),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: iconColor,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: isDelete || isLogout ? iconColor : Colors.grey.shade600,
        ),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
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
                child: const Text(
                  "Log Out",
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ],
          ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Delete Account"),
            content: const Text(
              "Are you sure you want to delete your account? This action cannot be undone.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Account deleted successfully"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  // الانتقال إلى صفحة Creat بعد الحذف
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Creat()),
                  );
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }
}
