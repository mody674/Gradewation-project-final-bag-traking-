// ignore_for_file: file_names

import 'package:flutter/material.dart';

class GoogleLogin extends StatelessWidget {
  const GoogleLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // // شعار Google
              // Image.asset(
              //   'assets/imgs/img2.png',
              //   width: 100,
              //   height: 50,
              // ),
              SizedBox(height: 20),

              // نص "Sign in"
              Text(
                "Sign in",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),

              // نص "with your Google Account"
              Text(
                "with your Google Account",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 20),

              // حقل البريد الإلكتروني أو رقم الهاتف
              _buildTextField(label: "Email or phone"),
              SizedBox(height: 10),

              // زر "Forgot email?"
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    // تنفيذ استرجاع البريد الإلكتروني
                  },
                  child: Text(
                    "Forgot email?",
                    style: TextStyle(color: Colors.blue, fontSize: 14),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // نص التوضيح "Not your computer? Use Guest mode..."
              Text(
                "Not your computer? Use Guest mode to sign in privately.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),

              // زر "Learn more"
              TextButton(
                onPressed: () {
                  // فتح صفحة "تعلم المزيد"
                },
                child: Text(
                  "Learn more",
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
              ),
              SizedBox(height: 20),

              // أزرار "Create account" و "Next"
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // الانتقال إلى صفحة إنشاء حساب
                    },
                    child: Text(
                      "Create account",
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // تنفيذ تسجيل الدخول
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    ),
                    child: Text(
                      "Next",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة لإنشاء حقل الإدخال
  Widget _buildTextField({required String label}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.black54),
        ),
      ),
    );
  }
}
