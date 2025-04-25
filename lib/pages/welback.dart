// ignore_for_file: library_private_types_in_public_api

import 'package:bag_tracking/pages/appleLogin.dart';
import 'package:bag_tracking/pages/facebookLogin.dart';
import 'package:bag_tracking/pages/forgetpassw.dart';
import 'package:bag_tracking/pages/googleLogin.dart';
import 'package:bag_tracking/pages/homepage.dart';
import 'package:bag_tracking/pages/singup.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Welback());
  }
}

class Welback extends StatefulWidget {
  const Welback({super.key});

  @override
  _WelbackState createState() => _WelbackState();
}

class _WelbackState extends State<Welback> {
  final _formKey = GlobalKey<FormState>(); // مفتاح النموذج للتحقق من المدخلات
  final TextEditingController bagIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey, // ربط النموذج بالتحقق
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text("Login to your current account!"),
              SizedBox(height: 20),
              Image.asset("assets/imgs/img3.png", height: 150),
              SizedBox(height: 20),

              // حقل Bag ID
              TextFormField(
                controller: bagIdController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // أرقام فقط
                  LengthLimitingTextInputFormatter(8), // بحد أقصى 8 أرقام
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Bag ID is required";
                  }
                  if (value.length > 8) {
                    return "Bag ID cannot exceed 8 digits";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Bag ID",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),

              // حقل Password
              TextFormField(
                controller: passwordController,
                obscureText: !_isPasswordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                  if (value.length > 10) {
                    return "Password cannot exceed 10 characters";
                  }
                  if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(value)) {
                    return "Password must contain letters and numbers";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => forgetpassw()),
                    );
                  },
                  child: Text("Forgot Password?"),
                ),
              ),
              SizedBox(height: 10),

              // زر LOGIN
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Homepage()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: Text("LOGIN"),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Singup()),
                  );
                },
                child: Text("New User? Join Now"),
              ),

              // أزرار تسجيل الدخول عبر المنصات الأخرى
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: SvgPicture.asset('assets/Icons/icons8-facebook.svg'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FacebookLogin()),
                      );
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset('assets/Icons/icons8-apple.svg'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AppleLogin()),
                      );
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset('assets/Icons/icons8-google.svg'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GoogleLogin()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
