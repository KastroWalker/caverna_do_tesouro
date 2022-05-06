import 'package:flutter/material.dart';

class SelectionPageController extends ChangeNotifier {
  final selectionList = [];
  var valueSelected = {};

  SelectionPageController() {
    final selectionGroup1 = {
      'title': 'Selection Group 1',
      'id': 'selectionGroup1',
      'options': [
        {'title': 'Value 1', 'value': 'value_1'},
        {'title': 'Value 2', 'value': 'value_2'},
      ],
      'isDisabled': false,
    };
    valueSelected['selectionGroup1'] = '';

    final selectionGroup2 = {
      'title': 'Selection Group 2',
      'id': 'selectionGroup2',
      'options': [
        {'title': 'Value 1', 'value': 'value_1'},
        {'title': 'Value 2', 'value': 'value_2'},
      ],
      'isDisabled': false,
    };
    valueSelected['selectionGroup2'] = '';

    selectionList.add(selectionGroup1);
    selectionList.add(selectionGroup2);
  }

  void updateValueSelected(selectionGroupId, value) {
    print('updateValueSelected: $selectionGroupId, $value');
    valueSelected[selectionGroupId] = value;
    notifyListeners();
  }

  void disableSelectionGroup(selectionGroupId) {
    for (final selection in selectionList) {
      if (selection['id'] == selectionGroupId) {
        selection['isDisabled'] = true;
      }
    }
    notifyListeners();
  }

  void selectOption(id) {
    print('Valores diponiveis: ${valueSelected.toString()}');
    print('Valor selecionado: ${valueSelected[id]}');
    disableSelectionGroup(id);
    notifyListeners();
  }

  void insertSelectionGroup(selectionGroup) {
    selectionList.add(selectionGroup);
    notifyListeners();
  }
}

class SelectionPage extends StatefulWidget {
  const SelectionPage({Key? key}) : super(key: key);

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  final selectionPageController = SelectionPageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selection Page'),
      ),
      body: Column(
        children: [
          for (var selection in selectionPageController.selectionList)
            AnimatedBuilder(
              animation: selectionPageController,
              builder: (_, widget) {
                return SelectionGroup(
                  title: selection['title'],
                  groupId: selection['id'],
                  options: selection['options'],
                  isDisabled: selection['isDisabled'],
                  groupValue:
                      selectionPageController.valueSelected[selection['id']],
                  onChanged: selectionPageController.updateValueSelected,
                  onPressed: selectionPageController.selectOption,
                );
              },
            ),
          ElevatedButton(
            onPressed: () {
              selectionPageController.insertSelectionGroup({
                'title': 'Selection Group 3',
                'id': 'selectionGroup3',
                'options': [
                  {'title': 'Value 1', 'value': 'value_1'},
                  {'title': 'Value 2', 'value': 'value_2'},
                ],
                'isDisabled': false,
              });
            },
            child: const Text('Add Selection Group'),
          ),
        ],
      ),
    );
  }
}

class SelectionGroup extends StatelessWidget {
  final String title;
  final String groupId;
  final List<Map<String, String>> options;
  final Function(String, String) onChanged;
  final String groupValue;
  final Function(String) onPressed;
  final bool isDisabled;

  const SelectionGroup({
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
            title: option['title']!,
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
    return Row(
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
    );
  }
}
