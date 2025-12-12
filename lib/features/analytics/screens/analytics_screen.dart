import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paydash/features/analytics/widgets/spending_chart.dart';
import 'package:paydash/features/analytics/widgets/top_spender.dart';
import 'package:paydash/features/dashboard/cubit/dashboard_cubit.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Analytics',
          style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: textColor,
        centerTitle: true,
      ),
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          final transactions = state.transactions;

          // Compute weekly stats
          final now = DateTime.now();
          final startOfToday = DateTime(now.year, now.month, now.day);
          final last7Days = List<DateTime>.generate(
            7,
            (i) => startOfToday.subtract(Duration(days: 6 - i)),
          );
          // Prepare a set for faster membership check
          final last7DaysSet = last7Days.toSet();

          final weekSpending = transactions
              .where(
                (tx) =>
                    tx.amount < 0 &&
                    last7DaysSet.contains(
                      DateTime(tx.date.year, tx.date.month, tx.date.day),
                    ),
              )
              .fold<double>(0.0, (sum, tx) => sum + tx.amount.abs());

          final avgDaily = weekSpending / 7.0;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'Weekly Spending',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SpendingChart(transactions: transactions),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Spent this Week',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: textColor.withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${weekSpending.toStringAsFixed(2)}',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Average Daily',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: textColor.withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${avgDaily.toStringAsFixed(2)}',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Top Spending Section
                  Text(
                    'Top Spending',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TopSpendingWidget(transactions: transactions),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
