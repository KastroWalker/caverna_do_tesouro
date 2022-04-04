import 'package:caverna_do_tesouro/exceptions/invalid_data.dart';
import 'package:caverna_do_tesouro/models/account.dart';

class AccountService {
  final List<Account> _accounts = [];

  void create(Map<String, String> data) {
    if (data["name"] == null || data["balance"] == null) {
      throw InvalidData("Name and balance is required!");
    }

    var name = data["name"]!;
    var balance = BigInt.parse(data["balance"]!);
    
    var newAccount = Account(name, balance);

    _accounts.add(newAccount);
  }
}
