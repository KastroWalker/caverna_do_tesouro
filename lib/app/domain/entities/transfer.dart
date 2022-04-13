import 'account.dart';

class Transfer {
  Account originAccount;
  Account destinyAccount;
  double value;
  DateTime date;

  Transfer(
    this.originAccount,
    this.destinyAccount,
    this.value,
    this.date,
  );
}
