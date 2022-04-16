import 'package:caverna_do_tesouro/app/domain/entities/answer.dart';
import 'package:get_it/get_it.dart';

import 'commands/account_command.dart';
import 'commands/finance_operation_command.dart';

// TODO move to an external file
enum CurrentOperationType { none, accountCreation, financeOperationCreation }

class Bot {
  final accountCommands = GetIt.I.get<AccountCommands>();
  final financeOperationCommands = GetIt.I.get<FinanceOperationCommands>();

  // TODO move to an external file
  final _operationsOptions = [
    "Adicionar Conta Bancária",
    "Adicionar Lançamento"
  ];

  // TODO move to an external file
  // TODO transform to a class
  final _operations = [
    {"operationType": CurrentOperationType.none, "initialMessage": ""},
    {
      "operationType": CurrentOperationType.accountCreation,
      "initialMessage": "Qual o nome da conta?"
    },
    {
      "operationType": CurrentOperationType.financeOperationCreation,
      "initialMessage": "Qual o nome do lançamento?"
    }
  ];

  var _currentOperation = CurrentOperationType.none;

  Future<Answer> processMessage(String message) async {
    switch (_currentOperation) {
      case CurrentOperationType.none:
        final updateMessage = _updateOperation(message);
        return Answer(type: AnswerType.text, text: updateMessage);
      case CurrentOperationType.accountCreation:
        return await accountCommands.createAccount(message);
      case CurrentOperationType.financeOperationCreation:
        print('MESSAGE: $message');
        return await financeOperationCommands.createFinanceOperation(message);
      default:
        return Answer(type: AnswerType.text, text: "");
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

  Answer initialMessage() {
    var message = "";

    _operationsOptions.asMap().forEach(
        (index, operation) => message = "$message\n${index + 1} - $operation");

    return Answer(type: AnswerType.text, text: message);
  }
}
