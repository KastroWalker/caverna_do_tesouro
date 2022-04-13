import 'income.dart';

enum TypeFinanceOperation {
  entry,
  withdrawal,
}

class FinanceOperation {
  String name;
  double value;
  TypeFinanceOperation typeOperation;
  Income income;
  DateTime date;

  FinanceOperation(
    this.name,
    this.value,
    this.typeOperation,
    this.income,
    this.date,
  );
}
