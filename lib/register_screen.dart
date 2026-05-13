// Updated RegisterScreen
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_screen.dart';
import 'fade_route.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now.subtract(Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFCCBC),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(Icons.person_add, size: 80, color: Colors.white),
              SizedBox(height: 20),
              Text(
                'Create Account',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 20),
              _buildTextField(_usernameController, 'Username *', Icons.person),
              SizedBox(height: 15),
              _buildTextField(
                  _emailController, 'Email (optional)', Icons.email),
              SizedBox(height: 15),
              _buildTextField(_passwordController, 'Password *', Icons.lock,
                  obscure: true),
              SizedBox(height: 15),
              _buildTextField(_confirmPasswordController, 'Confirm Password *',
                  Icons.lock_outline,
                  obscure: true),
              SizedBox(height: 15),
              InkWell(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    _selectedDate == null
                        ? "Select Date of Birth"
                        : "DOB: ${_selectedDate!.toLocal()}".split(' ')[0],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final username = _usernameController.text.trim();
                  final emailInput = _emailController.text.trim();
                  final password = _passwordController.text.trim();
                  final confirmPassword =
                      _confirmPasswordController.text.trim();

                  if (username.isEmpty ||
                      password.isEmpty ||
                      confirmPassword.isEmpty) {
                    _showSnack("Please fill all required fields.");
                    return;
                  }

                  if (password != confirmPassword) {
                    _showSnack("Passwords do not match.");
                    return;
                  }

                  if (_selectedDate == null) {
                    _showSnack("Please select your date of birth.");
                    return;
                  }

                  final emailToUse = emailInput.isNotEmpty
                      ? emailInput
                      : "$username@example.com";

                  try {
                    final userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailToUse, password: password);

                    await userCredential.user!.sendEmailVerification();

                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(userCredential.user!.uid)
                        .set({
                      'username': username,
                      'email': emailToUse,
                      'dob': _selectedDate!.toIso8601String(),
                      'uid': userCredential.user!.uid,
                    });

                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text("Success"),
                        content: Text(
                            "Registration successful! Verify your email before login."),
                        actions: [
                          TextButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context, FadeRoute(page: LoginScreen()));
                            },
                          )
                        ],
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'email-already-in-use') {
                      _showSnack("This email/username is already taken.");
                    } else {
                      _showSnack("Registration failed: ${e.message}");
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text("Register"),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, FadeRoute(page: LoginScreen()));
                },
                child: Text('Already have an account? Login',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
