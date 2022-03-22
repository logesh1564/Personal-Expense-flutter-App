import 'package:flutter/material.dart';
import '../models/Transcations.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatelessWidget {
  final List<TransactionDetails> transactions;
  final Function deleteTransactions;
  TransactionsList(
      {required this.transactions, required this.deleteTransactions});

  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                              child: Text('\$${transactions[index].amount}'))),
                    ),
                    title: Text(
                      transactions[index].title,
                      // style: Theme.of(context).textTheme.title
                    ),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date)),
                    trailing: IconButton(
                      color: Colors.red,
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        deleteTransactions(transactions[index].id.toString());
                      },
                    )));
          },
        ));
  }
}
