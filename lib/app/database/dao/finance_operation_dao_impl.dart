import 'package:caverna_do_tesouro/app/domain/entities/account.dart';
import 'package:caverna_do_tesouro/app/domain/entities/finance_operation.dart';
import 'package:caverna_do_tesouro/app/domain/entities/total_financial_operation.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/finance_operation_dao.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/entities/finance_operation_type.dart';
import '../connection.dart';

class FinanceOperationDAO implements IFinanceOperationDAO {
  final String _table = 'finance_operation';

  // TODO add try catch in the methods

  // TODO refactor to return an object
  @override
  Future<String> store(FinanceOperation financeOperation) async {
    try {
      final connection = await Connection.get();

      financeOperation.id = await connection!.insert(
        _table,
        financeOperation.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return financeOperation.toString();
    } catch (e) {
      throw Exception('Error on store finance operation');
    }
  }

  @override
  Future<List<FinanceOperation>> fetchAll() async {
    try {
      final connection = await Connection.get();

      // TODO export to an String
      // TODO refactor to get account or credit card information
      final List<Map<String, dynamic>> maps = await connection!.rawQuery(
          '''SELECT finance_operation.*, type_operation.*, account.name as account_name, account.balance as account_balance 
      FROM $_table as finance_operation
      INNER JOIN finance_operation_type AS type_operation
      ON finance_operation_id = type_operation.id
      INNER JOIN account AS account
      ON account_id = account.id
      ''');

      return List.generate(maps.length, (index) {
        return toObject(maps[index]);
      });
    } catch (e) {
      throw Exception('Error on fetch all finance operations');
    }
  }

  @override
  Future<TotalFinancialOperations> fetchTotalFinancialOperations() async {
    try {
      final connection = await Connection.get();

      final List<Map<String, dynamic>> maps = await connection!.rawQuery('''
          SELECT SUM(value) FROM $_table WHERE finance_operation_id = 1
          UNION ALL
          SELECT SUM(value) FROM $_table WHERE finance_operation_id = 2
        ''');

      final entryValue = maps[0]['SUM(value)'] ?? '0.0';
      final expenseValue = maps[1]['SUM(value)'] ?? '0.0';

      return TotalFinancialOperations(
        totalEntry: double.parse(entryValue.toString()),
        totalExpense: double.parse(expenseValue.toString()),
      );
    } catch (e) {
      throw Exception('Error on fetch total financial operations');
    }
  }

  @override
  FinanceOperation toObject(Map<String, dynamic> map) {
    return FinanceOperation(
      id: map[FinanceOperationColumnsName.id],
      name: map[FinanceOperationColumnsName.name],
      value: map[FinanceOperationColumnsName.value],
      // TODO refactor to get type from database
      financeOperationType:
          FinanceOperationType(map['finance_operation_id'], map['type_name']),
      // TODO refactor to get income from database
      income: Account(
        name: map['account_name'],
        balance: map['account_balance'],
      ),
    );
  }

  @override
  Future<int> delete(int id) async {
    try {
      final connection = await Connection.get();

      return await connection!.delete(_table, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      throw Exception('Error on delete finance operation');
    }
  }
}
