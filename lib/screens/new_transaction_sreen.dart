import 'dart:math';

import 'package:flutter/material.dart';
import 'package:manager/models/constant.dart';
import 'package:manager/models/money.dart';
import 'package:manager/screens/home_screen.dart';

class NewTransactionScreen extends StatefulWidget {
  const NewTransactionScreen({super.key});
  static int groupId = 0;
  static TextEditingController decriptionController = TextEditingController();
  static TextEditingController priceController = TextEditingController();
  @override
  State<NewTransactionScreen> createState() => _NewTransactionScreenState();
}

class _NewTransactionScreenState extends State<NewTransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'تراکنش جدید',
                style: TextStyle(fontSize: 18),
              ),
              MyTextField(
                hintText: 'توضیحات',
                controller: NewTransactionScreen.decriptionController,
              ),
              MyTextField(
                hintText: 'مبلغ',
                type: TextInputType.number,
                controller: NewTransactionScreen.priceController,
              ),
              const TypeAndDateWidget(),
              MyButton(
                text: 'اضافه کردن',
                onPressed: () {
                  HomeScreen.moneys.add(
                    Money(
                      id: Random().nextInt(9999),
                      title: NewTransactionScreen.decriptionController.text,
                      price: NewTransactionScreen.priceController.text,
                      date: '1402/03/06',
                      isReceived:
                          NewTransactionScreen.groupId == 1 ? true : false,
                    ),
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//! MyButton
class MyButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const MyButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style:
              TextButton.styleFrom(backgroundColor: kPurpleColor, elevation: 0),
          onPressed: onPressed,
          child: Text(
            text,
          ),
        ));
  }
}

//!Type And Date Widget
class TypeAndDateWidget extends StatefulWidget {
  const TypeAndDateWidget({
    super.key,
  });

  @override
  State<TypeAndDateWidget> createState() => _TypeAndDateWidgetState();
}

class _TypeAndDateWidgetState extends State<TypeAndDateWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyRadioButton(
          value: 1,
          groupValue: NewTransactionScreen.groupId,
          onChanged: (value) {
            setState(() {
              NewTransactionScreen.groupId = value!;
            });
          },
          text: 'دریافتی',
        ),
        MyRadioButton(
          value: 2,
          groupValue: NewTransactionScreen.groupId,
          onChanged: (value) {
            setState(() {
              NewTransactionScreen.groupId = value!;
            });
          },
          text: 'پرداختی',
        ),
        OutlinedButton(
          onPressed: () {},
          child: const Text(
            'تاریخ',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

//!My RadioButton
class MyRadioButton extends StatelessWidget {
  final int value;
  final int groupValue;
  final Function(int?) onChanged;
  final String text;

  const MyRadioButton(
      {super.key,
      required this.value,
      required this.groupValue,
      required this.onChanged,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Radio(
          activeColor: kPurpleColor,
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(text),
      ],
    );
  }
}

//!My TextField Widet
class MyTextField extends StatelessWidget {
  final String hintText;
  final TextInputType type;
  final TextEditingController controller;
  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.type = TextInputType.text});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: type,
      cursorColor: Colors.black54,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        hintText: hintText,
      ),
    );
  }
}
