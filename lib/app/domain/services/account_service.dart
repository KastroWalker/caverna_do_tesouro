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

    var name = data["name"]!;
    var balance = double.parse(data["balance"]!);
    
    var newAccount = Account(name: name, balance: balance);

    return await _dao.store(newAccount);
  }

  @override
  Future<List<Account>?> listAll() async{
    return await _dao.fetchAll();
  }
}
