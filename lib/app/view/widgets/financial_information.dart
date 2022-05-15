import 'package:caverna_do_tesouro/app/domain/entities/total_financial_operation.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/finance_operation_service.dart';
import 'package:caverna_do_tesouro/app/view/widgets/financial_operation_card.dart';
import 'package:caverna_do_tesouro/app/view/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';


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
            return const Loader(text: 'Carregando dados financeiros...');
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
                    cardColor: Colors.green,
                  ),
                  FinancialOperationCard(
                    title: 'Saídas',
                    value: totalExpense,
                    cardColor: Colors.red,
                  ),
                  FinancialOperationCard(
                    title: 'Balanço',
                    value: totalBalance,
                    cardColor: Colors.blue,
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