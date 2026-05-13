import 'package:flutter/material.dart';

class SuggestedActivitiesScreen2 extends StatelessWidget {
  final int stressLevel;

  const SuggestedActivitiesScreen2({Key? key, required this.stressLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> suggestions = [
      'Take a short break and breathe deeply 🌬️',
      'Go for a casual walk 🚶',
      'Watch a calming video or nature scene 🌅',
      'Drink a cup of herbal tea 🍵',
      'Organize your workspace or room 🧹',
      'Write down how you’re feeling 📝',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Suggested Activities'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You’re feeling neutral with a bit of stress. These might help:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...suggestions.map((activity) => Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.self_improvement,
                        color: Colors.blueGrey),
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
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
