// File: lib/firebase_options.dart

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyBeWQU00kHtdZAgxYehl0npWOdTgiOh4qM",
    authDomain: "mentalwell-64a8b.firebaseapp.com",
    projectId: "mentalwell-64a8b",
    storageBucket: "mentalwell-64a8b.firebasestorage.app",
    messagingSenderId: "325281700567",
    appId: "1:325281700567:web:8ff17e5857dbc9ecc4ae92",
    measurementId: "G-YGL1668G83",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyBeWQU00kHtdZAgxYehl0npWOdTgiOh4qM",
    projectId: "mentalwell-64a8b",
    storageBucket: "mentalwell-64a8b.firebasestorage.app",
    messagingSenderId: "325281700567",
    appId: "1:325281700567:web:8ff17e5857dbc9ecc4ae92",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyBeWQU00kHtdZAgxYehl0npWOdTgiOh4qM",
    projectId: "mentalwell-64a8b",
    storageBucket: "mentalwell-64a8b.firebasestorage.app",
    messagingSenderId: "325281700567",
    appId: "1:325281700567:web:8ff17e5857dbc9ecc4ae92",
    iosBundleId:
        "com.example.mentalwell", // <-- Replace this with your actual iOS bundle ID
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "AIzaSyBeWQU00kHtdZAgxYehl0npWOdTgiOh4qM",
    projectId: "mentalwell-64a8b",
    storageBucket: "mentalwell-64a8b.firebasestorage.app",
    messagingSenderId: "325281700567",
    appId: "1:325281700567:web:8ff17e5857dbc9ecc4ae92",
    iosBundleId:
        "com.example.mentalwell", // <-- Replace this too if targeting macOS
  );
}
