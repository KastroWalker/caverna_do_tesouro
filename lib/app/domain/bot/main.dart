import 'package:get_it/get_it.dart';

import 'commands/account.dart';

enum CurrentOperationType { none, accountCreation }

class Bot {
  final accountOperation = GetIt.I.get<AccountOperation>();
  final _operationsOptions = [
    "Adicionar Conta Bancária",
    "Adicionar Cartão de crédito"
  ];
  final _operations = [
    {"operationType": CurrentOperationType.none, "initialMessage": ""},
    {
      "operationType": CurrentOperationType.accountCreation,
      "initialMessage": "Qual o nome da conta?"
    },
  ];
  var _currentOperation = CurrentOperationType.none;

  Future<String> processMessage(String message) async {
    switch (_currentOperation) {
      case CurrentOperationType.none:
        return _updateOperation(message);
      case CurrentOperationType.accountCreation:
        return await accountOperation.createAccount(message);
      default:
        return "";
    }
  }

  String _updateOperation(String message) {
    try {
      var operation = _operations[int.parse(message)];
      _currentOperation = operation["operationType"] as CurrentOperationType;
      var initialMessage = operation["initialMessage"] as String;
      return initialMessage;
    } catch (exception) {
      return "Desculpa, não consegui achar essa opção!\nSó conheço esses comandos:\n${initialMessage()}";
    }
  }

  String initialMessage() {
    var message = "";

    _operationsOptions.asMap().forEach(
        (index, operation) => message = "$message\n${index + 1} - $operation");

    return message;
  }
}
