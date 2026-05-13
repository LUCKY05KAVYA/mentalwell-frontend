import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add data to Firestore
  Future<void> addUser(String name, String email) async {
    await _db.collection('users').add({
      'name': name,
      'email': email,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Fetch data from Firestore
  Stream<QuerySnapshot> getUsers() {
    return _db
        .collection('users')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
