import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paydash/features/dashboard/cubit/dashboard_cubit.dart';
import 'package:paydash/features/dashboard/models/transaction_model.dart';
import 'package:paydash/features/dashboard/widgets/number_pad.dart';
import 'package:paydash/features/dashboard/widgets/recipient_sheet.dart';

class TransferScreen extends StatefulWidget {
  final bool isRequest;

  const TransferScreen({super.key, this.isRequest = false});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  String amount = '0';

  // --- LOGIC ---
  void _onKeyPressed(String value) {
    setState(() {
      if (value == 'backspace') {
        if (amount.length == 1) {
          amount = '0';
        } else if (amount.length > 1) {
          amount = amount.substring(0, amount.length - 1);
          if (amount == '' || amount == '.') amount = '0';
        }
      } else if (value == '.') {
        if (!amount.contains('.')) amount += '.';
      } else {
        if (amount.replaceAll('.', '').length >= 7) return;
        if (amount == '0') {
          amount = value;
        } else {
          if (amount.contains('.') && amount.length - amount.indexOf('.') > 2)
            return;
          amount += value;
        }
      }
    });
  }

  void _showRecipientSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (ctx) => RecipientSheet(
            onContactSelected: (name) {
              Navigator.pop(ctx); // Close sheet
              _processPayment(name); // Pay
            },
          ),
    );
  }

  void _processPayment(String name) {
    String cleanAmount =
        amount.endsWith('.') ? amount.substring(0, amount.length - 1) : amount;
    final double? parsedAmount = double.tryParse(cleanAmount);

    if (parsedAmount != null && parsedAmount > 0) {
      final cubit = context.read<DashboardCubit>();
      final currentBalance = cubit.state.balance;

      if (!widget.isRequest && parsedAmount > currentBalance) {
        // Show insufficient funds dialog
        _showInsufficientFundsDialog();
        return;
      }

      // If isRequest, add money; if send, remove money
      final transaction = Transaction(
        title: name,
        amount: widget.isRequest ? parsedAmount : -parsedAmount,
        date: DateTime.now(),
        iconCode:
            widget.isRequest
                ? Icons.arrow_downward.codePoint
                : Icons.arrow_upward.codePoint,
      );

      cubit.addTransaction(transaction);

      if (mounted) Navigator.of(context).pop(); // Return to dashboard
    }
  }

  void _showInsufficientFundsDialog() {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: theme.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            title: Text(
              'Insufficient Funds',
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
            content: Text(
              'You do not have sufficient balance to complete this transaction.',
              style: TextStyle(color: textColor.withOpacity(0.7)),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  // --- UI ---
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: textColor),
        centerTitle: true,
        title: Text(
          widget.isRequest
              ? 'Request Money'
              : 'Send Money', // ✅ Simple and Safe
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 0.2,
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Amount Display
            Expanded(
              flex: 3,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'EGP',
                      style: TextStyle(
                        color: textColor.withOpacity(0.6),
                        fontSize: 24,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 14),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        _formatAmount(amount),
                        style: TextStyle(
                          color: textColor,
                          fontSize: 68,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Imported NumberPad
            Expanded(flex: 5, child: NumberPad(onKeyPressed: _onKeyPressed)),

            // Pay Button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 64,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: _showRecipientSheet,
                  child: Text(
                    widget.isRequest ? 'Request' : 'Pay',
                    style: TextStyle(
                      color: theme.colorScheme.onPrimary,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatAmount(String raw) {
    if (raw.contains('.')) {
      var parts = raw.split('.');
      String before = int.parse(parts[0].isEmpty ? '0' : parts[0]).toString();
      String after = parts[1].length > 2 ? parts[1].substring(0, 2) : parts[1];
      return '$before.$after';
    }
    return int.parse(raw.isEmpty ? '0' : raw).toString();
  }
}
