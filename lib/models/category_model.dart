import 'package:flutter/material.dart';

class Category {
  final Icon icon;
  final Color color;
  final String categoryName;
  final int itemTotal;
  final int total;

  Category(
      {required this.icon,
      required this.color,
      required this.categoryName,
      required this.itemTotal,
      required this.total});
}
