import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/transaction_model.dart';
import 'package:flutter_expense_tracker/provider/transactionProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
            // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
  }

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
                        style: ButtonStyle(
                            padding:
                                MaterialStatePropertyAll(EdgeInsets.all(20))),
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
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 20,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                            ),
                            Card(
                              color: Colors.orange,
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 20,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Rp. ${value.countOutcome()}",
                                            // textScaleFactor: 2.5,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_upward_rounded,
                                            size: 50,
                                            color: Colors.red,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
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
                                size: 30,
                              )
                            : Icon(
                                Icons.arrow_upward_rounded,
                                color: Colors.red,
                                size: 30,
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
              addTransactionDialog(context);
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

  Future<dynamic> addTransactionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          height: 400,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Add New Transaction",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Name",
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueGrey.shade500, width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueGrey.shade300, width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Amount",
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueGrey.shade500, width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueGrey.shade300, width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Amount",
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueGrey.shade500, width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.blueGrey.shade300, width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  ),
                ),
              ),
              Row(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Amount",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blueGrey.shade500, width: 2.0),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blueGrey.shade300, width: 2.0),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Amount",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blueGrey.shade500, width: 2.0),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blueGrey.shade300, width: 2.0),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                  ),
                ],
              ),

              // SfDateRangePicker(
              //   onSelectionChanged: _onSelectionChanged,
              //   selectionMode: DateRangePickerSelectionMode.range,
              //   initialSelectedRange: PickerDateRange(
              //       DateTime.now().subtract(const Duration(days: 4)),
              //       DateTime.now().add(const Duration(days: 3))),
              // ),
              ElevatedButton(onPressed: () {}, child: Text("Submit")),
            ],
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
      ),
    );
  }

  buildTextField() {}
}
