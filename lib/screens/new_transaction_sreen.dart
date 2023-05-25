import 'package:flutter/material.dart';
import 'package:manager/models/constant.dart';

class NewTransactionScreen extends StatefulWidget {
  const NewTransactionScreen({super.key});

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
              const MyTextField(
                hintText: 'توضیحات',
              ),
              const MyTextField(
                hintText: 'مبلغ',
                type: TextInputType.number,
              ),
              const TypeAndDateWidget(),
              MyButton(
                text: 'اضافه کردن',
                onPressed: (){},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const MyButton({super.key, required this.text,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style:
              TextButton.styleFrom(backgroundColor: kPurpleColor, elevation: 0),
          onPressed: onPressed,
          child: Text(text,),
        ));
  }
}

//!Type And Date Widget
class TypeAndDateWidget extends StatelessWidget {
  const TypeAndDateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyRadioButton(
          value: 1,
          groupValue: 1000,
          onChanged: (value) {},
          text: 'دریافتی',
        ),
        MyRadioButton(
          value: 0,
          groupValue: 1000,
          onChanged: (value) {},
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
  const MyTextField(
      {super.key, required this.hintText, this.type = TextInputType.text});
  @override
  Widget build(BuildContext context) {
    return TextField(
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
