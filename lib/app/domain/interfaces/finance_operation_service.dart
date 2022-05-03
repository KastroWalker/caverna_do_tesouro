import 'package:caverna_do_tesouro/app/domain/entities/finance_operation.dart';

import '../entities/total_financial_operation.dart';

abstract class IFinanceOperationService {
  Future<String> create(Map<String, String> data);

  Future<List<FinanceOperation>> listAll();

  Future<TotalFinancialOperations> getFinancialInformation();
}