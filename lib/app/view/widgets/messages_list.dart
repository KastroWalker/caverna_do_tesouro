import 'package:flutter/material.dart';

import '../../domain/entities/chat_message.dart';
import 'chat_message_item.dart';

class MessagesList extends StatelessWidget {
  final List<ChatMessage> _messages;

  const MessagesList(this._messages, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        reverse: true,
        itemBuilder: (_, int index) => ChatMessageItem(_messages[index]),
        itemCount: _messages.length,
      ),
    );
  }
}