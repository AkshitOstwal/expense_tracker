import 'package:expense_tracker/widgets/transaction_list.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

class UserTransaction extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransaction,_editTransaction;
  UserTransaction(this._transactions,this._deleteTransaction,this._editTransaction);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          TransactionList(_transactions,_deleteTransaction,_editTransaction),
        ],
      ),
    );
  }
}
