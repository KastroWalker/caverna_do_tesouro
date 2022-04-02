import 'income.dart';

class CreditCard implements Income {
  @override
  String name;
  BigInt invoice;

  CreditCard(
    this.name,
    this.invoice,
  );
}
