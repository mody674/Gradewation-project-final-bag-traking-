import 'package:bag_tracking/pages/newpassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Resedcode(),
    );
  }
}

class Resedcode extends StatefulWidget {
  const Resedcode({super.key});

  @override
  State<Resedcode> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<Resedcode> {
  final _formKey = GlobalKey<FormState>(); // مفتاح التحقق من صحة الإدخال
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes =
      List.generate(4, (index) => FocusNode()); // إدارة التركيز على الحقول

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNodes[0]); // تركيز المؤشر على أول حقل تلقائيًا
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _verifyCode() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  Newpassword()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Verify",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                "Please enter the code we sent to",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 5),
              const Text(
                "lauran****@email.com",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              /// **مربعات إدخال رمز التحقق**
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 22),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 1,
                      decoration: const InputDecoration(
                        counterText: "",
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ""; // إخفاء رسالة الخطأ فقط
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                        }
                      },
                      onTap: () {
                        _controllers[index].selection =
                            TextSelection.fromPosition(TextPosition(offset: _controllers[index].text.length));
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 10),
              const Text(
                "Didn't Receive the Code?",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              TextButton(
                onPressed: () {
                  // وظيفة إعادة إرسال الكود
                },
                child: const Text(
                  "Resend Code",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              /// **شريط التقدم**
              LinearProgressIndicator(
                value: 0.5,
                backgroundColor: Colors.grey[300],
                color: Colors.black,
              ),
              const SizedBox(height: 20),

              /// **زر التحقق**
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _verifyCode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    "Verify",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
