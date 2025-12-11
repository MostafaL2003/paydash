import 'package:flutter/material.dart';
import 'package:paydash/core/app_colors.dart';
import 'package:paydash/features/dashboard/widgets/balance_section.dart';
import 'package:paydash/features/dashboard/widgets/credit_card_widget.dart';
import 'package:paydash/features/dashboard/widgets/transaction_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paydash/features/dashboard/cubit/dashboard_cubit.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('PayDash'),
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
