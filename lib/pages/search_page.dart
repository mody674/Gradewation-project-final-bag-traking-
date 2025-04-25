
import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _bagIdController = TextEditingController();
  final Color customRed = const Color(0xFF960912);

  // بيانات الحقيبة
  String timestamp = '';
  String location = '';
  String lat = '';
  String lng = '';
  String battery = '';
  String ownerName = '';
  String ownerEmail = '';

  bool isLoading = false;
  String errorMessage = '';
  bool showDetails = false;

  void _searchBag() async {
    final bagId = _bagIdController.text.trim();
    if (bagId.isEmpty) return;

    setState(() {
      isLoading = true;
      errorMessage = '';
      showDetails = false;
    });

    // محاكاة API مؤقتة (عند إدخال 100 فقط)
    await Future.delayed(const Duration(seconds: 1));

    if (bagId == "100") {
      setState(() {
        timestamp = 'Monday, 28 May 2025 - 00:45:15 pm';
        location = 'Egypt, mountains';
        lat = '31°12\'44"';
        lng = '30°22\'29"';
        battery = 'S1x';
        ownerName = 'Senior Emotion';
        ownerEmail = 'OwnerEmotion2018@gmail.com';
        showDetails = true;
      });
    } else {
      setState(() {
        errorMessage = 'Bag not found. Try ID: 100';
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bag Details"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // حقل البحث الأسود
            TextField(
              controller: _bagIdController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter your bag id here",
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: _searchBag,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // مؤشر التحميل
            if (isLoading) const CircularProgressIndicator(),

            // رسالة الخطأ
            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),

            // تفاصيل الحقيبة
            if (showDetails && !isLoading)
              Expanded(
                child: ListView(
                  children: [
                    DetailRow(label: "Timestamp", value: timestamp),
                    DetailRow(label: "Location", value: location),
                    DetailRow(label: "Latitude", value: lat),
                    DetailRow(label: "Longitude", value: lng),
                    DetailRow(label: "Battery Status", value: battery),
                    DetailRow(label: "Bag Owner Name", value: ownerName),
                    DetailRow(label: "Bag Owner Email", value: ownerEmail),

                    // الزر الأحمر الكبير للعودة للصفحة الرئيسية
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: customRed, // تغيير اللون هنا فقط
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "DONE",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const Divider(height: 20, thickness: 1),
        ],
      ),
    );
  }
}
