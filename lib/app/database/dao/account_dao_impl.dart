import 'package:caverna_do_tesouro/app/database/connection.dart';
import 'package:caverna_do_tesouro/app/database/script.dart';
import 'package:caverna_do_tesouro/app/domain/entities/account.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/account_dao.dart';
import 'package:sqflite/sqflite.dart';

class AccountDAOImpl implements IAccountDAO {
  final String _table = 'account';

  @override
  Future<String> store(Account account) async {
    final connection = await Connection.get();
    account.id = await connection?.insert(
      _table,
      account.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return account.toString();
  }

  @override
  Future<List<Account>?> fetchAll() async {
    final connection = await Connection.get();

    if (connection != null) {
      final List<Map<String, dynamic>> maps = await connection.query(_table);

      return List.generate(maps.length, (index) {
        return Account(
          id: maps[index][AccountColumnsName.id],
          name: maps[index][AccountColumnsName.name],
          balance: maps[index][AccountColumnsName.balance],
        );
      });
    }

    return null;
  }
}