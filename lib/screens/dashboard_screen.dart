import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/models/transaction_model.dart';
import 'package:flutter_expense_tracker/provider/transactionProvider.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Widget> _months = [
    Text("Jan"),
    Text("Feb"),
    Text("Mar"),
    Text("Apr"),
    Text("May"),
    Text("Jun"),
    Text("Jul"),
    Text("Aug"),
    Text("Sep"),
    Text("Oct"),
    Text("Nov"),
    Text("Dec")
  ];

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    return Consumer<TransactionManager>(builder: (context, value, child) {
      print(value.currentMonth);
      return DefaultTabController(
        length: 12,
        // initialIndex: value.currentMonth,
        child: Scaffold(
          appBar: AppBar(
            title: TabBar(
              unselectedLabelColor: Colors.blue.withOpacity(0.6),
              isScrollable: true,
              tabs: [..._months],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 2,
                child: Card(
                  child: Container(
                    width: maxWidth,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Hello"),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: ListView(
                  children: [
                    _buildCategoryListTile(value, "Salary",
                        Icon(Icons.money_rounded), Colors.green),
                    _buildCategoryListTile(value, "Food",
                        Icon(Icons.food_bank_rounded), Colors.orange),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  _buildCategoryListTile(
      TransactionManager value, String category, Icon icon, Color color) {
    List<Transaction> val = value.transactions
        .where((element) => element.needs == category)
        .toList();
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: color,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: icon,
          ),
        ),
      ),
      title: Text(category),
      subtitle: Text("${val.length}"),
      trailing: Text(
        "Rp. ${value.countTotal(val)}",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
