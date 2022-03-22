import 'package:first_app/models/Transcations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final addNewTransactions;

  NewTransactions({this.addNewTransactions});
  State createState() {
    return NewTransactionsState(addNewTransactions: addNewTransactions);
  }
}

class NewTransactionsState extends State<NewTransactions> {
  var titleController = TextEditingController();
  var amountController = TextEditingController();
  final addNewTransactions;
  var selectedDate;

  void submitData() {
    String title = titleController.text;
    double amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0.0 || selectedDate == null) return;

    addNewTransactions(TransactionDetails(
        id: 't4', title: title, amount: amount, date: selectedDate));

    Navigator.of(context).pop();
  }

  NewTransactionsState({this.addNewTransactions});

  void presentDatePicker(context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: titleController,
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: amountController,
            keyboardType: TextInputType.number,
          ),
          Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(selectedDate == null
                      ? "No Date is Chosen!"
                      : 'Picked Date: ${DateFormat.yMd().format(selectedDate)}'),
                  FlatButton(
                    onPressed: () {
                      presentDatePicker(context);
                    },
                    child: Text('Choose Date',
                        style: TextStyle(
                            color: Colors.purple, fontWeight: FontWeight.bold)),
                  )
                ],
              )),
          RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text(
                'Add Transaction',
              ),
              onPressed: () => submitData())
        ]),
      ),
    );
  }
}
