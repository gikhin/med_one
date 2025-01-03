import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:med_one/res/appurl.dart';
import '../../../app_colors.dart';

class ChatbotScreen extends StatefulWidget {
  final String? medicineName; // Made nullable

  ChatbotScreen({this.medicineName}); // Optional parameter

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _messages = []; // List of messages to display

  Future<void> sendMessage(String message) async {
    final url = Uri.parse(AppUrl.chatbot);
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({"message": message});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          _messages.add({"message": message, "sender": "user"});

          _messages.add({"message": responseData['message'] ?? "No response", "sender": "bot"});
        });
      } else {
        setState(() {
          _messages.add({"message": "Error: ${response.statusCode}", "sender": "bot"});
        });
      }
    } catch (error) {
      setState(() {
        _messages.add({"message": "Failed to connect to the chatbot", "sender": "bot"});
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Automatically search for the medicine name if provided
    if (widget.medicineName != null && widget.medicineName!.isNotEmpty) {
      sendMessage(widget.medicineName!);
    } else {
      setState(() {
        _messages.add({"message": "How can I assist you today?", "sender": "bot"});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chatbot")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (ctx, index) {
                return _buildMessageBubble(
                  _messages[index]['message']!,
                  _messages[index]['sender']!,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      sendMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String message, String sender) {
    bool isUser = sender == "user";

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            color: isUser ? AppColors.primaryColor2 : Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          child: Text(
            message,
            style: TextStyle(
              color: isUser ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
