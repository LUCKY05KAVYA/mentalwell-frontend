import 'package:flutter/material.dart';
import 'firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreTestScreen extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  FirestoreTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firestore Test")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await _firebaseService.addUser("John Doe", "john@example.com");
            },
            child: Text("Add User"),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firebaseService.getUsers(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                var docs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var data = docs[index].data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['name']),
                      subtitle: Text(data['email']),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
