import 'package:flutter/material.dart';

class ChatMessageItem extends StatelessWidget {
  final Widget chatItem;

  const ChatMessageItem({required this.chatItem, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return chatItem;
  }
}