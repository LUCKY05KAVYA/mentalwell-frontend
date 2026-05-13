import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'floating_chatbot.dart';
import 'notification_screen.dart';
import 'settings_screen.dart';
import 'community_support_screen.dart';
import 'therapy_screen.dart';
import 'homescreen.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreen2> {
  int _selectedIndex = 0;
  bool _isAssessmentCompleted = false;
  List<String> _motivationalLines = [];
  List<String> _questions = [];
  Map<int, String> _responses = {}; // To store the answers

  @override
  void initState() {
    super.initState();
    _questions = [
      "How are you feeling today?",
      "Are you feeling stressed or anxious?",
      "Do you feel motivated to achieve your goals?",
      "Have you been able to maintain a healthy routine?",
      "Are you getting enough sleep?",
      "Do you feel like you're supported by your friends or family?",
      "Have you faced any challenges in the past week?",
      "Do you practice mindfulness or meditation?",
      "Have you noticed any changes in your mood recently?",
      "What is one thing you're grateful for today?"
    ];
  }

  void _submitAssessment() {
    // Generate some motivational lines after submitting the assessment
    setState(() {
      _motivationalLines = [
        "You are stronger than you think!",
        "Believe in yourself, you've got this!",
        "Every day is a new opportunity to grow.",
        "Keep moving forward, no matter the pace."
      ];
      _isAssessmentCompleted = true;
    });
  }

  void _handleResponse(int index, String value) {
    setState(() {
      _responses[index] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Home", style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeIn(
              duration: Duration(milliseconds: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back, User! 👋",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Your journey to better mental health starts today!",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            buildSectionTitle("📌 Personalized Recommendations"),
            buildFullTile(
              icon: Icons.lightbulb,
              title: "Try a 5-minute breathing exercise",
              subtitle: "Improve focus and relaxation",
              color: Colors.blue,
            ),
            buildFullTile(
              icon: Icons.self_improvement,
              title: "Explore guided meditation",
              subtitle: "Reduce stress and anxiety",
              color: Colors.green,
            ),
            buildSectionTitle("📝 Self-Assessment"),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isAssessmentCompleted = false; // Reset if re-tapping
                });
              },
              child: buildFullTile(
                icon: Icons.assessment,
                title: "Take a self-assessment test",
                subtitle: "Understand your emotional state",
                color: Colors.teal,
              ),
            ),
            _isAssessmentCompleted
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "🌟 Motivational Lines",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      ..._motivationalLines.map(
                        (line) => Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Text(
                            line,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: _questions.asMap().entries.map((entry) {
                      int index = entry.key;
                      String question = entry.value;
                      return Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            TextField(
                              onChanged: (value) {
                                _handleResponse(index, value);
                              },
                              decoration: InputDecoration(
                                hintText: "Your answer...",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
            if (!_isAssessmentCompleted) SizedBox(height: 20),
            if (!_isAssessmentCompleted)
              ElevatedButton(
                onPressed: _submitAssessment,
                child: Text("Submit"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                  textStyle: GoogleFonts.poppins(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingChatbot(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Navigate to different screens based on selected index
          if (index == 0) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => HomeScreen2()));
          } else if (index == 1) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CommunitySupportScreen()));
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TherapyScreen()));
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Therapy',
          ),
        ],
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildFullTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return FadeInLeft(
      duration: Duration(milliseconds: 500),
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.white),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white70,
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
