// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AppleLogin extends StatelessWidget {
  const AppleLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // عنوان الصفحة
              Text(
                "Sign in with Apple",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              // وصف قصير
              Text(
                "Use your Apple ID to sign in.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 20),

              // حقل إدخال Apple ID
              TextField(
                decoration: InputDecoration(
                  labelText: "Apple ID",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  suffixIcon: Icon(Icons.arrow_forward_ios), // أيقونة السهم
                ),
              ),
              SizedBox(height: 10),

              // رابط "Forgot Apple ID or password?"
              TextButton(
                onPressed: () {
                  // تنفيذ إعادة تعيين كلمة المرور
                },
                child: Text(
                  "Forgot Apple ID or password?",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(height: 20),

              // نص توضيحي حول إدارة البيانات
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "In setting up Sign in with Apple, information about your interactions with Apple and this device may be used by Apple to help prevent fraud. See how your data is managed.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
