import 'package:flutter/material.dart';
import 'package:paydash/features/dashboard/models/transaction_model.dart';
// Note: We don't need 'transaction_model.dart' if the class is inside the cubit file.
// If you moved it, keep the import. If not, delete the 'transaction_model.dart' import.

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      decoration: BoxDecoration(
        color: theme.cardColor.withOpacity(0.25),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title Row
          Row(
            children: [
              Text(
                "Recent Transactions",
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // The List Generator
          ...List.generate(transactions.length > 5 ? 5 : transactions.length, (
            index,
          ) {
            final transaction = transactions[index];

            return Container(
              margin: EdgeInsets.only(
                bottom:
                    index !=
                            (transactions.length > 5
                                    ? 5
                                    : transactions.length) -
                                1
                        ? 12
                        : 0,
              ),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: ListTile(
                // FIX 1: Use a static icon because your model doesn't have icon data yet
                leading: CircleAvatar(
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.14),
                  child: Icon(
                    transaction.icon, // Default icon
                    color: theme.colorScheme.primary,
                  ),
                ),
                // FIX 2: Use 'title', not 'store'
                title: Text(
                  transaction.title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Text(
                  // FIX 3: Convert int to double for the helper function
                  _amountString(transaction.amount.toDouble()),
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  String _amountString(double amount) {
    final sign = amount < 0 ? '- ' : '+ ';
    final absVal = amount.abs().toStringAsFixed(2);
    return '$sign EGP $absVal';
  }
}
