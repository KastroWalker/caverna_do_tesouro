import 'package:caverna_do_tesouro/app/view/widgets/labeled_radio.dart';
import 'package:flutter/material.dart';

class ChatSelectionMessageItem extends StatelessWidget {
  final String cardTitle;
  final List<Map<String, String>> options;
  final String groupValue;
  final ValueChanged<String> onChanged;
  final Function onPressedButton;

  const ChatSelectionMessageItem({
    required this.groupValue,
    required this.cardTitle,
    required this.options,
    required this.onChanged,
    required this.onPressedButton,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitle(),
        for (Map<String, String> option in options)
          LabeledRadio(
            label: option['text']!,
            value: option['value']!,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
        _buildButton(),
      ],
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: groupValue.isEmpty
          ? null
          : () {
              onPressedButton();
            },
      child: const Text('Selecionar'),
    );
  }

  Widget _buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          cardTitle,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
