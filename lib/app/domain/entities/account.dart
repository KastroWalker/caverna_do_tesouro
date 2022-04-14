import 'income.dart';

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
      'name': name,
      'balance': balance,
    };
  }

  @override
  String toString() {
    return 'Account{id: $id, name: $name, balance: $balance}';
  }
}
