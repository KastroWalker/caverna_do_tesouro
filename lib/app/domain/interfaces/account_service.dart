import '../entities/account.dart';

abstract class IAccountService {
  Future<String> create(Map<String, String> data);

  Future<List<Account>?> listAll();

  Future<bool> remove(int accountID);

  Future<bool> deposit(int accountID, double amount);

  Future<bool> withdraw(int accountID, double amount);

  Future<bool> hasAccountStored();
}
