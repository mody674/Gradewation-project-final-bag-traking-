import 'package:flutter/material.dart';
import 'creat.dart'; // Make sure you have this file created

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bag Tracking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate after 1500ms
    Future.delayed(const Duration(milliseconds: 6000), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const Creat()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

                 // الصورة مع تحكم بالحجم
            Image.asset(
              'assets/imgs/img1.png',
              width: 500,
              height: 350,
              fit: BoxFit.contain,
            ),

            // الكلام مباشرة تحت الصورة
            Text(
              'BAG TRACKING',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 1, 3, 6),
              ),
            ),
            // // Replaced icon with your image
            // Image.asset(
            //     'assets/imgs/img1.png',
            //   // Make sure this path is correct
            //   width: 500, // Adjust width as needed
            //   height: 400, // Adjust height as needed
            // ),
            // // const SizedBox(height: 7),
            // Text(
            //   'BAG TRACKING',
            //   style: TextStyle(
            //     fontSize: 24,
            //     fontWeight: FontWeight.bold,
            //     color: const Color.fromARGB(255, 1, 3, 6),
            //   ),
            // ),
            const SizedBox(height: 10),
            const Text(
              'Your Bag Is Safe with us',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 244, 67, 54),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
