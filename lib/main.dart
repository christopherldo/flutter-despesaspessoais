import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _transactions = [
      Transaction(
        id: 't1',
        title: 'Novo Tênis de Corrida',
        value: 310.76,
        date: DateTime.now(),
      ),
      Transaction(
        id: 't2',
        title: 'Conta de Luz',
        value: 211.30,
        date: DateTime.now(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Card(
              color: Colors.blue,
              child: Text('Gráfico'),
              elevation: 5,
            ),
          ),
          Column(
            children: [
              ..._transactions
                  .map(
                    (e) => Card(
                      child: Row(
                        children: [
                          Container(
                            child: Text(e.value.toString()),
                          ),
                          Column(
                            children: [
                              Text(e.title),
                              Text(e.date.toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ],
      ),
    );
  }
}
