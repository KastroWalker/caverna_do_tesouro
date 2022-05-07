import 'package:caverna_do_tesouro/app/domain/entities/answer.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/bot/main.dart';
import '../widgets/chat_message_item.dart';

class ChatPageController extends ChangeNotifier {
  final bot = Bot();
  final messages = <ChatMessageItem>[];

  final List<SelectionAnswer> selectionList = [];
  var valueSelected = {};

  void updateValueSelected(String selectionGroupId, String value) {
    valueSelected[selectionGroupId] = value;
    notifyListeners();
  }

  void disableSelectionGroup(String selectionGroupId) {
    for (final selection in selectionList) {
      if (selection.groupId == selectionGroupId) {
        selection.isDisabled = true;
      }
    }
    notifyListeners();
  }

  void insertSelectionGroup(SelectionAnswer selectionGroup) {
    selectionList.add(selectionGroup);
    valueSelected[selectionGroup.groupId] = '';
    notifyListeners();
  }
}
