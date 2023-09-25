import 'package:flutter/material.dart';

class Transaction {
  final String needs;
  final bool isIncome;
  final int amount;
  final int source;

  Transaction({
    required this.source,
    required this.needs,
    required this.isIncome,
    required this.amount,
  });

  factory Transaction.fromJson(data) {
    return Transaction(
      source: data['source'],
      needs: data['needs'],
      isIncome: data['isIncome'],
      amount: data['amount'],
    );
  }
}
