import 'package:caverna_do_tesouro/app/domain/entities/account.dart';
import 'package:caverna_do_tesouro/app/domain/entities/finance_operation.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/finance_operation_dao.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/entities/finance_operation_type.dart';
import '../connection.dart';

class FinanceOperationDAO implements IFinanceOperationDAO {
  final String _table = 'finance_operation';

  // TODO add try catch in the methods

  @override
  Future<String> store(FinanceOperation financeOperation) async {
    final connection = await Connection.get();
    financeOperation.id = await connection?.insert(
      _table,
      financeOperation.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return financeOperation.toString();
  }

  @override
  FinanceOperation toObject(Map<String, dynamic> map) {
    return FinanceOperation(
      id: map[FinanceOperationColumnsName.id],
      name: map[FinanceOperationColumnsName.name],
      value: map[FinanceOperationColumnsName.value],
      // TODO refactor to get type from database
      financeOperationType: FinanceOperationType(map['finance_operation_id'], map['type_name']),
      // TODO refactor to get income from database
      income: Account(
        name: map['account_name'],
        balance: map['account_balance'],
      ),
    );
  }

  @override
  Future<List<FinanceOperation>?> fetchAll() async {
    final connection = await Connection.get();

    if (connection != null) {
      // TODO export to an String
      // TODO refactor to get account or credit card information
      final List<Map<String, dynamic>> maps =
          await connection.rawQuery('''SELECT *, type_operation.*, account.name as account_name, account.balance as account_balance 
      FROM $_table
      INNER JOIN finance_operation_type AS type_operation
      ON finance_operation_id = type_operation.id
      INNER JOIN account AS account
      ON account_id = account.id
      ''');

      return List.generate(maps.length, (index) {
        return toObject(maps[index]);
      });
    }

    return null;
  }
}
