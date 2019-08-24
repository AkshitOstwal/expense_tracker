import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditTransaction extends StatefulWidget {
  final Function _editTransaction;
  final Transaction txn;
  EditTransaction(this._editTransaction, this.txn);

  @override
  _EditTransactionState createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  

  void _openDatePicker() {
    showDatePicker(
      context: context,
      initialDate: widget.txn.date,
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
    if(_titleController.text == widget.txn.title || _titleController.text == '') 
      _titleController.text = widget.txn.title;
    else _titleController.text = _titleController.text;

    if(_amountController.text == widget.txn.amount.toString() || _amountController.text == '') 
      _amountController.text = widget.txn.amount.toString();
    else _amountController.text = _amountController.text;

    if(_selectedDate == widget.txn.date || _selectedDate == null)
      _selectedDate = widget.txn.date;
    else _selectedDate = _selectedDate;

    return SimpleDialog(
      elevation: 10,
      title: Text('Edit Expense',style: TextStyle(color: Colors.purple),),
      children: <Widget>[
        Container(
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
                          _titleController.text == '' ||
                          _selectedDate == null) {
                        return null;
                      }
                      widget._editTransaction(Transaction(
                        id: widget.txn.id,
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
        ),
      ],
    );
  }
}
