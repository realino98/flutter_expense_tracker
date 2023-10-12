import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/provider/transactionProvider.dart';
import 'package:flutter_expense_tracker/screens/dashboard_screen.dart';
import 'package:flutter_expense_tracker/screens/profile_screen.dart';
import 'package:flutter_expense_tracker/screens/transaction_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 6, 77, 158)),
        useMaterial3: true,
      ),
      // home: HomeScreen(),
      home: ChangeNotifierProvider(
        create: (context) => TransactionManager(),
        child: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _pages = [
    DashboardScreen(),
    TransactionScreen(),
    ProfileScreen(),
  ];

  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_pageIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value) => setState(() {
          _pageIndex = value;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: "Transaction",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
