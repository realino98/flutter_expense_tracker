import 'package:fl_chart/fl_chart.dart';
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
      value.fetchCategories();
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
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Center(
                        child: PieChart(
                          PieChartData(
                            sections: [
                              for (int x = 1;
                                  x < value.categoriesList.length;
                                  x++) ...[
                                PieChartSectionData(
                                    color: value.categoriesList[x].color,
                                    value: value.categoriesList[x].total
                                        .toDouble(),
                                    title: value.categoriesList[x].categoryName)
                              ],
                            ],
                            centerSpaceRadius: double.infinity,
                            // read about it in the PieChartData section
                          ),
                          swapAnimationDuration:
                              Duration(milliseconds: 150), // Optional
                          swapAnimationCurve: Curves.linear, // Optional
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                // child: ListView(
                //   children: [
                //     _buildCategoryListTile(value, "Salary",
                //         Icon(Icons.money_rounded), Colors.green),
                //     _buildCategoryListTile(value, "Food",
                //         Icon(Icons.food_bank_rounded), Colors.orange),
                //   ],
                // ),
                child: ListView.builder(
                  itemCount: value.categoriesList.length,
                  itemBuilder: (context, index) {
                    var val = value.categoriesList[index];
                    return _buildCategoryListTile(
                        val.categoryName,
                        Icon(Icons.money_rounded),
                        Colors.green,
                        val.itemTotal,
                        val.total);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  _buildCategoryListTile(
      String category, Icon icon, Color color, int itemTotal, int total) {
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
      subtitle: Text("${itemTotal}"),
      trailing: Text(
        "Rp. ${total}",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
