import 'package:caverna_do_tesouro/app/domain/entities/finance_operation.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/finance_operation_service.dart';
import 'package:caverna_do_tesouro/app/view/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../domain/entities/total_financial_operation.dart';
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
                Navigator.pushNamed(context, MyApp.chatPage);
              },
              child: const Text('Nova Atividade'),
            ),
          ),
        ],
      ),
    );
  }
}

class FinanceOperationList extends StatelessWidget {
  final _financeOperationService = GetIt.I.get<IFinanceOperationService>();

  FinanceOperationList({Key? key}) : super(key: key);

  // TODO extract to a external widget
  void _showOperationInfo(BuildContext context, FinanceOperation operation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          operation.name,
          textAlign: TextAlign.center,
        ),
        content: SizedBox(
          height: 200,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Valor:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(operation.value.toString()),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tipo de lançamento:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(operation.financeOperationType.id == 1
                    ? 'Entrada'
                    : 'Saída'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Conta Bancária:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(operation.income.name),
              ],
            ),
          ],
        ),),
        // actions: [
        //   FlatButton(
        //     child: const Text('OK'),
        //     onPressed: () => Navigator.pop(context),
        //   ),
        // ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FinanceOperation>>(
      initialData: const [],
      future: _financeOperationService.listAll(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.active:
            break;
          case ConnectionState.waiting:
            return const Loader(text: 'Carregando lançamentos...');
          case ConnectionState.done:
            if (snapshot.hasError) {
              return const Text('Erro ao carregar lançamentos');
            }
            final List<FinanceOperation>? financeOperations = snapshot.data;
            return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final FinanceOperation financeOperation =
                    financeOperations![index];
                return Dismissible(
                  key: Key(financeOperation.id.toString()),
                  child: InkWell(
                    onTap: () {
                      _showOperationInfo(context, financeOperation);
                    },
                    child: ListTile(
                      title: Text(financeOperation.name),
                      subtitle: Text(financeOperation.value.toString()),
                    ),
                  ),
                );
              },
              itemCount: financeOperations?.length,
            );
        }
        return const Text('Unknown error');
      },
    );
  }
}

class FinancialInformation extends StatelessWidget {
  final _financeOperationService = GetIt.I.get<IFinanceOperationService>();

  FinancialInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TotalFinancialOperations>(
      initialData: TotalFinancialOperations(totalEntry: 0, totalExpense: 0),
      future: _financeOperationService.getFinancialInformation(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.active:
            break;
          case ConnectionState.waiting:
            return const Loader(text: 'Carregando lançamentos...');
          case ConnectionState.done:
            if (snapshot.hasError) {
              return const Text('Erro ao carregar dados financeiros!');
            }

            final TotalFinancialOperations totalFinancialOperations = snapshot.data!;

            final totalEntry = totalFinancialOperations.totalEntry.toStringAsFixed(2);
            final totalExpense = totalFinancialOperations.totalExpense.toStringAsFixed(2);
            final totalBalance = totalFinancialOperations.totalBalance.toStringAsFixed(2);

            return Container(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FinancialOperationCard(
                    title: 'Entradas',
                    value: totalEntry,
                    textColor: Colors.green,
                  ),
                  FinancialOperationCard(
                    title: 'Saídas',
                    value: totalExpense,
                    textColor: Colors.red,
                  ),
                  FinancialOperationCard(
                    title: 'Balanço',
                    value: totalBalance,
                    textColor: Colors.blue,
                  ),
                ],
              ),
            );
        }
        return const Text('Unknown error');
      },
    );
  }
}

class FinancialOperationCard extends StatelessWidget {
  final String title;
  final Color textColor;
  final String value;

  const FinancialOperationCard(
      {Key? key,
      required this.title,
      required this.textColor,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xffdfdfdf)),
        color: const Color(0xfff8f8f8),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text('R\$ $value', style: TextStyle(color: textColor, fontSize: 16)),
        ],
      ),
    );
  }
}