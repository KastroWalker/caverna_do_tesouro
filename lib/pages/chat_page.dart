import 'package:caverna_do_tesouro/services/account_service.dart';
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
  final _messageList = <ChatMessage>[];
  final _controllerText = TextEditingController();

  // TODO refactor to read options from a List
  final _actionsOptions =
      """1 - Adicionar Conta Bancária\n2 - Adicionar Cartão de crédito""";
  late ChatMessage _initialMessage;
  CurrentActionType _currentAction = CurrentActionType.none;
  final _actions = [
    {"actionType": CurrentActionType.none, "initialMessage": ""},
    {
      "actionType": CurrentActionType.accountCreation,
      "initialMessage": "Qual o nome da conta?"
    },
  ];
  final _accountCreationData = {
    "name": "",
    "balance": "",
  };

  _ChatPageState() {
    _initialMessage = ChatMessage(ChatMessageType.received,
        """O que você deseja fazer?\n$_actionsOptions""");
    _messageList.add(_initialMessage);
  }

  void _addMessage(String text, ChatMessageType type) {
    ChatMessage message = ChatMessage(type, text);

    setState(() {
      _messageList.insert(0, message);
    });
  }

  void _updateCurrentAction(String message) {
    try {
      var action = _actions[int.parse(message)];
      _currentAction = action["actionType"] as CurrentActionType;
      var initialMessage = action["initialMessage"] as String;
      _addMessage(initialMessage, ChatMessageType.received);
    } catch (exception) {
      _addMessage(
        "Desculpa, não consegui achar essa opção!\nSó conheço esses comandos",
        ChatMessageType.received,
      );
      _addMessage(_actionsOptions, ChatMessageType.received);
    }
  }

  void _saveAccount() {
    var accountService = AccountService();
    accountService.create(_accountCreationData);
  }

  void clearAccountData() {
    _accountCreationData["name"] = "";
    _accountCreationData["balance"] = "";
  }

  void _processAccountCreation(String message) {
    var answer = "";

    if (_accountCreationData["name"]!.isEmpty) {
      _accountCreationData["name"] = message;
      answer = "Qual o saldo inicial?";
    } else if (_accountCreationData["balance"]!.isEmpty) {
      _accountCreationData["balance"] = message;
      _saveAccount();
      clearAccountData();
      answer = "Conta cadastrada";
    }

    _addMessage(answer, ChatMessageType.received);

    print(_accountCreationData);
  }

  void _sendMessage(String message) {
    _controllerText.clear();

    _addMessage(message, ChatMessageType.sent);

    switch (_currentAction) {
      case CurrentActionType.none:
        _updateCurrentAction(message.trim());
        break;
      case CurrentActionType.accountCreation:
        _processAccountCreation(message);
        break;
    }
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



