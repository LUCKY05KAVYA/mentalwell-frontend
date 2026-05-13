import 'package:flutter/material.dart';

class SuggestedActivitiesScreen1 extends StatelessWidget {
  final int
      stressLevel; // You can use this if you want to vary suggestions based on stress

  const SuggestedActivitiesScreen1({Key? key, required this.stressLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample suggestions – can be based on stressLevel if needed
    List<String> suggestions = [
      'Go for a relaxing walk 🏞️',
      'Listen to your favorite music 🎧',
      'Do some light stretching or yoga 🧘‍♂️',
      'Try a quick meditation session 🧘',
      'Talk to a friend 👥',
      'Write in a gratitude journal ✍️',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Suggested Activities'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You’re feeling happy, but a bit stressed. Here are some helpful activities:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...suggestions.map((activity) => Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.check_circle_outline,
                        color: Colors.green),
                    title: Text(activity),
                  ),
                )),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              ),
            )
          ],
        ),
      ),
    );
  }
}
