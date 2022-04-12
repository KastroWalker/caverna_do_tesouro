import 'package:sqflite/sqflite.dart';

import '../config/database_connection.dart';
import '../models/account.dart';

class AccountRepository {
  final String _table = 'account';

  Future<String> create(Account account) async {
    var connection = await getDatabase();
    account.id = await connection.insert(
      _table,
      account.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return account.toString();
  }
}