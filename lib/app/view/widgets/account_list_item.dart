import 'package:flutter/material.dart';

import '../../domain/entities/account.dart';

class AccountListItem extends StatelessWidget {
  final Account account;

  const AccountListItem(this.account, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(account.name),
      subtitle:
          Text('${account.balance.toString()} - ${account.id.toString()}'),
    );
  }
}
