import 'package:caverna_do_tesouro/app/view/widgets/selection_radio.dart';
import 'package:flutter/material.dart';

class ChatSelectionMessageItem extends StatelessWidget {
  final String title;
  final String groupId;
  final List<Map<String, String>> options;
  final Function(String, String) onChanged;
  final String groupValue;
  final Function(String) onPressed;
  final bool isDisabled;

  const ChatSelectionMessageItem({
    Key? key,
    required this.title,
    required this.groupId,
    required this.options,
    required this.onChanged,
    required this.groupValue,
    required this.onPressed,
    required this.isDisabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        for (var option in options)
          SelectionRadio(
            title: option['text']!,
            value: option['value']!,
            groupValue: groupValue,
            groupId: groupId,
            onChanged: onChanged,
            isDisabled: isDisabled,
          ),
        ElevatedButton(
          onPressed: isDisabled ? null : () => onPressed(groupId),
          child: const Text('Selectionar'),
        ),
      ],
    );
  }
}