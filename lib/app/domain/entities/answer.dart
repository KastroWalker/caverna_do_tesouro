enum AnswerType {
  text,
  selection,
}

class Answer {
  final AnswerType type;
  String? text;
  String? selectionTitle;
  List<Map<String, String>>? options;

  Answer({required this.type, this.text, this.options, this.selectionTitle});
}