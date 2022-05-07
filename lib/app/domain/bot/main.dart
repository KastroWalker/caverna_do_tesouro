import 'package:caverna_do_tesouro/app/domain/entities/answer.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/account_service.dart';
import 'package:get_it/get_it.dart';

import 'commands/account_command.dart';
import 'commands/finance_operation_command.dart';

// TODO move to an external file
enum CurrentOperationType { none, accountCreation, financeOperationCreation }

class Bot {
  final accountCommands = GetIt.I.get<AccountCommands>();
  final financeOperationCommands = GetIt.I.get<FinanceOperationCommands>();
  final accountService = GetIt.I.get<IAccountService>();

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
        final updateMessage = await _updateOperation(message);
        return TextAnswer(text: updateMessage);

      case CurrentOperationType.accountCreation:
        return await accountCommands.createAccount(message);
      case CurrentOperationType.financeOperationCreation:
        return await financeOperationCommands.createFinanceOperation(message);
      default:
        return TextAnswer(text: "");
    }
  }

  String getInitialMessage(operation) {
    _currentOperation = operation["operationType"] as CurrentOperationType;
    var initialMessage = operation["initialMessage"] as String;
    return initialMessage;
  }

  Future<String> _updateOperation(String message) async {
    try {
      var operation = _operations[int.parse(message)];

      if (operation["operationType"] ==
          CurrentOperationType.financeOperationCreation) {
        final hasAccountStored = await accountService.hasAccountStored();

        if (hasAccountStored) {
          return getInitialMessage(operation);
        } else {
          return "Para criar um lançamento, primeiro você precisa adicionar uma conta.";
        }
      } else {
        return getInitialMessage(operation);
      }
    } catch (exception) {
      return "Desculpa, não consegui achar essa opção!\nSó conheço esses comandos:\n${initialMessage()}";
    }
  }

  TextAnswer initialMessage() {
    var message = "";

    _operationsOptions.asMap().forEach(
        (index, operation) => message = "$message\n${index + 1} - $operation");

    return TextAnswer(text: message);
  }
}
