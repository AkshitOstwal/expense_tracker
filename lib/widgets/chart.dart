import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransation;
  Chart(this.recentTransation);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.00;
      for (var i = 0; i < recentTransation.length; i++) {
        if (recentTransation[i].date.day == weekDay.day &&
            recentTransation[i].date.month == weekDay.month &&
            recentTransation[i].date.year == weekDay.year) {
              totalSum += recentTransation[i].amount;
            }
      }
      print('inside chart');
      print(DateFormat.E().format(weekDay));
      print(totalSum);
      return {
        'day': DateFormat.E().format(weekDay).substring(0,2),
        'amount': totalSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children:groupedTransactionValues.map((data){
          return Text("${data['day']} : ${data['amount']}");
        }).toList(),
      ),
    );
  }
}
