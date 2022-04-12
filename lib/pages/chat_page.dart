import 'package:caverna_do_tesouro/chatbot/chatbot.dart';
import 'package:flutter/material.dart';

import '../models/chat_message.dart';
import '../widgets/message_input.dart';
import '../widgets/messages_list.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

enum CurrentActionType { none, accountCreation }

class _ChatPageState extends State<ChatPage> {
  final _chatBot = ChatBot();
  final _messageList = <ChatMessage>[];
  final _controllerText = TextEditingController();

  _ChatPageState() {
    _messageList
        .add(ChatMessage(ChatMessageType.received, _chatBot.initialMessage()));
  }

  void _addMessage(String text, ChatMessageType type) {
    ChatMessage message = ChatMessage(type, text);

    setState(() {
      _messageList.insert(0, message);
    });
  }

  void _sendMessage(String message) async {
    _controllerText.clear();
    _addMessage(message, ChatMessageType.sent);
    var answer = await _chatBot.processMessage(message);
    _addMessage(answer, ChatMessageType.received);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deninho Trader'),
      ),
      body: Column(children: [
        MessagesList(_messageList),
        const Divider(height: 1.0),
        MessageInput(_controllerText, _sendMessage),
      ]),
    );
  }
}



