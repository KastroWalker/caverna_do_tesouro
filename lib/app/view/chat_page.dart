import 'package:caverna_do_tesouro/app/domain/entities/answer.dart';
import 'package:caverna_do_tesouro/app/domain/exceptions/invalid_message.dart';
import 'package:caverna_do_tesouro/app/view/controllers/selection_controller.dart';
import 'package:caverna_do_tesouro/app/view/widgets/chat_message_item.dart';
import 'package:caverna_do_tesouro/app/view/widgets/chat_selection_message_item.dart';
import 'package:caverna_do_tesouro/app/view/widgets/chat_text_message_item.dart';
import 'package:flutter/material.dart';

import '../domain/bot/main.dart';
import '../domain/entities/chat_text_message.dart';
import 'widgets/message_input.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _chatBot = Bot();
  final _messageList = [];
  final _controllerText = TextEditingController();
  final _selectionController = SelectionController();

  _ChatPageState() {
    final initialMessage = _createTextMessage(
      ChatMessageType.bot,
      _chatBot.initialMessage().text,
    );
    _messageList.add(initialMessage);
  }

  ChatMessageItem _createTextMessage(ChatMessageType type, String text) {
    ChatTextMessage messageText = ChatTextMessage(type, text);
    ChatTextMessageItem messageTextItem = ChatTextMessageItem(messageText);
    ChatMessageItem messageItem = ChatMessageItem(chatItem: messageTextItem);

    return messageItem;
  }

  ChatMessageItem _createSelectionMessage(
    List<Map<String, String>> options,
    String title,
  ) {
    Widget chatSelectionMessageItem = AnimatedBuilder(
      animation: _selectionController,
      builder: (_, widget) {
        return ChatSelectionMessageItem(
          cardTitle: title,
          options: options,
          groupValue: _selectionController.group,
          onChanged: _selectionController.updateOptionSelected,
          onPressedButton: _onSelectedSelectionOption,
        );
      },
    );

    ChatMessageItem messageItem =
        ChatMessageItem(chatItem: chatSelectionMessageItem);

    return messageItem;
  }

  void _addMessage({
    required ChatMessageType type,
    Answer? answer,
    String? message,
  }) {
    late Widget messageItem;

    switch (type) {
      case ChatMessageType.user:
        if (message == null) {
          throw InvalidMessage('The user message should have a message!');
        }

        messageItem = _createTextMessage(type, message);
        break;
      case ChatMessageType.bot:
        if (answer == null) {
          throw InvalidMessage('The bot message should have a Answer Object!');
        }

        if (answer is TextAnswer) {
          messageItem = _createTextMessage(type, answer.text);
        } else if (answer is SelectionAnswer) {
          messageItem = _createSelectionMessage(answer.options, answer.title);
        }
        break;
    }

    setState(() {
      _messageList.insert(0, messageItem);
    });
  }

  void _sendMessage(String message) async {
    _controllerText.clear();
    _addMessage(type: ChatMessageType.user, message: message);
    var answer = await _chatBot.processMessage(message);
    _addMessage(type: ChatMessageType.bot, answer: answer);
  }

  // TODO move to a controller
  void _onSelectedSelectionOption() {
    _sendMessage(_selectionController.group);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Deninho Trader'),
      ),
      body: Column(children: [
        Flexible(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            reverse: true,
            itemBuilder: (_, int index) => _messageList[index],
            itemCount: _messageList.length,
          ),
        ),
        const Divider(height: 1.0),
        MessageInput(_controllerText, _sendMessage),
      ]),
    );
  }
}
