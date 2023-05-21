import 'package:flutter/material.dart';
import 'package:manager/screens/main_screen.dart';

void main() {
  runApp(const Manage());
}

class Manage extends StatelessWidget {
  const Manage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp( 
      debugShowCheckedModeBanner: false,
      title: 'ManageApp',
      home: MainScreen(),
    );
  }
}