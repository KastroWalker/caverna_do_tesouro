import 'package:flutter/material.dart';

import '../../domain/entities/chat_message.dart';

class ChatMessageItem extends StatelessWidget {
  final ChatMessage chatMessage;

  const ChatMessageItem(this.chatMessage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return chatMessage.type == ChatMessageType.sent
        ? _showSentMessage()
        : _showReceivedMessage();
  }

  Widget _showSentMessage() {
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(64.0, 0.0, 8.0, 0.0),
      subtitle: Text(chatMessage.text, textAlign: TextAlign.right),
    );
  }

  Widget _showReceivedMessage() {
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(8.0, 0.0, 64.0, 0.0),
      subtitle: Text(chatMessage.text, textAlign: TextAlign.left),
    );
  }
}