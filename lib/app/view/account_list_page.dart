import 'package:caverna_do_tesouro/app/domain/entities/account.dart';
import 'package:caverna_do_tesouro/app/view/widgets/account_list_item.dart';
import 'package:caverna_do_tesouro/app/view/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../domain/interfaces/account_service.dart';

class AccountListPage extends StatefulWidget {
  const AccountListPage({Key? key}) : super(key: key);

  @override
  State<AccountListPage> createState() => _AccountListPageState();
}

class _AccountListPageState extends State<AccountListPage> {
  final _accountService = GetIt.I.get<IAccountService>();
  static const IconData delete = IconData(0xe1b9, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minhas Contas Bancárias',
          textAlign: TextAlign.center,
        ),
      ),
      body: FutureBuilder<List<Account>?>(
        initialData: const [],
        future: _accountService.listAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.waiting:
              return Loader(text: 'Carregando contas bancárias...');
            case ConnectionState.done:
              final List<Account>? accounts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Account account = accounts![index];
                  return Dismissible(
                    key: Key(account.id.toString()),
                    onUpdate: (info) {
                      // TODO change the side of icons depends on the direction
                    },
                    onDismissed: (direction) {
                      // TODO open dialog to confirm removing
                      // TODO remove account from database and update list
                      // TODO show snackbar with removal message
                    },
                    background: Container(
                      color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(delete, color: Colors.white,),
                          ),
                        ],
                      ),
                    ),
                    child: AccountListItem(account),
                  );
                },
                itemCount: accounts?.length,
              );
          }
          return const Text('Unknown error');
        },
      ),
    );
  }
}
