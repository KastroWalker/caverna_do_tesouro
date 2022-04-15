import '../domain/entities/account.dart';
import '../domain/entities/finance_operation.dart';

abstract class CreditCardColumnsName {
  static const id = 'id';
  static const name = 'name';
  static const balance = 'balance';
}

const financeOperationType = '''
  CREATE TABLE finance_operation_type (
    id INTEGER PRIMARY KEY,
    type_name TEXT
  );
''';

const insertFinanceOpsType1 = "INSERT INTO finance_operation_type(id, type_name) VALUES (1, 'entry');";
const insertFinanceOpsType2 = "INSERT INTO finance_operation_type(id, type_name) VALUES (2, 'expense');";

const account = '''
    CREATE TABLE account(
        ${AccountColumnsName.id} INTEGER PRIMARY KEY, 
        ${AccountColumnsName.name} TEXT, 
        ${AccountColumnsName.balance} REAL
    );
''';

const creditCard = '''
  CREATE TABLE credit_card(
    ${CreditCardColumnsName.id} INTEGER PRIMARY KEY, 
    ${CreditCardColumnsName.name} TEXT, 
    ${CreditCardColumnsName.balance} REAL
  );
''';

const financeOperation = '''
   CREATE TABLE finance_operation(
    ${FinanceOperationColumnsName.id} INTEGER PRIMARY KEY,
    ${FinanceOperationColumnsName.name} TEXT,
    ${FinanceOperationColumnsName.value} REAL,
    ${FinanceOperationColumnsName.accountID} INTEGER,
    ${FinanceOperationColumnsName.creditCardId} INTEGER,
    ${FinanceOperationColumnsName.createdAt} TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ${FinanceOperationColumnsName.typeOperation} INTEGER,
    FOREIGN KEY(${FinanceOperationColumnsName.typeOperation}) REFERENCES finance_operation_type(id),
    FOREIGN KEY(${FinanceOperationColumnsName.accountID}) REFERENCES account(id),
    FOREIGN KEY(${FinanceOperationColumnsName.creditCardId}) REFERENCES credit_card(id)
  );
''';

const scripts = [
    financeOperationType,
    insertFinanceOpsType1,
    insertFinanceOpsType2,
    account,
    creditCard,
    financeOperation,
];