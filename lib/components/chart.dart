import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  final List<Transaction> recentTransactions;

  final _dateToPortuguese = const {
    'Sun': 'DOM',
    'Mon': 'SEG',
    'Tue': 'TER',
    'Wed': 'QUA',
    'Thu': 'QUI',
    'Fri': 'SEX',
    'Sat': 'SÁB',
  };

  List<Map<String, Object>> get groupedTransactions {
    final groupedTransactions = <Map<String, Object>>[];

    final weekDayIndexOfTransaction = recentTransactions
        .map((transaction) => DateFormat.E().format(transaction.date))
        .toList();

    for (var i = 0; i < weekDayIndexOfTransaction.length; i++) {
      var currentDay = weekDayIndexOfTransaction[i];
      var currentDayTransactions = recentTransactions
          .where((transaction) =>
              DateFormat.E().format(transaction.date) == currentDay)
          .toList();

      if (groupedTransactions
          .where((element) => element['day'] == _dateToPortuguese[currentDay])
          .isEmpty) {
        groupedTransactions.add(
          {
            'day': _dateToPortuguese[currentDay] as String,
            'value': currentDayTransactions.fold<double>(
              0,
              (accumulator, transaction) => accumulator + transaction.value,
            ),
          },
        );
      }
    }

    _dateToPortuguese.forEach(
      (key, value) {
        if (groupedTransactions
            .where((element) => element['day'] == value)
            .isEmpty) {
          groupedTransactions.add(
            {
              'day': value,
              'value': 0.0,
            },
          );
        }
      },
    );

    final listOrder = [
      'DOM',
      'SEG',
      'TER',
      'QUA',
      'QUI',
      'SEX',
      'SÁB',
    ];

    groupedTransactions.sort(
      (a, b) {
        final indexA = listOrder.indexOf(a['day'] as String);
        final indexB = listOrder.indexOf(b['day'] as String);

        return indexA.compareTo(indexB);
      },
    );

    return groupedTransactions;
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(
      0.0,
      (sum, item) {
        return sum + (item['value'] as double);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ...groupedTransactions.map(
              (data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: data['day'].toString(),
                    spendingAmount: data['value'] as double,
                    spendingTotal: _weekTotalValue,
                  ),
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}
