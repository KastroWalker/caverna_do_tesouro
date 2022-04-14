import 'package:caverna_do_tesouro/app/database/script.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Connection {
  static Database? _db;

  static Future<Database?> get() async {
    if (_db == null) {
      var path = join(await getDatabasesPath(), 'banco_contatos');
      _db = await openDatabase(
        path,
        version: 1,
        onCreate: (db, v) {
          db.execute(createTable);
        },
      );
    }
    return _db;
  }
}
