import 'income.dart';

class CreditCard implements Income {
  @override
  String name;
  double invoice;

  CreditCard(
    this.name,
    this.invoice,
  );
}
