import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Privacy Policy",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Privacy Policy for Bag Tracking App",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),

            Text(
              "Last Updated: [Update Date]",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            _buildParagraph(
              "The Bag Tracking app provides users with a luggage tracking service to enhance convenience and security while traveling. ",
            ),

            _buildHighlightedText(
              "We are committed to protecting your privacy, and this policy outlines how we collect, use, and share your personal data.",
            ),

            _buildParagraph(
              "When you use the Bag Tracking app, we may collect personal information such as your name, email address, and phone number during registration. Additionally, we gather device-related data, including your IP address, device type, operating system, and browser details. If you consent to location sharing, we collect geolocation data to enhance our tracking services. We also store trip-related information, such as bag numbers, travel details, and recorded bag locations.",
            ),

            _buildHighlightedText(
              "We use the collected data to provide efficient luggage tracking services, improve user experience, send real-time notifications regarding baggage status, respond to inquiries, and ensure legal compliance and security.",
            ),

            _buildParagraph(
              "Your personal data is not shared with third parties unless explicitly permitted by you, required by law, or necessary for operational support through trusted service providers such as cloud storage services. In cases of security or legal threats, data may be shared to protect our rights and those of our users.",
            ),

            _buildHighlightedText(
              "To safeguard your information, we implement strict security measures to prevent unauthorized access, data misuse, or leakage. However, given the nature of the internet, we cannot guarantee absolute security. As a user, you have the right to access, correct, or delete your personal data, withdraw consent for data processing, or request restrictions under specific circumstances.",
            ),

            _buildParagraph(
              "We may use cookies to enhance the user experience by collecting relevant data, but users can disable cookies through browser settings, which may impact certain app functionalities. Our privacy policy may be updated periodically, and we will notify users of significant changes via the app or email.",
            ),

            _buildHighlightedText(
              "If you have any questions or concerns regarding this privacy policy, you can contact us via email at [Support Email] or by phone at [Phone Number]. By using the Bag Tracking app, you agree to the terms outlined in this policy.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(text, style: TextStyle(fontSize: 14, color: Colors.black87)),
    );
  }

  Widget _buildHighlightedText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    );
  }
}
