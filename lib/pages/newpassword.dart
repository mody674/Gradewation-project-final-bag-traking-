// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Newpassword extends StatefulWidget {
  @override
  _CreateNewPasswordScreenState createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<Newpassword> {
  final _formKey = GlobalKey<FormState>(); // مفتاح التحقق من صحة الإدخال
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  bool obscureText1 = true;
  bool obscureText2 = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      FocusScope.of(context).requestFocus(passwordFocusNode);
    });
  }

  void _showSuccessDialog() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.verified, size: 80, color: Colors.red),
                const SizedBox(height: 10),
                const Text(
                  "Congratulations!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Password Reset successful\nYou'll be redirected to the login screen now",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, "/Welback");
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create a New Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPasswordField(
                  "Enter new password", passwordController, true),
              const SizedBox(height: 15),
              _buildPasswordField(
                  "Confirm new password", confirmPasswordController, false),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showSuccessDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Center(
                  child: Text("Verify",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(
      String hintText, TextEditingController controller, bool isFirst) {
    return TextFormField(
      controller: controller,
      obscureText: isFirst ? obscureText1 : obscureText2,
      focusNode: isFirst ? passwordFocusNode : null,
      keyboardType: TextInputType.text,
      inputFormatters: [FilteringTextInputFormatter.singleLineFormatter],
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(isFirst
              ? (obscureText1 ? Icons.visibility_off : Icons.visibility)
              : (obscureText2 ? Icons.visibility_off : Icons.visibility)),
          onPressed: () {
            setState(() {
              if (isFirst) {
                obscureText1 = !obscureText1;
              } else {
                obscureText2 = !obscureText2;
              }
            });
          },
        ),
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This field is required";
        }
        if (!isFirst && value != passwordController.text) {
          return "Passwords do not match";
        }
        return null;
      },
    );
  }
}
