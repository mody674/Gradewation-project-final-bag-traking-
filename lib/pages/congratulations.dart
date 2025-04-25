// import 'package:flutter/material.dart';
// void main() {
//   runApp(MaterialApp(
//     home: Congratulations(),
//   ));
// }
// class Congratulations extends StatefulWidget {
//   const Congratulations({super.key});
//   @override
//   // ignore: library_private_types_in_public_api
//   _SuccessScreenState createState() => _SuccessScreenState();
// }
// class _SuccessScreenState extends State<Congratulations> {
//   @override
//   void initState() {
//     super.initState();
//     // الانتقال التلقائي بعد 3 ثوانٍ إلى شاشة تسجيل الدخول
//     Future.delayed(Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         // ignore: use_build_context_synchronously
//         context,
//         MaterialPageRoute(builder: (context) => Welcomeback()), 
//       );
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Container(
//           padding: EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 10,
//                 spreadRadius: 2,
//               ),
//             ],
//           ),
//           width: MediaQuery.of(context).size.width * 0.8,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(Icons.verified, size: 80, color: Colors.red), 
//               SizedBox(height: 20),
//               Text(
//                 "Congratulations!",
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 "Password Reset successful\nYou'll be redirected to the login screen now",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//               ),
//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// // شاشة تسجيل الدخول (مثال بسيط)
// class Welcomeback extends StatelessWidget {
//   const Welcomeback({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text("Login Screen", style: TextStyle(fontSize: 24)),
//       ),
//     );
//   }
// }
