import 'package:caverna_do_tesouro/app/database/connection.dart';
import 'package:caverna_do_tesouro/app/domain/entities/account.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/account_dao.dart';
import 'package:sqflite/sqflite.dart';

class AccountDAOImpl implements IAccountDAO {
  final String _table = 'account';

  @override
  Future<String> store(Account account) async {
    var connection = await Connection.get();
    account.id = await connection?.insert(
      _table,
      account.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return account.toString();
  }
}