import 'package:caverna_do_tesouro/app/domain/entities/FinanceOperationType.dart';
import 'package:caverna_do_tesouro/app/domain/entities/credit_card.dart';

import 'account.dart';
import 'income.dart';

abstract class FinanceOperationColumnsName {
  static const id = 'id';
  static const name = 'name';
  static const value = 'value';
  static const accountID = 'account_id';
  static const creditCardId = 'credit_card_id';
  static const createdAt = 'createdAt';
  static const typeOperation = 'finance_operation_id';
}

class FinanceOperation {
  dynamic id;
  String name;
  double value;
  Income income;
  Account? account;
  CreditCard? creditCard;
  FinanceOperationType financeOperationType;
  DateTime? createdAt;

  FinanceOperation({
    this.id,
    required this.name,
    required this.value,
    required this.financeOperationType,
    required this.income,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    final object = {
      FinanceOperationColumnsName.name: name,
      FinanceOperationColumnsName.value: value,
      FinanceOperationColumnsName.typeOperation: financeOperationType.id,
    };

    if (income is Account) {
      account = income as Account;
      object[FinanceOperationColumnsName.accountID] = account?.id;
    }

    if (income is CreditCard) {
      creditCard = income as CreditCard;
      object[FinanceOperationColumnsName.creditCardId] = creditCard?.id;
    }

    return object;
  }
}
