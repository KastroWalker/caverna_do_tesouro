import 'package:flutter/material.dart';

class MessageInput extends StatelessWidget {
  final TextEditingController _controller;
  final Function _sendMessage;

  const MessageInput(this._controller, this._sendMessage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          MessageTextField(_controller),
          SendButton(_controller, _sendMessage),
        ],
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  final TextEditingController _controller;
  final Function _onClick;

  const SendButton(this._controller, this._onClick, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8.0),
      child: IconButton(
        icon: Icon(
          Icons.send,
          color: Theme.of(context).colorScheme.secondary,
        ),
        onPressed: () {
          if (_controller.text.isNotEmpty) {
            _onClick(_controller.text);
          }
        },
      ),
    );
  }
}

class MessageTextField extends StatelessWidget {
  final TextEditingController _controller;

  const MessageTextField(this._controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        controller: _controller,
        decoration: const InputDecoration.collapsed(
          hintText: "Enviar mensagem",
        ),
      ),
    );
  }
}