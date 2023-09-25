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
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Name"),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.more_vert),
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
                            color: Color.fromARGB(255, 0, 130, 139)),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Grand Total",
                                  textScaleFactor: 2,
                                ),
                                Text(
                                  'Rp. ${12341234}',
                                  textScaleFactor: 3,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 70,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                          "Rp. 40.000",
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
                                          "Rp. 40.000",
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
                Divider(),
                Expanded(
                  flex: 5,
                  child: ListView.builder(
                    itemCount: value.transactions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: value.transactions[index].isIncome
                            ? Icon(Icons.arrow_upward, color: Colors.green)
                            : Icon(
                                Icons.arrow_downward,
                                color: Colors.red,
                              ),
                        title:
                            Text(value.transactions[index].amount.toString()),
                        subtitle: Text(value.transactions[index].needs),
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
                  amount: 10000,
                  isIncome: true,
                  needs: "Food",
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
