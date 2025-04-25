
import 'dart:io';

import 'package:flutter/material.dart';
  import 'package:image_picker/image_picker.dart';


// ignore: use_key_in_widget_constructors
class Choosefile extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<Choosefile> {
  String? _image;
  // ignore: unused_field
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تحميل صورة"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // صورة المستخدم (أو صورة افتراضية)
            CircleAvatar(
              radius: 80,
              backgroundImage: (_image !=null)?File(_image!) as ImageProvider:AssetImage('assets/imgs/img1.jpg'),
              backgroundColor: Colors.grey.shade300,
              child: _image == null
                  ? Icon(Icons.person, size: 80, color: Colors.white)
                  : null,
            ),
            SizedBox(height: 20),

            // زر اختيار صورة من المعرض
            ElevatedButton.icon(
              onPressed: _pickImageFromGallery,
              icon: Icon(Icons.image),
              label: Text("اختر من المعرض"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 10),

            // زر التقاط صورة من الكاميرا
            ElevatedButton.icon(
              onPressed:_pickImageFromGallery ,
              icon: Icon(Icons.camera_alt),
              label: Text("التقاط صورة بالكاميرا"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 146, 62, 66),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
  _pickImageFromGallery() async {
    final imagepicked =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagepicked != null) {
      setState(() {
      _image= imagepicked.path;
      });
    }
  }
}

