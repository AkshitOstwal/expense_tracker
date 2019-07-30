import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          TextFormField(
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
          TextFormField(
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
          FlatButton(
            child: Text('ADD'),
            padding: EdgeInsets.all(5),
            onPressed: () {
              _formKey.currentState.save();
              print(titleController);
              print(amountController);
            },
          ),
        ],
      ),
    );
  }
}
