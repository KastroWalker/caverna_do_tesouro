import 'package:caverna_do_tesouro/app/domain/exceptions/invalid_data.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/account_dao.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/account_service.dart';
import 'package:get_it/get_it.dart';

import '../entities/account.dart';

class AccountService implements IAccountService {
  final _dao = GetIt.I.get<IAccountDAO>();

  @override
  Future<String> create(Map<String, String> data) async {
    if (data["name"] == null || data["balance"] == null) {
      throw InvalidData("Name and balance is required!");
    }

    final name = data["name"]!;
    final balance = double.parse(data["balance"]!);

    final newAccount = Account(name: name, balance: balance);

    return await _dao.store(newAccount);
  }

  @override
  Future<List<Account>?> listAll() async {
    return await _dao.fetchAll();
  }

  @override
  Future<bool> remove(int accountID) async {
    return await _dao.delete(accountID) == 1 ? true : false;
  }

  @override
  Future<bool> deposit(int accountID, double amount) async {
    final account = await _dao.fetchById(accountID);

    if (account == null) return throw InvalidData("Account not found!");

    if (amount <= 0) {
      throw InvalidData("Amount must be greater than zero!");
    }

    account.balance += amount;

    return await _dao.update(accountID, account) == 1 ? true : false;
  }

  @override
  Future<bool> withdraw(int accountID, double amount) async {
    final account = await _dao.fetchById(accountID);

    if (account == null) return throw InvalidData("Account not found!");

    if (amount <= 0) {
      throw InvalidData("Amount must be greater than zero!");
    } else if (account.balance < amount) {
      throw InvalidData("Insufficient balance!");
    }

    account.balance -= amount;

    return await _dao.update(accountID, account) == 1 ? true : false;
  }
}
