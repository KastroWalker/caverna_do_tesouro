import 'package:caverna_do_tesouro/app/domain/entities/finance_operation.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/dao.dart';

import '../entities/total_financial_operation.dart';

abstract class IFinanceOperationDAO implements IDAO {
  Future<String> store(FinanceOperation financeOperation);

  Future<List<FinanceOperation>> fetchAll();

  Future<TotalFinancialOperations> fetchTotalFinancialOperations();

  Future<int> delete(int id);

  Future<List<FinanceOperation>> fetchByAccount(int accountID);
}