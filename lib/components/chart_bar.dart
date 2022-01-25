import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    Key? key,
    required this.label,
    required this.spendingAmount,
    required this.spendingTotal,
  }) : super(key: key);

  final String label;
  final double spendingAmount;
  final double spendingTotal;

  double get _chartPercentage =>
      spendingTotal == 0 ? 0 : spendingAmount / spendingTotal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('\$${spendingAmount.toStringAsFixed(0)}'),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 60,
          width: 10,
          child: null,
        ),
        SizedBox(
          height: 5,
        ),
        Text(label),
      ],
    );
  }
}
