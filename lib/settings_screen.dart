import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'floating_chatbot.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Keep it consistent
      appBar: AppBar(
        title: Text(
          "Settings",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true, // Show back button
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            leading: Icon(Icons.person, color: Colors.white),
            title: Text(
              "Account",
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            onTap: () {},
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.white),
            title: Text(
              "Notifications",
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            onTap: () {},
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.lock, color: Colors.white),
            title: Text(
              "Privacy & Security",
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            onTap: () {},
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.help, color: Colors.white),
            title: Text(
              "Help & Support",
              style: GoogleFonts.poppins(color: Colors.white),
            ),
            onTap: () {},
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text(
              "Logout",
              style: GoogleFonts.poppins(color: Colors.red),
            ),
            onTap: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingChatbot(),
    );
  }
}
