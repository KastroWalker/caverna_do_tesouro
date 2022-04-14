abstract class AccountColumnsName {
  static const id = 'id';
  static const name = 'name';
  static const balance = 'balance';
}

const createTable = '''
  CREATE TABLE account(
  ${AccountColumnsName.id} INTEGER PRIMARY KEY, 
  ${AccountColumnsName.name} TEXT, 
  ${AccountColumnsName.balance} REAL
  );
''';