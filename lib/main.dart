import 'package:flutter/material.dart';
import 'package:paydash/features/dashboard/cubit/dashboard_cubit.dart';
import 'package:paydash/features/dashboard/models/transaction_model.dart';
import 'features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox('pay_dash');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DashboardCubit(),
      child: MaterialApp(
        title: 'PayDash',
        home: const DashboardScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
