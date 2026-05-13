import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mental_well/homescreen2.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'chat_screen.dart';
import 'suggested_activities_screen1.dart';
import 'suggested_activities_screen2.dart';
import 'suggested_activities_screen3.dart';
import 'supabase_client.dart';

final user = supabase.auth.currentUser;

class HomeScreen extends StatefulWidget {
  final String userName;
  final String userInfo;

  const HomeScreen({super.key, required this.userName, required this.userInfo});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _factsController = PageController();
  int _factsPage = 0;
  String userFeeling = '';
  String selectedMood = '';
  double stressLevel = 0.0;
  int selectedWeek = 0;
  List<String> _facts = [];

  List<double> weeklyStressLevels = List.filled(7, 0.0);
  List<String> weeklyMoods = List.filled(7, '');

  @override
  void initState() {
    super.initState();
    _fetchFacts();
    _fetchWeeklyMoodData();
  }

  Future<void> _startAutoSlide() async {
    if (_facts.isEmpty) return;
    Future.delayed(Duration(seconds: 4), () {
      if (!mounted || !_factsController.hasClients) return;
      _factsPage = (_factsPage + 1) % _facts.length;
      _factsController.animateToPage(
        _factsPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      _startAutoSlide();
    });
  }

  Future<void> _fetchFacts() async {
    final response =
        await Supabase.instance.client.from('facts').select('fact').limit(10);
    setState(() {
      _facts = List<String>.from(response.map((fact) => fact['fact']));
    });
    _startAutoSlide();
  }

  Future<void> _submitMood() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      print('User is null!');
    }
    if (selectedMood.isEmpty) {
      print('Mood is empty!');
    }

    try {
      await Supabase.instance.client.from('mood_logs').insert({
        'user_id': user?.id,
        'mood': selectedMood,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mood submitted!')),
      );
      // ✅ Navigate to the suggested activities screen based on the selected mood
      _navigateToSuggestedActivities(selectedMood);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving your mood: $e')),
      );
    }
  }

// Navigate to the suggested activities screen based on the selected mood
  void _navigateToSuggestedActivities(String mood) {
    switch (mood.toLowerCase()) {
      case 'happy':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuggestedActivitiesScreen1(
              stressLevel: 0,
            ), // For happy mood
          ),
        );
        break;
      case 'neutral':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuggestedActivitiesScreen2(
              stressLevel: 0,
            ), // For neutral mood
          ),
        );
        break;
      case 'sad':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SuggestedActivitiesScreen3(
              stressLevel: 0,
            ), // For sad mood
          ),
        );
        break;
      default:
        // Handle case if no mood is selected
        break;
    }
  }

  Future<void> _fetchWeeklyMoodData() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) return;

    DateTime now = DateTime.now();
    DateTime startOfWeek =
        now.subtract(Duration(days: now.weekday - 1 + selectedWeek * 7));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

    final response = await Supabase.instance.client
        .from('mood_logs')
        .select('timestamp, stress_level, mood')
        .eq('user_id', user.id)
        .gte('timestamp', startOfWeek.toIso8601String())
        .lte('timestamp', endOfWeek.toIso8601String());

    List<double> tempData = List.filled(7, 0.0);
    List<String> tempMoods = List.filled(7, '');
    List<int> counts = List.filled(7, 0);

    for (var entry in response) {
      DateTime entryTime = DateTime.parse(entry['timestamp']);
      int dayIndex = entryTime.weekday - 1;
      tempData[dayIndex] += (entry['stress_level'] ?? 0).toDouble();
      counts[dayIndex]++;
      tempMoods[dayIndex] = entry['mood'];
    }

    for (int i = 0; i < 7; i++) {
      if (counts[i] > 0) tempData[i] /= counts[i];
    }

    setState(() {
      weeklyStressLevels = tempData;
      weeklyMoods = tempMoods;
    });
  }

  String _emojiForMood(String mood) {
    switch (mood.toLowerCase()) {
      case 'happy':
        return '😄';
      case 'neutral':
        return '😐';
      case 'sad':
        return '😢';
      default:
        return '';
    }
  }

  Widget _weeklyMoodGraph() {
    final moodToY = {
      'sad': 0.0,
      'neutral': 1.0,
      'happy': 2.0,
    };

    final yToEmoji = {
      0.0: '😢',
      1.0: '😐',
      2.0: '😄',
    };

    // Dummy mood values (for the graph line)
    final dummyMoods = [
      'happy',
      'neutral',
      'sad',
      'happy',
      'neutral',
      'sad',
      'happy'
    ];

    return Container(
      height: 200,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(16),
      ),
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: 2,
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  const days = [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun'
                  ];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(days[value.toInt() % 7],
                        style: TextStyle(fontSize: 12)),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  return Text(
                    yToEmoji[value] ?? '',
                    style: TextStyle(fontSize: 18),
                  );
                },
                interval: 1,
                reservedSize: 32,
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: false),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              color: Colors.purple,
              barWidth: 3,
              belowBarData: BarAreaData(show: false),
              dotData: FlDotData(show: true),
              spots: List.generate(
                dummyMoods.length,
                (i) => FlSpot(i.toDouble(), moodToY[dummyMoods[i]]!),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _moodEmoji(String mood, String assetPath) {
    final isSelected = selectedMood == mood;
    return GestureDetector(
      onTap: () {
        setState(() => selectedMood = mood);
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.green : Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Lottie.asset(assetPath, height: 70, animate: true),
          ),
          if (isSelected) Icon(Icons.check_circle, color: Colors.green),
          Text(mood[0].toUpperCase() + mood.substring(1)),
        ],
      ),
    );
  }

  Widget _weekSwitchUI() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: selectedWeek > 0
              ? () {
                  setState(() => selectedWeek--);
                  _fetchWeeklyMoodData();
                }
              : null,
          icon: Icon(Icons.arrow_back),
        ),
        Text("Week ${selectedWeek + 1}", style: TextStyle(fontSize: 16)),
        IconButton(
          onPressed: () {
            setState(() => selectedWeek++);
            _fetchWeeklyMoodData();
          },
          icon: Icon(Icons.arrow_forward),
        ),
      ],
    );
  }

  Widget _factsCarousel() {
    if (_facts.isEmpty) {
      return Center(child: Text("Loading facts..."));
    }
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _factsController,
              itemCount: _facts.length,
              itemBuilder: (context, index) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _facts[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text("🧠 Fact of the Day",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Lottie.asset(
              'assets/home_bg_motion.json',
              fit: BoxFit.cover,
              repeat: true,
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome Back, ${widget.userName}! 👋',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("💡 Believe in yourself, you're stronger than you think.",
                    style:
                        TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                Text("Your mental well-being matters. Let's check in!",
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 20),
                Text("How are you feeling now?",
                    style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _moodEmoji('happy', 'assets/happy.json'),
                    _moodEmoji('neutral', 'assets/neutral.json'),
                    _moodEmoji('sad', 'assets/sad.json'),
                  ],
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Write about your feeling (optional)',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      userFeeling = value;
                    });
                  },
                ),
                SizedBox(height: 10),
                Slider(
                  min: 0,
                  max: 10,
                  divisions: 10,
                  label: 'Stress Level: ${stressLevel.toStringAsFixed(1)}',
                  value: stressLevel,
                  onChanged: (value) {
                    setState(() {
                      stressLevel = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitMood,
                  child: Text("Submit Mood & Stress Level"),
                ),
                SizedBox(height: 30),
                _weekSwitchUI(),
                SizedBox(height: 20),
                _weeklyMoodGraph(),
                SizedBox(height: 20),
                _factsCarousel(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ChatScreen(), // navigate to ChatScreen
                          ),
                        );
                      },
                      icon: Icon(Icons.chat),
                      label: Text("Chat"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HomeScreen2(), // navigate to HomeScreen2
                          ),
                        );
                      },
                      icon: Icon(Icons.home),
                      label: Text("More"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
