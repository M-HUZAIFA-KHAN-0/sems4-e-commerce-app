import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<ChatMessage> messages = [
    ChatMessage(
      message: "Hello! How can we assist you today?",
      isUser: false,
      time: "12:00 PM",
    ),
    ChatMessage(
      message: "Hi, I have a query regarding my complaint.",
      isUser: true,
      time: "12:01 PM",
    ),
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      messages.add(
        ChatMessage(
          message: _messageController.text.trim(),
          isUser: true,
          time: _formatCurrentTime(),
        ),
      );
    });

    _messageController.clear();

    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });

    // Simulate support reply after 1 sec
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        messages.add(
          ChatMessage(
            message: "Thanks for reaching out! We'll check and get back to you.",
            isUser: false,
            time: _formatCurrentTime(),
          ),
        );
      });
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    });
  }

  String _formatCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? "PM" : "AM";
    return "$hour:$minute $period";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 20,
          ),
        ),
        title: const Text(
          'Customer Support',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return Align(
                  alignment:
                      msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      crossAxisAlignment: msg.isUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth:
                                MediaQuery.of(context).size.width * 0.7,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: msg.isUser
                                ? Colors.blue[400]
                                : Colors.grey[300],
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(12),
                              topRight: const Radius.circular(12),
                              bottomLeft: Radius.circular(
                                  msg.isUser ? 12 : 0),
                              bottomRight: Radius.circular(
                                  msg.isUser ? 0 : 12),
                            ),
                          ),
                          child: Text(
                            msg.message,
                            style: TextStyle(
                              color: msg.isUser ? Colors.white : Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          msg.time,
                          style: const TextStyle(
                              fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Input box
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[400],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String message;
  final bool isUser;
  final String time;

  ChatMessage({
    required this.message,
    required this.isUser,
    required this.time,
  });
}
