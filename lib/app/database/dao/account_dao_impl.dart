import 'package:caverna_do_tesouro/app/database/connection.dart';
import 'package:caverna_do_tesouro/app/domain/entities/account.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/account_dao.dart';
import 'package:sqflite/sqflite.dart';

class AccountDAOImpl implements IAccountDAO {
  final String _table = 'account';

  // TODO add try catch in the methods

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
        return toObject(maps[index]);
      });
    }

    return null;
  }

  @override
  Future<int> delete(int id) async {
    final connection = await Connection.get();

    if (connection != null) {
      return await connection.delete(_table, where: 'id = ?', whereArgs: [id]);
    }

    return 0;
  }

  @override
  Future<Account?> findById(int id) async {
    final connection = await Connection.get();

    if (connection != null) {
      final accounts =
          await connection.query(_table, where: 'id = ?', whereArgs: [id]);
      return toObject(accounts[0]);
    }

    return null;
  }

  @override
  Account toObject(Map<String, dynamic> map) {
    return Account(
      id: map[AccountColumnsName.id],
      name: map[AccountColumnsName.name],
      balance: map[AccountColumnsName.balance],
    );
  }

  @override
  Future<int> update(int id, Account account) async {
    try {
      final connection = await Connection.get();

      return connection!.update(
        _table,
        account.toMap(),
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception('Error on update account');
    }
  }

  @override
  Future<Account?> fetchById(int id) async {
    try {
      final connection = await Connection.get();

      final accounts = await connection!.query(_table, where: 'id = ?', whereArgs: [id]);

      return toObject(accounts[0]);
    } catch (e) {
      throw Exception('Error on fetch account');
    }
  }
}