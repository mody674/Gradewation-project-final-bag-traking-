import 'package:bag_tracking/pages/splach_screen%20.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bag_tracking/pages/appleLogin.dart';
import 'package:bag_tracking/pages/choosefile.dart';
import 'package:bag_tracking/pages/facebookLogin.dart';
import 'package:bag_tracking/pages/googleLogin.dart';
import 'package:bag_tracking/pages/welback.dart';
import 'package:bag_tracking/pages/creat.dart';
import 'package:bag_tracking/pages/forgetpassw.dart';
import 'package:bag_tracking/pages/homepage.dart';
import 'package:bag_tracking/pages/newpassword.dart';
import 'package:bag_tracking/pages/resedcode.dart';
import 'package:bag_tracking/pages/singup.dart';
import 'package:bag_tracking/pages/splash_screen.dart';
 // Add this import for your splash screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/SplashScreen",
      routes: {
        "/SplashScreen": (context) => const SplashScreen (),
        "/Creat": (context) => Creat(),
        "/Singup": (context) => const Singup(),
        "/Welback": (context) => Welback(),
        "/GoogleLogin": (context) => const GoogleLogin(),
        "/FacebookLogin": (context) => FacebookLogin(),
        "/AppleLogin": (context) => AppleLogin(),
        "/forgetpassw": (context) => forgetpassw(),
        "/Resedcode": (context) => const Resedcode(),
        "/Homepage": (context) => const Homepage(),
        "/Choosefile": (context) => Choosefile(),
        "/Newpassword": (context) => Newpassword(),
        // "/Congratulations": (context) => Congratulations(),
      },
    );
  }
}
