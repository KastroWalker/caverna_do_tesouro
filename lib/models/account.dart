import 'income.dart';

class Account implements Income {
  int? id;
  @override
  String name;
  final double balance;

  Account(
    this.name,
    this.balance,
  );

  Map<String, dynamic> toMap(){
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
