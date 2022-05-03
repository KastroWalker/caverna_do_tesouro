import 'package:caverna_do_tesouro/app/domain/entities/finance_operation.dart';
import 'package:caverna_do_tesouro/app/domain/entities/income.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/account_dao.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/finance_operation_dao.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/finance_operation_service.dart';
import 'package:get_it/get_it.dart';

import '../entities/finance_operation_type.dart';
import '../entities/total_financial_operation.dart';
import '../exceptions/invalid_data.dart';

class FinanceOperationService implements IFinanceOperationService {
  final _dao = GetIt.I.get<IFinanceOperationDAO>();
  final _accountDAO = GetIt.I.get<IAccountDAO>();

  @override
  Future<String> create(Map<String, String> data) async {
    final name = data["name"];
    final value = double.parse(data["value"]!);
    final typeOperation = data["typeOperation"];
    // final typeIncome = data["typeIncome"];
    final incomeId = data["incomeId"];
    final financeOperationType = typeOperation == "1"
        ? FinanceOperationType(1, 'entry')
        : FinanceOperationType(2, 'expense');

    // TODO: validate data
    if (name == null) {
      throw InvalidData("Name is required!");
    }

    Income income;

    income = (await _accountDAO.findById(int.parse(incomeId!)))!;

    final newFinanceOperation = FinanceOperation(
      name: name,
      value: value,
      financeOperationType: financeOperationType,
      income: income,
    );

    return await _dao.store(newFinanceOperation);
  }

  @override
  Future<List<FinanceOperation>> listAll() async {
    try {
      return await _dao.fetchAll();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TotalFinancialOperations> getFinancialInformation() async {
    try {
      return await _dao.fetchTotalFinancialOperations();
    } catch (e) {
      rethrow;
    }
  }
}
