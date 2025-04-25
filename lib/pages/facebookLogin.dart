// ignore_for_file: file_names

import 'package:flutter/material.dart';

class FacebookLogin extends StatelessWidget {
  const FacebookLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // شعار Facebook
              Text(
                "facebook",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),

              // نص "Log Into Facebook"
              Text(
                "Log Into Facebook",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // حقل البريد الإلكتروني أو رقم الهاتف
              _buildTextField(label: "Your Email or Phone Here"),
              SizedBox(height: 10),

              // حقل كلمة المرور مع أيقونة إظهار/إخفاء
              _buildPasswordField(label: "Your Password Here"),
              SizedBox(height: 20),

              // زر "Log In"
              ElevatedButton(
                onPressed: () {
                  // تنفيذ تسجيل الدخول
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  "Log In",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              SizedBox(height: 10),

              // زر "Forgot account?"
              TextButton(
                onPressed: () {
                  // تنفيذ استرجاع الحساب
                },
                child: Text(
                  "Forgot account?",
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
              ),

              // خط فاصل مع "or"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("or"),
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
              SizedBox(height: 10),

              // زر "Create new account"
              ElevatedButton(
                onPressed: () {
                  // الانتقال إلى صفحة إنشاء الحساب
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text(
                  "Create new account",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
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

  // دالة لإنشاء حقل كلمة المرور مع إظهار/إخفاء
  Widget _buildPasswordField({required String label}) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: Icon(Icons.visibility),
      ),
    );
  }
}
