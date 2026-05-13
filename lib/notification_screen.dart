import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'floating_chatbot.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Keep it consistent
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true, // Show back button
      ),
      body: Center(
        child: Text(
          "No new notifications",
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingChatbot(),
    );
  }
}
