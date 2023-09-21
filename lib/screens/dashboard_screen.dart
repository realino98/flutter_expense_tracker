import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          "Grand Total",
                          textScaleFactor: 2,
                        ),
                        Text(
                          "Rp. 123.000",
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
            Divider(),
            Expanded(
              flex: 5,
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.arrow_upward_rounded),
                    title: Text("40000"),
                    subtitle: Text("Makan"),
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_downward_rounded),
                    title: Text("40000"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
    );
  }
}
