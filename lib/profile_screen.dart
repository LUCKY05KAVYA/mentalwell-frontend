import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile'), backgroundColor: Colors.blue),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User details
            Text('Name: [User Name]', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Phone Number: [User Phone]', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),

            // Mood Graph (Placeholder)
            Container(
              height: 200,
              color: Colors.blue[100],
              child: Center(child: Text('Mood Graph Here')),
            ),
            SizedBox(height: 20),

            // Self-Assessed Results and Insights (Placeholder)
            Text(
              'Self-Assessed Results:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text('Insight: [Your Insight]', style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),

            // Logout Button
            ElevatedButton(
              onPressed: () {
                // Handle logout functionality
                print('Logout');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.blue,
              ),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
