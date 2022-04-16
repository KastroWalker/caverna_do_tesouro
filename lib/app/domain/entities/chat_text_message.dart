enum ChatMessageType { user, bot }

class ChatTextMessage {
  ChatMessageType type;
  String text;

  ChatTextMessage(this.type, this.text);
}
