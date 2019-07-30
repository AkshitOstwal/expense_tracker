import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Function _addTransaction;
  NewTransaction(this._addTransaction);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Titile',
              hintText: 'Enter the title of expense.',
            ),
            // key: _formKey,
            controller: titleController,
            // onSaved: (String value) {
            //   titleInput = value;
            // },
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Amount',
              hintText: 'Amount spend on expense.',
            ),
            // key: _formKey,
            controller: amountController,
            keyboardType: TextInputType.number,
            // onSaved: (String value) {
            //   amountInput = double.parse(value);
            // },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text('ADD Expense',style: TextStyle(color: Colors.deepPurple),),
                padding: EdgeInsets.all(5),
                onPressed: () {
                  _addTransaction(Transaction(
                    id: DateTime.now().toString(),
                    title: titleController.text,
                    amount: double.parse(amountController.text),
                    date: DateTime.now(),
                  ));
                },
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
