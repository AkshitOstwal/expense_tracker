import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/new_transaction.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';

import './models/transaction.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        accentColor: Colors.purple,
        fontFamily: 'OpenSans',
        textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        buttonTheme:
            ThemeData.light().buttonTheme.copyWith(buttonColor: Colors.purple),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ) //TextStyle(fontFamily: 'OpenSans',fontSize: 20),
                  ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];
  List<Transaction> get _recentTransaction {
    return _transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  Future<void> _deleteWarning(Transaction tx) {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure ?'),
          content: SingleChildScrollView(
            child: Text("The expense once deleted can't be retrived"),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                'Delete',
                style: TextStyle(
                    color: Colors.purple, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                setState(() {
                  _transactions.removeWhere((txn) => txn.id == tx.id);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addTransaction(Transaction tx) {
    setState(() {
      _transactions.add(tx);
    });
  }

  void _deleteTransaction(Transaction tx) {
    _deleteWarning(tx);
  }

  void _editTransaction(Transaction tx) {
    setState(() {
      _transactions.removeWhere((txn) => (txn.id == tx.id));
      _transactions.add(tx);
    });
  }

  void showAddTransaction(BuildContext ctx) {
    showModalBottomSheet(isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return NewTransaction(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text('Expense Tracker'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add_circle_outline),
          iconSize: 30,
          onPressed: () => showAddTransaction(context),
        ),
      ],
    );
    double availableHeight = (MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top);
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
              child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? availableHeight * 0.43
                        : availableHeight * 0.30,
                width: double.infinity,
                child: Chart(_recentTransaction),
              ),
              Container(
                height: MediaQuery.of(context).orientation == Orientation.landscape
                        ? availableHeight * 0.57 : availableHeight * 0.70 ,
                child: TransactionList(
                    _transactions, _deleteTransaction, _editTransaction),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showAddTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
