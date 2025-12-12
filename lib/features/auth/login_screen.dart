import 'package:flutter/material.dart';
import 'package:paydash/core/app_colors.dart';
import 'package:paydash/features/dashboard/widgets/number_pad.dart';
import 'package:paydash/features/dashboard/screens/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _pin = '';

  void _onKeyPressed(String value) {
    setState(() {
      if (value == '<') {
        if (_pin.isNotEmpty) {
          _pin = _pin.substring(0, _pin.length - 1);
        }
      } else if (_pin.length < 4 && RegExp(r'\d').hasMatch(value)) {
        _pin += value;
      }
    });

    if (_pin.length == 4) {
      Future.delayed(const Duration(milliseconds: 100), _validatePin);
    }
  }

  void _validatePin() {
    if (_pin == '1234') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: const Text('Incorrect PIN. Please try again.'),
        ),
      );
      setState(() {
        _pin = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 48),
            Icon(
              Icons.lock_outline_rounded,
              color: AppColors.primary,
              size: 64,
            ),
            const SizedBox(height: 24),
            Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Enter your PIN',
              style: TextStyle(
                fontSize: 16,
                color: isDark
                    ? Colors.white70
                    : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "PIN is 1234 (for testers)",
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (idx) {
                final filled = idx < _pin.length;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: filled ? AppColors.primary : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: filled
                            ? AppColors.primary
                            : Colors.grey[500]!,
                        width: 2,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const Spacer(),
            NumberPad(
              onKeyPressed: _onKeyPressed,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

