import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTransaction;
  NewTransaction(this._addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate ;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _openDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _selectedDate == null ? DateTime.now() : _selectedDate,
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((DateTime dateTime) {
      if (dateTime == null) return;
      setState(() {
        _selectedDate = dateTime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: 'Title',
              hintText: 'Enter the title of expense.',
            ),
            // key: _formKey,
            controller: _titleController,
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
            controller: _amountController,
            keyboardType: TextInputType.number,
            // onSaved: (String value) {
            //   amountInput = double.parse(value);
            // },
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  _selectedDate == null
                      ? 'No date chosen'
                      : 'Choosen Date : ${DateFormat.yMd().format(_selectedDate)}',
                ),
              ),
              FlatButton(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Choose Date',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.purple),
                ),
                onPressed: _openDatePicker,
              ),
              SizedBox(
                width: 15,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text(
                  'ADD Expense',
                  style: TextStyle(color: Colors.white),
                ),
                padding: EdgeInsets.all(10),
                onPressed: () {
                  print((_titleController.text));
                  if (_amountController.text == null ||
                      _titleController.text == '' || _selectedDate == null) {
                    return null;
                  }
                  widget._addTransaction(Transaction(
                    id: DateTime.now().toString(),
                    title: _titleController.text,
                    amount: double.parse(_amountController.text),
                    date: _selectedDate,
                  ));
                  Navigator.of(context).pop();
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
