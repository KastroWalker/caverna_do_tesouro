import 'package:flutter/material.dart';

import '../models/chat_message.dart';
import '../widgets/message_input.dart';
import '../widgets/messages_list.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageList = <ChatMessage>[];
  final _controllerText = TextEditingController();

  void _addMessage(String text, ChatMessageType type) {
    ChatMessage message = ChatMessage(type, text);
    ChatMessage received = ChatMessage(ChatMessageType.received, text);

    setState(() {
      _messageList.insert(0, message);
      _messageList.insert(0, received);
    });
  }

  void _sendMessage(String text) {
    _controllerText.clear();
    _addMessage(text, ChatMessageType.sent);
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



