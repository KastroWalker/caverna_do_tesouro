import 'package:caverna_do_tesouro/services/account_service.dart';

class AccountOperation {
  final _accountCreationData = {
    "name": "",
    "balance": "",
  };
  final _service = AccountService();

  void _clearData() {
    _accountCreationData["name"] = "";
    _accountCreationData["balance"] = "";
  }

  Map<String, String> getData() {
    return _accountCreationData;
  }

  Future<String> createAccount(String message) async {
    var answer = "";

    if (_accountCreationData["name"]!.isEmpty) {
      _accountCreationData["name"] = message;
      answer = "Qual o saldo inicial?";
    } else if (_accountCreationData["balance"]!.isEmpty) {
      _accountCreationData["balance"] = message;
      var contactStored = await _service.create(_accountCreationData);
      _clearData();
      answer = "Conta cadastrada: $contactStored";
    }

    return answer;
  }
}
