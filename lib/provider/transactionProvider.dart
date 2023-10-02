import 'package:flutter/widgets.dart';
import 'package:flutter_expense_tracker/models/transaction_model.dart';
import 'package:intl/intl.dart';

class TransactionManager extends ChangeNotifier {
  var formatter = NumberFormat('#,###');
  int _cardSelected = 1;
  final List<Transaction> _transactions = <Transaction>[
    Transaction(
        amount: 10000,
        isIncome: true,
        needs: "food",
        source: 1,
        dateTime: DateTime.now()),
    Transaction(
        amount: 10000,
        isIncome: true,
        needs: "food",
        source: 1,
        dateTime: DateTime.now()),
    Transaction(
        amount: 10000,
        isIncome: true,
        needs: "food",
        source: 1,
        dateTime: DateTime.now()),
    Transaction(
        amount: 10000,
        isIncome: false,
        needs: "food",
        source: 1,
        dateTime: DateTime.now()),
    Transaction(
        amount: 10000,
        isIncome: false,
        needs: "food",
        source: 1,
        dateTime: DateTime.now()),
    Transaction(
        amount: 10000,
        isIncome: false,
        needs: "food",
        source: 2,
        dateTime: DateTime.now()),
    Transaction(
        amount: 10000,
        isIncome: true,
        needs: "food",
        source: 0,
        dateTime: DateTime.now()),
  ];

  List<Transaction> get transactions => List.unmodifiable(_transactions);
  List<Transaction> get transactionsFiltered => _transactions
      .where((element) => element.source == _cardSelected)
      .toList();
  int get cardSelected => _cardSelected;

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
