import 'income.dart';

class CreditCard implements Income {
  dynamic id;
  @override
  String name;
  double invoice;

  CreditCard({
    this.id,
    required this.name,
    required this.invoice,
  });
}
