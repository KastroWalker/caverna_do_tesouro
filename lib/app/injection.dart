import 'package:caverna_do_tesouro/app/database/dao/account_dao_impl.dart';
import 'package:caverna_do_tesouro/app/domain/bot/commands/account.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/account_dao.dart';
import 'package:get_it/get_it.dart';

import 'domain/interfaces/account_service.dart';
import 'domain/services/account_service.dart';

setupInjection() async{
  GetIt getIt = GetIt.I;

  getIt.registerSingleton<IAccountDAO>(AccountDAOImpl());
  getIt.registerSingleton<IAccountService>(AccountService());
  getIt.registerSingleton<AccountOperation>(AccountOperation());
}