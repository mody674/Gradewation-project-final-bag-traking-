// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, deprecated_member_use

import 'package:bag_tracking/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart';

class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<Singup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController bagIdController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  File? _image;
  bool _obscurePassword = true;
  String? selectedGovernorate;

  // قائمة المحافظات
  final List<String> governorates = [
    "القاهرة", "الإسكندرية", "أسوان", "أسيوط", "الأقصر",
    "الشرقية", "الغربية", "الدقهلية", "دمياط", "سوهاج",
    "الإسماعيلية"
  ];

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Text("Create Account", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text("Let's create your account to become a member with us", style: TextStyle(fontSize: 14, color: Colors.grey)),
              SizedBox(height: 20),
              Image.asset(
                'assets/imgs/img11.png', // Updated image path
                width: 100,
                height: 100,
              ),
              SizedBox(height: 20),

              _buildTextField("Bag ID", bagIdController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(8),
                  ],
                  keyboardType: TextInputType.number,
                  isRequired: true),

              _buildTextField("Bag Owner Name", ownerNameController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]+$')),
                  ],
                  isRequired: true),

              _buildTextField("Password", passwordController,
                  isPassword: true,
                  isRequired: true,
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  )),

              _buildTextField("Owner Phone", phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  isRequired: true),

              _buildTextField("Owner Email", emailController,
                  keyboardType: TextInputType.emailAddress,
                  isRequired: true),
              SizedBox(height: 10),

              Align(alignment: Alignment.centerLeft, child: Text("Image", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text("Choose File"),
                  ),
                  SizedBox(width: 10),
                  _image == null ? Text("No file chosen") : Text("Image selected"),
                ],
              ),

              SizedBox(height: 10),
              Align(alignment: Alignment.centerLeft, child: Text("Location", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
              DropdownButtonFormField<String>(
                value: selectedGovernorate,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                ),
                hint: Text("اختر المحافظة"),
                items: governorates.map((String governorate) {
                  return DropdownMenuItem<String>(
                    value: governorate,
                    child: Text(governorate),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedGovernorate = newValue;
                    locationController.text = newValue ?? "";
                  });
                },
              ),

              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Homepage()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red, padding: EdgeInsets.symmetric(vertical: 15)),
                  child: Text("SIGN UP", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    Widget? suffixIcon,
    bool isRequired = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? _obscurePassword : false,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          suffixIcon: suffixIcon,
        ),
        validator: isRequired
            ? (value) {
                if (value == null || value.trim().isEmpty) {
                  return "$label مطلوب";
                }
                return null;
              }
            : null,
      ),
    );
  }
}
