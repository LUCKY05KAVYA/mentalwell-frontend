import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TherapyScreen extends StatelessWidget {
  const TherapyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark Theme
      appBar: AppBar(
        title: Text("Therapy", style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📌 My Goal Section
            Text(
              "My Goal:",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),

            // ✅ Breathing Progress
            buildImageTile(
              "Total Breathing Time",
              "36 Min",
              "assets/breathing.jpg",
            ),
            // ✅ Yoga Progress
            buildImageTile("Total Yoga Time", "180 Min", "assets/yoga.jpg"),
            // ✅ Meditation Progress
            buildImageTile(
              "Total Meditation Time",
              "8 Min",
              "assets/meditation.jpg",
            ),
            SizedBox(height: 20),

            // 📌 Achievements Section
            Text(
              "Achievements:",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Complete at least one session of mindful breathing, calming meditation, or revitalizing yoga every single day to unlock new levels of inner peace and well-being. You can reduce stress and nurture a deeper connection with yourself.",
                style: GoogleFonts.poppins(color: Colors.white70),
              ),
            ),
            SizedBox(height: 20),

            // 📌 Recommended Meals Section
            Text(
              "Recommended Meals:",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildMealTile("Breakfast", "assets/breakfast.jpg"),
                buildMealTile("Lunch", "assets/lunch.jpg"),
                buildMealTile("Snack", "assets/snack.jpg"),
              ],
            ),
            SizedBox(height: 20),

            // 📌 What Should You Expect?
            buildExpectationCard(),

            SizedBox(height: 20),

            // 📌 My Streaks Section
            Text(
              "My Streaks:",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildStreakTile("Current Streak", "3 Days", Colors.pink),
                buildStreakTile("Longest Streak", "13 Days", Colors.amber),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Widget for Progress Tracking (Using Images)
  Widget buildImageTile(String title, String time, String imagePath) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(imagePath, height: 50), // Use Image instead of Lottie
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 5),
              Text(
                time,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ✅ Widget for Recommended Meals
  Widget buildMealTile(String mealType, String imagePath) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(mealType, style: GoogleFonts.poppins(color: Colors.white)),
      ],
    );
  }

  // ✅ Widget for "What Should You Expect?"
  Widget buildExpectationCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, color: Colors.white),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "End of Week 1: You will notice positive changes in your mood and energy levels.",
              style: GoogleFonts.poppins(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Widget for Streak Tiles
  Widget buildStreakTile(String title, String value, Color color) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
