import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    Key? key,
    required this.transactions,
    required this.onDelete,
  }) : super(key: key);

  final List<Transaction> transactions;
  final void Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                Text(
                  'Nenhuma Transação Cadastrada!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                Image.asset(
                  'assets/images/waiting.png',
                  height: constraints.maxHeight * 0.6,
                  fit: BoxFit.cover,
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) => Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: FittedBox(
                      child: Text(
                        'R\$${transactions[index].value.toStringAsFixed(2)}',
                      ),
                    ),
                  ),
                ),
                title: Text(
                  transactions[index].title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Text(
                  DateFormat('dd MMM yyyy').format(transactions[index].date),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                  ),
                  color: Theme.of(context).errorColor,
                  onPressed: () => onDelete(transactions[index].id),
                ),
              ),
            ),
          );
  }
}
