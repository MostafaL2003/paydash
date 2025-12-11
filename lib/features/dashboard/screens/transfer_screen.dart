import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paydash/core/app_colors.dart';
import 'package:paydash/features/dashboard/cubit/dashboard_cubit.dart';
import 'package:paydash/features/dashboard/models/transaction_model.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController _controller = TextEditingController();

  void _submitTransfer() {
    final input = _controller.text.replaceAll(',', '').replaceAll(' ', '');
    if (input.isEmpty) {
      return;
    }
    final amount = double.tryParse(input);
    if (amount == null || amount <= 0) {
      // Could show a simple error, but spec does not require it.
      return;
    }

    final transaction = Transaction(
      title: "Transfer",
      amount: -amount,
      date: DateTime.now(),
      iconCode: Icons.arrow_upward.codePoint,
    );

    context.read<DashboardCubit>().addTransaction(transaction);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: AppColors.textWhite),
        centerTitle: true,
        title: const Text(
          'Send Money',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 0.2,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: TextField(
            controller: _controller,
            autofocus: true,
            textAlign: TextAlign.center,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 60,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
            cursorColor: AppColors.primary,
            decoration: InputDecoration(
              prefixText: 'EGP ',
              prefixStyle: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
            onSubmitted: (_) => _submitTransfer(),
            inputFormatters: [
              // Optionally, you could add filtering here
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        child: SizedBox(
          width: double.infinity,
          height: 64,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              elevation: 4,
            ),
            onPressed: _submitTransfer,
            child: const Text(
              'Pay',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
