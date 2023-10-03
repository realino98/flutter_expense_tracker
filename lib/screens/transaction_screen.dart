import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/transaction_model.dart';
import 'package:flutter_expense_tracker/provider/transactionProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionManager>(
      builder: (context, value, child) {
        // List amount = value.transactions.map((e) => e.amount).toList();
        var transactionData = value.transactions
            .where((element) => element.source == value.cardSelected)
            .toList();
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => value.cardSelect(0),
                        child: Text("Card 0"),
                      ),
                      ElevatedButton(
                        onPressed: () => value.cardSelect(1),
                        child: Text("Card 1"),
                      ),
                      ElevatedButton(
                        onPressed: () => value.cardSelect(2),
                        child: Text("Card 2"),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            //Total Balance
                            Container(
                              width: double.infinity,
                              child: Card(
                                color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Total Balance",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "Rp. ${value.countBalaceTotal()}",
                                        // textScaleFactor: 3,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Income
                            Card(
                              color: Colors.yellow,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Income",
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_downward_rounded,
                                          size: 50,
                                          color: Colors.green,
                                        ),
                                        Text(
                                          "Rp. ${value.countIncome()}",
                                          // textScaleFactor: 2.5,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              color: Colors.orange,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Outcome",
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_upward_rounded,
                                          size: 50,
                                          color: Colors.red,
                                        ),
                                        Text(
                                          "Rp. ${value.countOutcome()}",
                                          // textScaleFactor: 2.5,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Divider(),
                Expanded(
                  flex: 5,
                  child: ListView.builder(
                    itemCount: transactionData.length,
                    itemBuilder: (context, index) {
                      DateTime transactionTime =
                          transactionData[index].dateTime;
                      var dateFormatter = new DateFormat('yyyy-MM-dd');
                      var timeFormatter = new DateFormat('hh:mm');
                      bool isIncome = transactionData[index].isIncome;
                      return ListTile(
                        leading: isIncome
                            ? Icon(
                                Icons.arrow_downward_rounded,
                                color: Colors.green,
                                size: 40,
                              )
                            : Icon(
                                Icons.arrow_upward_rounded,
                                color: Colors.red,
                                size: 40,
                              ),
                        title: Text(
                          transactionData[index].needs,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            isIncome
                                ? Icon(
                                    Icons.add_rounded,
                                    size: 15,
                                  )
                                : Icon(
                                    Icons.remove_rounded,
                                    size: 15,
                                  ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Rp. ${transactionData[index].amount.toString()}",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              dateFormatter.format(transactionTime),
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              timeFormatter.format(transactionTime),
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              value.addTransaction(
                Transaction(
                  amount: 10123,
                  isIncome: false,
                  needs: "Entertainment",
                  source: 1,
                  dateTime: DateTime.now(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
