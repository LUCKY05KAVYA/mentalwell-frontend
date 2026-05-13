import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';
import 'splash_screen.dart';
import 'supabase_client.dart';

final user = supabase.auth.currentUser;
void main(param0) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://pxmnuseazbkkhtrycbko.supabase.co', // ⬅️ replace this
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB4bW51c2VhemJra2h0cnljYmtvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ1MzcxMTgsImV4cCI6MjA2MDExMzExOH0.S3kycHRyEz1M8ZAKUJJhJFDkNr-Eyur2FqIvqaOpP-s', // ⬅️ replace this
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
