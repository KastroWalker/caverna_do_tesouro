import 'package:caverna_do_tesouro/app/domain/entities/account.dart';

abstract class IAccountDAO {
  Future<String> store(Account account);
  Future<List<Account>?> fetchAll();
}