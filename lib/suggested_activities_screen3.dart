import 'package:flutter/material.dart';

class SuggestedActivitiesScreen3 extends StatelessWidget {
  final int stressLevel;

  const SuggestedActivitiesScreen3({Key? key, required this.stressLevel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> suggestions = [
      'Watch a feel-good movie or show 🎬',
      'Call or message someone you trust 📞',
      'Write down your feelings in a journal 📓',
      'Cuddle with a pet or a soft pillow 🐾',
      'Listen to soothing music 🎶',
      'Try some slow, deep breathing exercises 🌬️',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Suggested Activities'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You’re feeling sad and a bit stressed. Here are some comforting activities:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...suggestions.map((activity) => Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.favorite_border,
                        color: Colors.deepPurple),
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
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple),
              ),
            )
          ],
        ),
      ),
    );
  }
}
