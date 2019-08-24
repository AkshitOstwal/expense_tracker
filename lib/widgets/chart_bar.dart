
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount, spendingPctOfTotal;
  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  String getCurrencyString(double amt) {
    if (amt >= 100000000) {
      return '₹${(amt / 100000000).toStringAsFixed(2)} B';
    } else if (amt >= 1000000) {
      return '₹${(amt / 1000000).toStringAsFixed(2)} M';
    } else if (amt >= 1000) {
      return '₹${(amt / 1000).toStringAsFixed(2)} K';
    } else
      return '₹${(amt).toStringAsFixed(1)}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(getCurrencyString(spendingAmount)),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 80,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    );
  }
}
