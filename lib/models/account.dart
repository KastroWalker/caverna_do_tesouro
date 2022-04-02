import 'income.dart';

class Account implements Income {
  @override
  String name;
  BigInt balance;

  Account(
    this.name,
    this.balance,
  );
}
