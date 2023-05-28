import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:manager/models/money.dart';
import 'package:manager/screens/main_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MoneyAdapter());
 await Hive.openBox<Money>('moneyBox');
  runApp(const Manage());
}

class Manage extends StatelessWidget {
  const Manage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Iranian Sans'),
      debugShowCheckedModeBanner: false,
      title: 'ManageApp',
      home: const MainScreen(),
    );
  }
}
