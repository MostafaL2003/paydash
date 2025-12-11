import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paydash/features/dashboard/models/transaction_model.dart';

class DashboardState {
  final double balance;
  final List<Transaction> transactions;

  DashboardState({required this.balance, required this.transactions});

  DashboardState copyWith({double? balance, List<Transaction>? transactions}) {
    return DashboardState(
      balance: balance ?? this.balance,
      transactions: transactions ?? this.transactions,
    );
  }
}

class DashboardCubit extends Cubit<DashboardState> {
  static const String _boxName = 'pay_dash';
  static const String _balanceKey = 'balance';
  static const String _transactionsKey = 'transactions';

  Box get _box => Hive.box(_boxName);

  DashboardCubit()
    : super(
        DashboardState(
          balance: _getInitialBalance(),
          transactions: _getInitialTransactions(),
        ),
      );

  static double _getInitialBalance() {
    final box = Hive.box(_boxName);
    final savedBalance = box.get(_balanceKey);
    if (savedBalance is double) {
      return savedBalance;
    }
    // Default starting value if not present in Hive
    return 12500.0;
  }

  static List<Transaction> _getInitialTransactions() {
    final box = Hive.box(_boxName);
    final savedList = box.get(_transactionsKey);
    if (savedList is List && savedList.isNotEmpty) {
      // Convert any dynamic-typed Hive list to List<Transaction>
      try {
        return savedList.cast<Transaction>();
      } catch (e) {
        // If cast fails, return default transactions
        return _getDefaultTransactions();
      }
    }
    // Default hardcoded transactions if not present in Hive
    return _getDefaultTransactions();
  }

  static List<Transaction> _getDefaultTransactions() {
    return [
      Transaction(
        title: "Starbucks",
        amount: -150,
        date: DateTime.now().subtract(const Duration(days: 1)),
        iconCode: Icons.coffee.codePoint,
      ),
      Transaction(
        title: "Amazon",
        amount: -12500,
        date: DateTime.now().subtract(const Duration(days: 2)),
        iconCode: Icons.shopping_bag.codePoint,
      ),
      Transaction(
        title: "Apple",
        amount: -8000,
        date: DateTime.now().subtract(const Duration(days: 3)),
        iconCode: Icons.phone_iphone.codePoint,
      ),
      Transaction(
        title: "Uber",
        amount: -95,
        date: DateTime.now().subtract(const Duration(hours: 8)),
        iconCode: Icons.directions_car.codePoint,
      ),
      Transaction(
        title: "Cinema City",
        amount: -200,
        date: DateTime.now().subtract(const Duration(days: 4)),
        iconCode: Icons.movie.codePoint,
      ),
    ];
  }

  void addTransaction(Transaction transaction) async {
    final updatedTransactions = List<Transaction>.from(state.transactions)
      ..insert(0, transaction);
    final newBalance = state.balance + transaction.amount;

    // Persist to Hive
    await _box.put(_balanceKey, newBalance);
    await _box.put(_transactionsKey, updatedTransactions);

    emit(
      state.copyWith(balance: newBalance, transactions: updatedTransactions),
    );
  }
}
