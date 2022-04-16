import 'package:flutter/cupertino.dart';

import '../../domain/bot/main.dart';
import '../widgets/chat_message_item.dart';

class SelectionController extends ChangeNotifier {
  final bot = Bot();
  final messages = <ChatMessageItem>[];
  final controllerText = TextEditingController();
  String group = '';

  void updateOptionSelected(value) {
    group = value;
    notifyListeners();
  }
}
