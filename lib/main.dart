import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:manager/models/money.dart';
import 'package:manager/screens/home_screen.dart';
import 'package:manager/screens/main_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MoneyAdapter());
  await Hive.openBox<Money>('moneyBox');
  runApp(const Manage());
}

class Manage extends StatelessWidget {
  const Manage({super.key});

  static void getdata() {
    HomeScreen.moneys.clear();
    Box<Money> hiveBox = Hive.box<Money>('moneyBox');
    for (var value in hiveBox.values) {
      HomeScreen.moneys.add(value);
    }
  }

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
