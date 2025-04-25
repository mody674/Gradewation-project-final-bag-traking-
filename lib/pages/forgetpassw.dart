// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:bag_tracking/main.dart';
import 'package:bag_tracking/pages/resedcode.dart';

// void main() {
//   runApp(const MyApp());
// }

class ForgetPassw extends StatelessWidget {
  const ForgetPassw({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    );
  }
}

class forgetpassw extends StatefulWidget {
  const forgetpassw({super.key});

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<forgetpassw> {
  bool isSmsSelected = false;
  bool isEmailSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            const Center(
              child: Column(
                children: [
                  Text(
                    "Forget password",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Enter your phone Number or Email to get verification code",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 20),
                  Image(image: AssetImage('assets/imgs/img3.png'), height: 150),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Center(
              child: Text(
                "Where would you like to receive a Verification Code ?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  isSmsSelected = true;
                  isEmailSelected = false;
                });
              },
              child: _buildOptionCard(Icons.sms, "via SMS", "+1 123********99", isSelected: isSmsSelected),
            ),
            const SizedBox(height: 10),
            const Center(child: Text("_____________________ OR _____________________")),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() {
                  isSmsSelected = false;
                  isEmailSelected = true;
                });
              },
              child: _buildOptionCard(Icons.email, "via Email", "lauran****@email.com", isSelected: isEmailSelected),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Resedcode()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(IconData icon, String title, String subtitle, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: isSelected ? Colors.red : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: isSelected ? null : Border.all(color: Colors.black, width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: isSelected ? Colors.white : Colors.black, size: 30),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Colors.white70 : Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
