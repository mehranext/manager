import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:manager/main.dart';
import 'package:manager/models/constant.dart';
import 'package:manager/models/money.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class NewTransactionScreen extends StatefulWidget {
  const NewTransactionScreen({super.key});
  static int groupId = 0;
  static TextEditingController decriptionController = TextEditingController();
  static TextEditingController priceController = TextEditingController();
  static bool isEditing = false;
  static int id = 0;
  static String date = 'تاریخ';
  @override
  State<NewTransactionScreen> createState() => _NewTransactionScreenState();
}

class _NewTransactionScreenState extends State<NewTransactionScreen> {
  Box<Money> hiveBox = Hive.box<Money>('moneyBox');

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
              Text(
                NewTransactionScreen.isEditing
                    ? 'ویرایش تراکنش'
                    : 'تراکنش جدید',
                style: const TextStyle(fontSize: 18),
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
                text: NewTransactionScreen.isEditing
                    ? 'ویرایش کردن'
                    : 'اضافه کردن',
                onPressed: () {
                  Money item = Money(
                    id: Random().nextInt(99999999),
                    title: NewTransactionScreen.decriptionController.text,
                    price: NewTransactionScreen.priceController.text,
                    date: NewTransactionScreen.date,
                    isReceived:
                        NewTransactionScreen.groupId == 1 ? true : false,
                  );
                  //
                  if (NewTransactionScreen.isEditing) {
                    int index = 0;
                    Manage.getdata();
                    for (int i = 0; i < hiveBox.values.length; i++) {
                      if (hiveBox.values.elementAt(i).id ==
                          NewTransactionScreen.id) {
                        index = i;
                      }
                    }

                    hiveBox.putAt(index, item);
                  } else {
                    hiveBox.add(item);
                  }
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
        Expanded(
          child: MyRadioButton(
            value: 1,
            groupValue: NewTransactionScreen.groupId,
            onChanged: (value) {
              setState(() {
                NewTransactionScreen.groupId = value!;
              });
            },
            text: 'دریافتی',
          ),
        ),
        Expanded(
          child: MyRadioButton(
            value: 2,
            groupValue: NewTransactionScreen.groupId,
            onChanged: (value) {
              setState(() {
                NewTransactionScreen.groupId = value!;
              });
            },
            text: 'پرداختی',
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        OutlinedButton(
          onPressed: () async {
            var pickDate = await showPersianDatePicker(
              context: context,
              initialDate: Jalali.now(),
              firstDate: Jalali(1400),
              lastDate: Jalali(1499),
            );
            setState(() {
              String year = pickDate!.year.toString();
              //!قسمت تغییر تاریخ برای ثبت 01 اعداد ا تا 9
              String month = pickDate.month.toString().length == 1
                  ? '0${pickDate.month.toString()}'
                  : pickDate.month.toString();

              //! تغییر برای اعداد روز 1 تا که 01 داشته باشند
              String day = pickDate.day.toString();
              pickDate.day.toString().length == 1
                  ? '0${pickDate.day.toString()}'
                  : pickDate.day.toString();
              //
              NewTransactionScreen.date = year + '/' + month + '/' + day;
            });
          },
          child: Text(
            NewTransactionScreen.date,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
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
        Expanded(
          child: Radio(
            activeColor: kPurpleColor,
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
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
