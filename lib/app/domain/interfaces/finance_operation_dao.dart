import 'package:caverna_do_tesouro/app/domain/entities/finance_operation.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/dao.dart';

abstract class IFinanceOperationDAO implements IDAO {
  Future<String> store(FinanceOperation financeOperation);
}