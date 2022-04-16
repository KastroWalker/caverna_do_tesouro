import 'package:caverna_do_tesouro/app/domain/entities/finance_operation.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/finance_operation_dao.dart';
import 'package:sqflite/sqflite.dart';

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
  Object toObject(Map<String, dynamic> map) {
    // TODO: implement toObject
    throw UnimplementedError();
  }
}
