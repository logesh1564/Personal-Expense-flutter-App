import 'package:first_app/widgets/user_transactions.dart';
import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './models/Transcations.dart';
import './widgets/user_transactions.dart';
import './widgets/chart.dart';

void main() {
  runApp(Index());
}

class Index extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Personal Expenses',
        home: MyApp(),
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.blue,
            fontFamily: 'QuickSand',
            appBarTheme: AppBarTheme(
                titleTextStyle: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold))));
  }
}

class MyApp extends StatefulWidget {
  State createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  List<TransactionDetails> transactions = [
    TransactionDetails(
        id: 't1', title: 'New Shoes', amount: 88.9, date: DateTime.now()),
    TransactionDetails(
        id: 't2', title: 'New Dresses', amount: 88.9, date: DateTime.now()),
    TransactionDetails(
        id: 't3', title: 'New bag', amount: 88.9, date: DateTime.now())
  ];

  List<TransactionDetails> get _recentTransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransactions(addNewTransactions: addNewTransactions),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void addNewTransactions(TransactionDetails data) {
    setState(() {
      transactions.add(data);
    });
  }

  void deleteTransactions(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Chart(recentTransactions: _recentTransactions),
          UserTransactions(
              transactions: transactions,
              deleteTransactions: deleteTransactions)
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
