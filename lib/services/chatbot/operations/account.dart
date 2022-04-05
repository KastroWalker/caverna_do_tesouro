class AccountOperation {
  final _accountCreationData = {
    "name": "",
    "balance": "",
  };

  void _clearData() {
    _accountCreationData["name"] = "";
    _accountCreationData["balance"] = "";
  }

  Map<String, String> getData() {
    return _accountCreationData;
  }

  String createAccount(String message) {
    var answer = "";

    if (_accountCreationData["name"]!.isEmpty) {
      _accountCreationData["name"] = message;
      answer = "Qual o saldo inicial?";
    } else if (_accountCreationData["balance"]!.isEmpty) {
      _accountCreationData["balance"] = message;
      _clearData();
      answer = "Conta cadastrada";
    }

    return answer;
  }
}
