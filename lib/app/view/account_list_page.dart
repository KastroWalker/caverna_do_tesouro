import 'package:caverna_do_tesouro/app/domain/entities/account.dart';
import 'package:caverna_do_tesouro/app/view/widgets/account_list_item.dart';
import 'package:caverna_do_tesouro/app/view/widgets/bg_list_item_remove.dart';
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

  // TODO refresh data when scrolling the page

  Future<bool?> _showConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // TODO turn into a widget
        return AlertDialog(
          title: const Text("Remover conta bancária"),
          content:
              const Text("Tem certeza que deseja remover essa conta bancária?"),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Remover"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
              return const Loader(text: 'Carregando contas bancárias...');
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
                    onDismissed: (direction) async {
                      // TODO remove account from database and update list
                      // TODO show alert message if the account is in using
                      final isAccountRemoved =
                          await _accountService.remove(account.id);

                      if (isAccountRemoved) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('"${account.name}" foi removida!'),
                          ),
                        );
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Erro ao remover "${account.name}"! Tente novamente!'),
                        ),
                      );
                    },
                    confirmDismiss: (direction) async {
                      return await _showConfirmationDialog(context);
                    },
                    background: const BGListItemRemove(),
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

