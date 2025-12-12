import 'package:flutter/material.dart';
import 'package:paydash/features/analytics/screens/analytics_screen.dart';
import 'package:paydash/features/dashboard/screens/profile_screen.dart';
import 'package:paydash/features/dashboard/widgets/balance_section.dart';
import 'package:paydash/features/dashboard/widgets/credit_card_widget.dart';
import 'package:paydash/features/dashboard/widgets/transaction_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paydash/features/dashboard/cubit/dashboard_cubit.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyLarge?.color ?? Colors.white;

    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: AppBar(
            actions: [
              IconButton(
                icon: const Icon(Icons.analytics),
                tooltip: 'Analytics',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AnalyticsScreen(),
                    ),
                  );
                },
              ),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: theme.cardColor,
                  child: Icon(Icons.person, color: textColor),
                ),
              ),
            ),
            title: Text(
              'PayDash',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: textColor,
                letterSpacing: 2.0,
                shadows: [
                  Shadow(
                    blurRadius: 5.0,
                    color: textColor.withOpacity(0.38),
                    offset: const Offset(0, 0),
                  ),
                  Shadow(
                    blurRadius: 14.0,
                    color: theme.colorScheme.primary.withOpacity(0.16),
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            ),
          ),

          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const CreditCardWidget(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BalanceSection(balance: state.balance.toDouble()),
                ),
                const SizedBox(height: 20),
                TransactionList(transactions: state.transactions),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
