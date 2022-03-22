import 'dart:ffi';

import 'package:flutter/material.dart';
import './transaction_list.dart';
import './new_transaction.dart';
import '../models/Transcations.dart';

class UserTransactions extends StatelessWidget {
  final List<TransactionDetails> transactions;
  Function deleteTransactions;
  UserTransactions({required this.transactions, required  this.deleteTransactions});

  Widget build(BuildContext) {
    return Column(children: [
      // NewTransactions(addValues: addNewTransactions),
      TransactionsList(transactions: transactions, deleteTransactions: deleteTransactions,)
    ]);
  }
}
