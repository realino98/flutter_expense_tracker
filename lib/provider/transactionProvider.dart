import 'package:flutter/widgets.dart';
import 'package:flutter_expense_tracker/models/transaction_model.dart';
import 'package:intl/intl.dart';

class TransactionManager extends ChangeNotifier {
  var formatter = NumberFormat('#,###');
  int _cardSelected = 1;
  final List<Transaction> _transactions = <Transaction>[
    Transaction(amount: 10000, isIncome: true, needs: "food", source: 1),
    Transaction(amount: 10000, isIncome: true, needs: "food", source: 1),
    Transaction(amount: 10000, isIncome: true, needs: "food", source: 1),
    Transaction(amount: 10000, isIncome: false, needs: "food", source: 2),
    Transaction(amount: 11200, isIncome: false, needs: "food", source: 2),
  ];

  List<Transaction> get transactions => List.unmodifiable(_transactions);
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
      var total = 0;
      for (int i = 0; i < transactions_to_count.length; i++) {
        total += _transactions[i].amount;
      }

      return total;
    }
  }

  countBalaceTotal() {
    // return countIncome() - countOutcome();
    var total =
        formatter.format(int.parse(countIncome()) - int.parse(countOutcome()));
    return total;
  }

  countIncome() {
    if (_transactions
        .where((element) => element.isIncome == true)
        .toList()
        .isNotEmpty) {
      return (countTotal(_transactions
              .where((element) => element.isIncome == true)
              .toList())
          .toString());
    }
    notifyListeners();
  }

  countOutcome() {
    if (_transactions
        .where((element) => element.isIncome == false)
        .toList()
        .isNotEmpty) {
      return countTotal(_transactions
              .where((element) => element.isIncome == false)
              .toList())
          .toString();
    }
    notifyListeners();
  }

  cardSelect(int selected) {
    _cardSelected = selected;
    print("Card Selected : ${_cardSelected}");
    notifyListeners();
  }
}
