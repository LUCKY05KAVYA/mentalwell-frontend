import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunitySupportScreen extends StatefulWidget {
  const CommunitySupportScreen({super.key});

  @override
  _CommunitySupportScreenState createState() => _CommunitySupportScreenState();
}

class _CommunitySupportScreenState extends State<CommunitySupportScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> messages = [
    {
      "user": "Alice",
      "message": "Feeling a bit anxious today. Any tips?",
      "reactions": 5,
      "replies": 2,
    },
    {
      "user": "Bob",
      "message": "Started meditation last week, it helps a lot!",
      "reactions": 8,
      "replies": 3,
    },
    {
      "user": "Charlie",
      "message": "Remember to take deep breaths. It really helps!",
      "reactions": 3,
      "replies": 1,
    },
    {
      "user": "David",
      "message": "Anyone else struggling with sleep issues?",
      "reactions": 6,
      "replies": 4,
    },
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        messages.insert(0, {
          "user": "You",
          "message": _messageController.text.trim(),
          "reactions": 0,
          "replies": 0,
        });
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Community Support",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // Latest messages at the bottom
              padding: EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return _buildMessageTile(message);
              },
            ),
          ),

          // 📌 Message Input Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 2,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 📌 Chat Message Tile
  Widget _buildMessageTile(Map<String, dynamic> message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message["user"],
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 4),
            Text(
              message["message"],
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
            ),
            SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.favorite, color: Colors.red, size: 16),
                SizedBox(width: 4),
                Text(
                  "${message['reactions']}",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(width: 12),
                Icon(Icons.comment, color: Colors.blue, size: 16),
                SizedBox(width: 4),
                Text(
                  "${message['replies']} Replies",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
