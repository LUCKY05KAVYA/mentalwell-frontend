import 'package:flutter/material.dart';
import 'chat_screen.dart';

class FloatingChatbot extends StatelessWidget {
  const FloatingChatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatScreen()),
        );
      },
      backgroundColor: Colors.blue,
      child: Icon(Icons.chat),
    );
  }
}
