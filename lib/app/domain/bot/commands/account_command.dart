import 'package:caverna_do_tesouro/app/domain/entities/answer.dart';
import 'package:get_it/get_it.dart';

import '../../interfaces/account_service.dart';

class AccountCommands {
  final _accountCreationData = {
    "name": "",
    "balance": "",
  };
  final _service = GetIt.I.get<IAccountService>();

  void _clearData() {
    _accountCreationData["name"] = "";
    _accountCreationData["balance"] = "";
  }

  Map<String, String> getData() {
    return _accountCreationData;
  }

  // TODO add validation to values
  Future<Answer> createAccount(String message) async {
    var answer = Answer(type: AnswerType.text);

    if (_accountCreationData["name"]!.isEmpty) {
      _accountCreationData["name"] = message;
      answer.text = "Qual o saldo inicial?";
    } else if (_accountCreationData["balance"]!.isEmpty) {
      _accountCreationData["balance"] = message;
      var contactStored = await _service.create(_accountCreationData);
      _clearData();
      answer.text = "Conta cadastrada: $contactStored";
    }

    return answer;
  }
}
