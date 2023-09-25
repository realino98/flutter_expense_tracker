import 'package:flutter/widgets.dart';
import 'package:flutter_expense_tracker/models/transaction_model.dart';

import 'package:provider/provider.dart';

class TransactionManager extends ChangeNotifier {
  final _transactions = <Transaction>[];

  List<Transaction> get transactions => List.unmodifiable(_transactions);

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }

  void removeTransaction(Transaction transaction) {
    _transactions.remove(transaction);
  }
}
