import 'package:flutter/material.dart';

class SelectionRadio extends StatelessWidget {
  final String title;
  final String value;
  final String groupId;
  final String groupValue;
  final Function(String, String) onChanged;
  final bool isDisabled;

  const SelectionRadio({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.groupId,
    required this.groupValue,
    required this.isDisabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled
          ? null
          : () {
              if (value != groupValue) {
                onChanged(groupId, value);
              }
            },
      child: Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: isDisabled
                ? null
                : (String? newValue) {
                    onChanged(groupId, newValue!);
                  },
          ),
          Text(title),
        ],
      ),
    );
  }
}
