enum ChatMessageType { sent, received }

class ChatMessage {
  ChatMessageType type;
  String text;

  ChatMessage(this.type, this.text);
}
