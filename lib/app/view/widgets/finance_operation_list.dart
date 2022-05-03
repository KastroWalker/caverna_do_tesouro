import 'package:caverna_do_tesouro/app/domain/entities/finance_operation.dart';
import 'package:caverna_do_tesouro/app/domain/interfaces/finance_operation_service.dart';
import 'package:caverna_do_tesouro/app/view/widgets/bg_list_item_remove.dart';
import 'package:caverna_do_tesouro/app/view/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // TODO turn into a widget
        return AlertDialog(
          title: const Text("Remover lançamento"),
          content:
              const Text("Tem certeza que deseja remover esse lançamento?"),
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
                  onDismissed: (direction) async {
                    final isFinanceOperationRemoved = await _financeOperationService
                        .remove(financeOperation.id);

                    if (isFinanceOperationRemoved) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('"${financeOperation.name}" foi removido!'),
                        ),
                      );
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Erro ao remover "${financeOperation.name}"! Tente novamente!'),
                      ),
                    );
                  },
                  confirmDismiss: (direction) async {
                    return await _showConfirmationDialog(context);
                  },
                  key: Key(financeOperation.id.toString()),
                  background: const BGListItemRemove(),
                  child: InkWell(
                    onTap: () {
                      _showOperationInfo(context, financeOperation);
                    },
                    child: ListTile(
                      title: Text(financeOperation.name),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(financeOperation.value.toString()),
                          if (financeOperation.financeOperationType.id == 1)
                            const Icon(Icons.add, color: Colors.green)
                          else
                            const Icon(Icons.remove, color: Colors.red),
                        ],
                      ),
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