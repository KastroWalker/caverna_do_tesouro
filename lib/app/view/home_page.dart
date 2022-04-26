import 'package:caverna_do_tesouro/app/domain/entities/finance_operation.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/finance_operation_service.dart';
import 'package:caverna_do_tesouro/app/view/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../my_app.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

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
          FinanceOperationList(),
          ElevatedButton(onPressed: () {
            Navigator.pushNamed(context, MyApp.accountListPage);
          }, child: const Text('Contas Bancárias'),),
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FinanceOperation>?>(
      initialData: const [],
      future: _financeOperationService.listAll(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.active:
            break;
          case ConnectionState.waiting:
            return const Loader(text: 'Carregando contas bancárias...');
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
                return ListTile(
                  title: Text(financeOperation.name),
                  subtitle: Text(financeOperation.value.toString()),
                );
              },
              itemCount: financeOperations!.length,
            );
        }
        return const Text('Unknown error');
      },
    );
  }
}
