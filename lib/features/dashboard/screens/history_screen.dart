import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:paydash/features/dashboard/cubit/dashboard_cubit.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, h:mm a').format(date);
  }

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
          'Transaction History',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 0.2,
          ),
        ),
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          final transactions = state.transactions;
          if (transactions.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.history,
                    size: 54,
                    color: textColor.withOpacity(0.24),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'No transactions yet',
                    style: TextStyle(
                      color: textColor.withOpacity(0.6),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final tx = transactions[index];
              final isOutgoing = tx.amount < 0;
              final icon = Icon(
                IconData(tx.iconCode, fontFamily: 'MaterialIcons'),
                color:
                    isOutgoing ? theme.colorScheme.primary : Colors.greenAccent,
                size: 28,
              );
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                decoration: BoxDecoration(
                  color: textColor.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: icon,
                  ),
                  title: Text(
                    tx.title,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    _formatDate(tx.date),
                    style: TextStyle(
                      color: textColor.withOpacity(0.6),
                      fontSize: 13,
                    ),
                  ),
                  trailing: Text(
                    (isOutgoing ? '-' : '+') +
                        'EGP ${tx.amount.abs().toStringAsFixed(2)}',
                    style: TextStyle(
                      color:
                          isOutgoing
                              ? theme.colorScheme.primary
                              : Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
