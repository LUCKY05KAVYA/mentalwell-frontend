import 'package:flutter/material.dart';
import 'homescreen.dart';

class QuestionScreen extends StatefulWidget {
  final int questionIndex;
  final String userName;
  final String userEmail;

  const QuestionScreen({
    super.key,
    required this.questionIndex,
    required this.userName,
    required this.userEmail,
  });

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _currentQuestionIndex = 0;
  List<String> _selectedAnswers = [];

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'How often have you felt overwhelmed in the past week?',
      'options': ['Never', 'Rarely', 'Sometimes', 'Often'],
    },
    {
      'question': 'How would you describe your mood today?',
      'options': ['Happy', 'Neutral', 'Sad', 'Anxious'],
    },
    {
      'question': 'How well did you sleep last night?',
      'options': ['Very well', 'Okay', 'Poorly', 'Did not sleep'],
    },
    {
      'question': 'Do you feel supported by people around you?',
      'options': ['Yes, always', 'Sometimes', 'Rarely', 'Not at all'],
    },
    {
      'question': 'How motivated do you feel to complete daily tasks?',
      'options': [
        'Very motivated',
        'Somewhat motivated',
        'Not very motivated',
        'Not at all'
      ],
    },
  ];

  void _nextQuestion(String selectedOption) {
    _selectedAnswers.add(selectedOption);

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      // All questions answered, navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomeScreen(
                  userName: '',
                  userInfo: '',
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: Text('Question ${_currentQuestionIndex + 1}')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question['question'],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            ...question['options'].map<Widget>((option) {
              return ListTile(
                title: Text(option),
                leading: Radio<String>(
                  value: option,
                  groupValue: _selectedAnswers.length > _currentQuestionIndex
                      ? _selectedAnswers[_currentQuestionIndex]
                      : null,
                  onChanged: (value) => _nextQuestion(option),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
