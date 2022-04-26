import 'package:caverna_do_tesouro/app/domain/entities/answer.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/account_service.dart';
import 'package:caverna_do_tesouro/app/domain/services/finance_operation_service.dart';
import 'package:get_it/get_it.dart';

class FinanceOperationCommands {
  final _accountService = GetIt.I.get<IAccountService>();
  final _financeOperationData = {
    "name": "",
    "value": "",
    "typeOperation": "",
    "incomeId": "",
    "typeIncome": "",
  };
  final _service = FinanceOperationService();

  void _clearData() {
    _financeOperationData["name"] = "";
    _financeOperationData["value"] = "";
    _financeOperationData["typeOperation"] = "";
    _financeOperationData["incomeId"] = "";
    _financeOperationData["typeIncome"] = "";
  }

  Future<Answer> _createAccountsList() async {
    final accounts = await _accountService.listAll();

    List<Map<String, String>> accountsOptions = [];

    for (final account in accounts!) {
      accountsOptions
          .add({'text': account.name, 'value': '${account.id}'});
    }

    return Answer(
      type: AnswerType.selection,
      selectionTitle: "Qual conta esse lançamento está vinculado?",
      options: accountsOptions,
    );
  }

  Future<Answer> _createTypeOperationList() async {
    final options = [
      {"text": "Entrada", "value": "1"},
      {"text": "Saida", "value": "2"},
    ];
    return Answer(
      type: AnswerType.selection,
      selectionTitle: "Qual o tipo de lançamento?",
      options: options,
    );
  }

  Future<Answer> _createTypeIncomeList() async {
    final options = [
      {"text": "Conta bancária", "value": "1"},
      {"text": "Cartão de Crédito", "value": "2"},
    ];
    return Answer(
      type: AnswerType.selection,
      selectionTitle: "Qual o tipo de lançamento?",
      options: options,
    );
  }

  // TODO add validation to values
  // TODO if the typeOperation is entry just list accounts
  Future<Answer> createFinanceOperation(String message) async {
    var answer = Answer(type: AnswerType.text);

    if (_financeOperationData["name"]!.isEmpty) {
      _financeOperationData["name"] = message;
      answer.text = "Qual o valor do lançamento?";
    } else if (_financeOperationData["value"]!.isEmpty) {
      _financeOperationData["value"] = message;
      answer = await _createTypeOperationList();
    } else if (_financeOperationData["typeOperation"]!.isEmpty) {
      _financeOperationData["typeOperation"] = message;
      answer = await _createTypeIncomeList();
    } else if (_financeOperationData["typeIncome"]!.isEmpty) {
      _financeOperationData["typeIncome"] = message;
      answer = await _createAccountsList();
    } else if (_financeOperationData["incomeId"]!.isEmpty) {
      _financeOperationData["incomeId"] = message;
      var operationCreated = await _service.create(_financeOperationData);
      _clearData();
      answer.text = "Lançamento cadastrado: $operationCreated";
    }

    return answer;
  }
}
