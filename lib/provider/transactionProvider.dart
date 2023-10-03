import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_expense_tracker/models/category_model.dart';
import 'package:flutter_expense_tracker/models/transaction_model.dart';
import 'package:intl/intl.dart';

class TransactionManager extends ChangeNotifier {
  var formatter = NumberFormat('#,###');
  int _cardSelected = 1;
  DateTime _currentDate = DateTime.now();
  List<Category> _categories = [];
  final List<Transaction> _transactions = <Transaction>[
    Transaction(
        amount: 1000000,
        isIncome: true,
        needs: "Salary",
        source: 1,
        dateTime: DateTime.now()),
    Transaction(
        amount: 10000,
        isIncome: true,
        needs: "Park",
        source: 1,
        dateTime: DateTime.now()),
    Transaction(
        amount: 10000,
        isIncome: true,
        needs: "Bill",
        source: 1,
        dateTime: DateTime.now()),
    Transaction(
        amount: 10000,
        isIncome: false,
        needs: "Food",
        source: 1,
        dateTime: DateTime.now()),
    Transaction(
        amount: 10000,
        isIncome: false,
        needs: "Food",
        source: 1,
        dateTime: DateTime.now()),
    Transaction(
        amount: 10000,
        isIncome: false,
        needs: "Food",
        source: 2,
        dateTime: DateTime.now()),
    Transaction(
        amount: 10000,
        isIncome: true,
        needs: "Food",
        source: 0,
        dateTime: DateTime.now()),
  ];
  List<Category> get categoriesList => fetchCategories();
  List<Category> get categories => _categories;
  List<Transaction> get transactions => List.unmodifiable(_transactions);
  List<Transaction> get transactionsFiltered => _transactions
      .where((element) => element.source == _cardSelected)
      .toList();
  int get cardSelected => _cardSelected;
  int get currentMonth => int.parse(DateFormat("mm").format(_currentDate));

  List<Category> fetchCategories() {
    List<String> _categoriesTemp = [];
    for (int i = 0; i < _transactions.length; i++) {
      if (!_categoriesTemp.contains(_transactions[i].needs))
        _categoriesTemp.add(_transactions[i].needs);
    }
    print(_categoriesTemp);
    _categories.clear();
    for (var cat in _categoriesTemp) {
      _categories.add(Category(
          categoryName: cat,
          color: Colors.green,
          icon: Icon(Icons.money),
          itemTotal: _transactions
              .where((element) => element.needs == cat)
              .toList()
              .length,
          total: countTotal(_transactions
              .where((element) => element.needs == cat)
              .toList())));
    }
    // print(_categories.length);
    return _categories;
  }

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }

  void removeTransaction(Transaction transaction) {
    _transactions.remove(transaction);
    notifyListeners();
  }

  countTotal(List<Transaction> transactions_to_count) {
    if (_transactions.isNotEmpty) {
      return transactions_to_count
          .map((e) => e.amount)
          .reduce((value, element) => value + element);
    }
  }

  countBalaceTotal() {
    // return countIncome() - countOutcome();
    var total =
        formatter.format(int.parse(countIncome()) - int.parse(countOutcome()));
    return total;
  }

  countIncome() {
    if (transactionsFiltered
        .where((element) => element.isIncome == true)
        .toList()
        .isNotEmpty) {
      return (countTotal(transactionsFiltered
              .where((element) => element.isIncome == true)
              .toList())
          .toString());
    } else {
      return "0";
    }
  }

  countOutcome() {
    if (transactionsFiltered
        .where((element) => element.isIncome == false)
        .toList()
        .isNotEmpty) {
      return countTotal(transactionsFiltered
              .where((element) => element.isIncome == false)
              .toList())
          .toString();
    } else {
      return "0";
    }
  }

  cardSelect(int selected) {
    _cardSelected = selected;
    print("Card Selected : ${_cardSelected}");
    print(transactionsFiltered.map((e) => e.isIncome));
    notifyListeners();
  }
}
