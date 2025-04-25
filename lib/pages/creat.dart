// ignore: file_names
import 'package:bag_tracking/pages/congratulations.dart';
import 'package:bag_tracking/pages/singup.dart';
import 'package:bag_tracking/pages/welback.dart';
import 'package:flutter/material.dart';

class Creat extends StatelessWidget {
  const Creat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // شعار التطبيق
              Image.asset(
                'assets/imgs/img1.png',

                // استبدل بمسار صورتك
                width: 250,
                height: 250,
              ),
              SizedBox(height: 20),

              // اسم التطبيق
              Text(
                "BAG TRAKING",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins', // يمكنك تغيير الخط المناسب
                ),
              ),
              SizedBox(height: 40),

              // زر إنشاء حساب
              _buildButton(
                text: "Create an account",
                onPressed: () {
                  // انتقل إلى صفحة إنشاء الحساب
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Singup()),
                  );
                },
              ),
              SizedBox(height: 10),

              // زر تسجيل الدخول
              _buildButton(
                text: "Already a member?",
                onPressed: () {
                  // انتقل إلى صفحة إنشاء الحساب
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Welback()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة لإنشاء زر موحد
  Widget _buildButton({required String text, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        child: Text(text, style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }
}
