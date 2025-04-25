import 'package:flutter/material.dart';

class ChangeLanguagePage extends StatefulWidget {
  const ChangeLanguagePage({super.key});

  @override
  State<ChangeLanguagePage> createState() => _ChangeLanguagePageState();
}

class _ChangeLanguagePageState extends State<ChangeLanguagePage> {
  String _selectedLanguage = 'english';

  final List<String> languages = ['Arabic', 'english'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("The language"), centerTitle: true),
      body: Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: languages.length,
          itemBuilder: (context, index) {
            String lang = languages[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedLanguage = lang;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF960912)),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(lang, style: TextStyle(fontSize: 16)),
                    if (_selectedLanguage == lang)
                      Icon(Icons.check, color: Color(0xFF960912)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
