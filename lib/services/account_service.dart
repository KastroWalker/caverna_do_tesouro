import 'package:caverna_do_tesouro/exceptions/invalid_data.dart';
import 'package:caverna_do_tesouro/models/account.dart';
import 'package:caverna_do_tesouro/repositories/account_repository.dart';

class AccountService {
  final _repository = AccountRepository();

  Future<String> create(Map<String, String> data) async {
    if (data["name"] == null || data["balance"] == null) {
      throw InvalidData("Name and balance is required!");
    }

    var name = data["name"]!;
    var balance = double.parse(data["balance"]!);
    
    var newAccount = Account(name, balance);

    return _repository.create(newAccount);
  }
}
