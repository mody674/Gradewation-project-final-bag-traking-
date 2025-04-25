import 'package:flutter/material.dart';

class PasswordChangePage extends StatelessWidget {
  const PasswordChangePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordTextController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        children: [
          _TextFieldCustom(
            // تم تغيير الاستدعاء هنا
            title: 'Password',
            controller: passwordTextController,
            isPassword: true, // إضافة خاصية كلمة المرور
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Password must:",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 19),
                ),
                SizedBox(height: 10),
                Text(
                  "• Consists of at least 8 letters",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 19),
                ),
                SizedBox(height: 5),
                Text(
                  "• Contains capital letter (A-Z)",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 19),
                ),
                SizedBox(height: 5),
                Text(
                  "• Contains lowercase letter (a-z)",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 19),
                ),
                SizedBox(height: 5),
                Text(
                  "• Contains the number (9-0)",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 19),
                ),
                SizedBox(height: 5),
                Text(
                  "• Contains a special character (!@#\$%^&*)",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 19),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ويدجيت TextFieldCustom المدمج
class _TextFieldCustom extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final TextInputType? inputType;
  final bool isPassword;

  const _TextFieldCustom({
    required this.title,
    required this.controller,
    // ignore: unused_element_parameter
    this.inputType,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            keyboardType: inputType,
            obscureText: isPassword, // إضافة خاصية إخفاء النص لكلمات المرور
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
