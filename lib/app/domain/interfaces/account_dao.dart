import 'package:caverna_do_tesouro/app/domain/entities/account.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/dao.dart';

abstract class IAccountDAO implements IDAO {
  Future<String> store(Account account);

  Future<List<Account>?> fetchAll();

  Future<int> delete(int id);

  Future<Account?> findById(int id);

  Future<int> update(int id, Account account);

  Future<Account?> fetchById(int id);

  Future<int> hasAccountStored();
}
