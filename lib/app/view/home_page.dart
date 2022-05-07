import 'package:caverna_do_tesouro/app/view/widgets/finance_operation_list.dart';
import 'package:caverna_do_tesouro/app/view/widgets/financial_information.dart';
import 'package:flutter/material.dart';

import '../my_app.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// TODO Create controller to handle the logic
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Caverna do Tesouro',
          textAlign: TextAlign.left,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 24),
            child: const Text(
              'Receitas',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FinancialInformation(),
          Container(
            padding: const EdgeInsets.only(top: 24),
            child: const Text(
              'Lançamentos',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FinanceOperationList(),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, MyApp.accountListPage);
            },
            child: const Text('Contas Bancárias'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, MyApp.chatPage)
                    .then((value) => setState(() {}));
              },
              child: const Text('Nova Atividade'),
            ),
          ),
        ],
      ),
    );
  }
}