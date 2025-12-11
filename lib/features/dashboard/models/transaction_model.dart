import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'transaction_model.g.dart'; // This line will be red until we run the generator

@HiveType(typeId: 0)
class Transaction extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final int iconCode; // We save the integer here

  Transaction({
    required this.title,
    required this.amount,
    required this.date,
    required this.iconCode,
  });

  // Helper: Converts the integer back to an IconData for the UI
  IconData get icon => IconData(iconCode, fontFamily: 'MaterialIcons');
}