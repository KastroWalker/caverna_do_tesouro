import 'package:caverna_do_tesouro/app/database/dao/account_dao_impl.dart';
import 'package:caverna_do_tesouro/app/database/dao/finance_operation_dao_impl.dart';
import 'package:caverna_do_tesouro/app/domain/bot/commands/account_command.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/account_dao.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/finance_operation_dao.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/finance_operation_service.dart';
import 'package:caverna_do_tesouro/app/domain/services/finance_operation_service.dart';
import 'package:get_it/get_it.dart';

import 'domain/bot/commands/finance_operation_command.dart';
import 'domain/interfaces/account_service.dart';
import 'domain/services/account_service.dart';

setupInjection() async{
  GetIt getIt = GetIt.I;

  // DAO's
  getIt.registerSingleton<IAccountDAO>(AccountDAOImpl());
  getIt.registerSingleton<IFinanceOperationDAO>(FinanceOperationDAO());

  // Services
  getIt.registerSingleton<IAccountService>(AccountService());
  getIt.registerSingleton<IFinanceOperationService>(FinanceOperationService());

  // Commands
  getIt.registerSingleton<AccountCommands>(AccountCommands());
  getIt.registerSingleton<FinanceOperationCommands>(FinanceOperationCommands());
}