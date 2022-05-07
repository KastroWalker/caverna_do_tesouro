enum AnswerType {
  text,
  selection,
}

abstract class Answer {}

class TextAnswer implements Answer {
  final String text;

  TextAnswer({required this.text});
}

class SelectionAnswer implements Answer {
  final String title;
  final String groupId;
  final List<Map<String, String>> options;
  bool isDisabled;

  SelectionAnswer({
    required this.title,
    required this.groupId,
    required this.options,
    this.isDisabled = false,
  });
}
