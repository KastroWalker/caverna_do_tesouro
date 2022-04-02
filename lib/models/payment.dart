import 'account.dart';
import 'credit_card.dart';

class Payment {
  Account account;
  BigInt value;
  CreditCard creditCard;
  DateTime date;

  Payment(
    this.account,
    this.value,
    this.creditCard,
    this.date,
  );
}
