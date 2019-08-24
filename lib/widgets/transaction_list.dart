import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTransaction;
  TransactionList(this.transactions, this._deleteTransaction);
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
    return Container(
      height: 450,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Text(
                  'No Transaction Found',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                  height: 300,
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).accentColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        getCurrencyString(transactions[index].amount),
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMEd()
                          .format(transactions[index].date),
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry>[
                          PopupMenuItem(
                            child: ListTile(
                              leading: Icon(
                                Icons.edit,
                                color: Colors.purple,
                              ),
                              title: Text(
                                'Edit',
                                style: TextStyle(fontSize: 15),
                              ),
                              dense: true,
                            ),
                            value: 'edit',
                          ),
                          PopupMenuItem(
                            child: ListTile(
                              leading: Icon(
                                Icons.delete,
                                color: Theme.of(context).errorColor,
                              ),
                              title: Text(
                                'Delete',
                                style: TextStyle(fontSize: 15),
                              ),
                              dense: true,
                            ),
                            value: 'delete',
                          ),
                        ];
                      },
                      onSelected: (value) {
                        if (value == 'delete')
                          _deleteTransaction(transactions[index]);
                      },
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
