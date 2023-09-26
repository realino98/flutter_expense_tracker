import 'package:flutter/widgets.dart';
import 'package:flutter_expense_tracker/models/transaction_model.dart';

import 'package:provider/provider.dart';

class TransactionManager extends ChangeNotifier {
  final List<Transaction> _transactions = <Transaction>[
    Transaction(amount: 10000, isIncome: true, needs: "food", source: 1),
    Transaction(amount: 10000, isIncome: false, needs: "food", source: 1)
  ];

  List<Transaction> get transactions => List.unmodifiable(_transactions);

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
      var total = 0;
      for (int i = 0; i < transactions_to_count.length; i++) {
        total += _transactions[i].amount;
      }
      return total.toString();
    } else {
      print("empty");
      return "0";
    }
  }

  countBalaceTotal() {
    return countTotal(_transactions);
  }

  countIncome() {
    if (_transactions
        .where((element) => element.isIncome == true)
        .toList()
        .isNotEmpty) {
      return countTotal(
          _transactions.where((element) => element.isIncome == true).toList());
    }
  }

  countOutcome() {
    if (_transactions
        .where((element) => element.isIncome == false)
        .toList()
        .isNotEmpty) {
      return countTotal(
          _transactions.where((element) => element.isIncome == true).toList());
    }
  }
}
