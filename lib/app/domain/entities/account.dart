import 'income.dart';

abstract class AccountColumnsName {
  static const id = 'id';
  static const name = 'name';
  static const balance = 'balance';
}

class Account implements Income {
  dynamic id;
  @override
  String name;
  double balance;

  Account({
    this.id,
    required this.name,
    required this.balance,
  });

  Map<String, dynamic> toMap() {
    return {
      AccountColumnsName.name: name,
      AccountColumnsName.balance: balance,
    };
  }

  @override
  String toString() {
    return 'Account{id: $id, name: $name, balance: $balance}';
  }
}
