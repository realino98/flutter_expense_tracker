import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/transaction_model.dart';
import 'package:flutter_expense_tracker/provider/transactionProvider.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: List.empty(),
                            color: Color.fromARGB(255, 52, 96, 216)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Total Balance",
                                    textScaleFactor: 2,
                                  ),
                                  Text(
                                    "Rp. ${value.countBalaceTotal()}",
                                    textScaleFactor: 3,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Income",
                                        textScaleFactor: 2,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_downward,
                                            size: 50,
                                            color: Colors.green,
                                          ),
                                          Text(
                                            "Rp. ${value.countIncome()}",
                                            textScaleFactor: 2.5,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Outcome",
                                        textScaleFactor: 2,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.arrow_upward,
                                            size: 50,
                                            color: Colors.red,
                                          ),
                                          Text(
                                            "Rp. ${value.countOutcome()}",
                                            textScaleFactor: 2.5,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(),
                Expanded(
                  flex: 5,
                  child: ListView.builder(
                    itemCount: transactionData.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: transactionData[index].isIncome
                            ? Icon(Icons.arrow_downward, color: Colors.green)
                            : Icon(
                                Icons.arrow_upward,
                                color: Colors.red,
                              ),
                        trailing: Text(
                            "Rp. ${transactionData[index].amount.toString()}"),
                        subtitle: Text(transactionData[index].needs),
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
                  source: 0,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
