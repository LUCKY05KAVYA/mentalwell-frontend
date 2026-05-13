import 'dart:math';
// ignore: unused_import
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:animate_do/animate_do.dart';
// ignore: unused_import
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<String, String>> messages = [];
  bool isTyping = false;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FlutterTts flutterTts = FlutterTts();
  final stt.SpeechToText speechToText = stt.SpeechToText();
  bool isListening = false;
  bool isTtsEnabled = false;

  String? uploadedImagePath;
  List<String> allTags = [
    "Anxiety Tips",
    "Self-Care",
    "Sleep Tips",
    "Productivity Tips",
    "Healthy Eating",
    "Exercise Tips",
    "I'm feeling anxious",
    "Stress Management",
    "Work-Life Balance",
    "Improve Sleep",
    "Breathing Exercises",
    "Time Management",
  ];
  List<String> currentTags = [];

  void pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        messages.add({
          "text": "📄 PDF uploaded: ${result.files.single.name}",
          "sender": "user",
        });
      });
    }
  }

  void startListening() async {
    if (!isListening) {
      bool available = await speechToText.initialize();
      if (available) {
        setState(() => isListening = true);
        speechToText.listen(
          onResult: (result) {
            setState(() => _controller.text = result.recognizedWords);
          },
        );
      }
    } else {
      setState(() => isListening = false);
      speechToText.stop();
    }
  }

  @override
  void initState() {
    super.initState();
    _generateRandomTags();
    flutterTts.setLanguage("en-US");
    flutterTts.setSpeechRate(0.5);
    flutterTts.setVolume(1.0);
    flutterTts.setPitch(1.0);

    // ✅ Show Initial Message
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        messages.add({
          "text":
              "Hello! I'm your AI mental health assistant. How are you feeling today?",
          "sender": "bot",
        });
      });
    });
  }

  void _generateRandomTags() {
    Random random = Random();
    allTags.shuffle(random);
    int tagCount = random.nextInt(3) + 4; // Pick 4 to 6 tags
    currentTags = allTags.take(tagCount).toList();
    setState(() {});
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      messages.add({"text": text, "sender": "user"});
      isTyping = true;
    });

    _scrollToBottom();

    try {
      const String baseUrl = "https://mentalwell-backend.onrender.com";

      var request = http.MultipartRequest(
        "POST",
        Uri.parse("$baseUrl/chat/"),
      );

      request.fields["message"] = text;

      // ✅ Send Image if available
      if (uploadedImagePath != null) {
        request.files.add(
          await http.MultipartFile.fromPath("image", uploadedImagePath!),
        );
      }

      var response = await request.send();
      var responseData = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        final data = jsonDecode(responseData.body);
        String botReply = data["reply"] ?? "⚠️ AI did not generate a response.";

        setState(() {
          messages.add({"text": botReply, "sender": "bot"});
          isTyping = false;
          uploadedImagePath = null; // Reset image path after sending
        });

        _scrollToBottom();
      } else {
        throw Exception("⚠️ Server error, try again later.");
      }
    } catch (e) {
      setState(() {
        messages.add({
          "text": "⚠️ Error connecting to server.",
          "sender": "bot",
        });
        isTyping = false;
      });

      _scrollToBottom();
    }
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        uploadedImagePath = image.path; // Store path for sending
        messages.add({"text": "🖼️ Image uploaded", "sender": "user"});
      });
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("MentalWell Bot"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Lottie.asset("assets/bg_motion.json", fit: BoxFit.cover),
          ),
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.only(top: kToolbarHeight + 10),
                  itemCount: messages.length + (isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == messages.length && isTyping) {
                      return Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Lottie.asset("assets/loading.json"),
                        ),
                      );
                    }

                    bool isUser = messages[index]["sender"] == "user";
                    return FadeIn(
                      duration: Duration(milliseconds: 500),
                      child: Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 10,
                          ),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isUser
                                ? Colors.blue.shade700.withOpacity(0.8)
                                : Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            messages[index]["text"]!,
                            style: TextStyle(
                              fontSize: 16,
                              color: isUser ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // ✅ Tags Below Chat
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 6.0,
                  children: currentTags.map((tag) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent.withOpacity(0.8),
                      ),
                      onPressed: () => sendMessage(tag),
                      child: Text(
                        tag,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),
              ),

              // ✅ Chat Input
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.image, color: Colors.white),
                      onPressed: pickImage,
                    ),
                    // ✅ Attach File Button
                    IconButton(
                      icon: Icon(Icons.attach_file, color: Colors.white),
                      onPressed: pickPDF,
                    ),

                    // ✅ Microphone Button for Speech-to-Text
                    IconButton(
                      icon: Icon(
                        isListening ? Icons.mic : Icons.mic_none,
                        color: isListening ? Colors.red : Colors.white,
                      ),
                      onPressed: startListening,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: TextStyle(color: Colors.white),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: "Type or Speak...",
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send, color: Colors.white),
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          sendMessage(_controller.text);
                          _controller.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
