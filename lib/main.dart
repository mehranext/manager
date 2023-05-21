import 'package:flutter/material.dart';

void main() {
  runApp(const Manage());
}

class Manage extends StatelessWidget {
  const Manage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      title: 'ManageApp',
      home: Container(),
    );
  }
}