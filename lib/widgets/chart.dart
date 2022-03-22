import 'package:first_app/widgets/chartBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/Transcations.dart';
import '../widgets/chartBar.dart';

class Chart extends StatelessWidget {
  final List<TransactionDetails> recentTransactions;
  const Chart({required this.recentTransactions});

// create the list of eachday expense
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (int i = 0; i < recentTransactions.length; i += 1) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'amount': totalSum
      };
    }).reversed.toList();
  }

// calculate total Spending value from the list
  double get totalSpending {
    var total = 0.0;
    for (var item in groupedTransactionValues) {
      total += (item['amount'] as double);
    }
    return total;
  }

  Widget build(BuildContext context) {
    // print(groupedTransactionValues);
    print(totalSpending);
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues.map((data) {
                return Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                        (data['day'] as String),
                        (data['amount'] as double),
                        totalSpending == 0.0
                            ? 0.0
                            : ((data['amount'] as double) / totalSpending)));
              }).toList()),
        ));
  }
}
