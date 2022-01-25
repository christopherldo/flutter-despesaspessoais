import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  final List<Transaction> recentTransactions;

  final List<String> _weekDays = const [
    'DOM',
    'SEG',
    'TER',
    'QUA',
    'QUI',
    'SEX',
    'SÁB',
  ];

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(
      7,
      (index) {
        // Get the date of the last sunday till saturday
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );

        double totalSum = 0.0;

        for (var i = 0; i < recentTransactions.length; i++) {
          bool sameDay = recentTransactions[i].date.day == weekDay.day;

          if (sameDay) {
            totalSum += recentTransactions[i].value;
          }
        }

        return {
          'day': _weekDays[index],
          'value': totalSum,
        };
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: [
          ...groupedTransactions.map(
            (data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: data['day'].toString(),
                  spendingAmount:
                      double.tryParse(data['value'].toString()) ?? 0,
                  spendingTotal: 500,
                ),
              );
            },
          ).toList(),
        ],
      ),
    );
  }
}
