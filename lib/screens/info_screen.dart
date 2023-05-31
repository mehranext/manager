// ignore: file_names
import 'package:flutter/material.dart';
import 'package:manager/utils/calculate.dart';
import 'package:manager/widgets/chart_widget.dart';


class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 15, top: 15, left: 5),
            child: Text('مدیریت تراکنش ها'),
          ),
          MoneyInfowidget(
            firstText: ': دریافتی امروز',
            firstPrice: Calculate.dToday().toString(),
            secondText: ': پرداختی امروز',
            secodPrice: Calculate.pToday().toString(),
          ),
          MoneyInfowidget(
            firstText: ': دریافتی ماه',
            firstPrice: Calculate.dMonth().toString(),
            secondText: ': پرداختی ماه',
            secodPrice: Calculate.pMonth().toString(),
          ),
          MoneyInfowidget(
            firstText: ': دریافتی امسال',
            firstPrice: Calculate.dYear().toString(),
            secondText: ': پرداختی امسال',
            secodPrice: Calculate.pYear().toString(),
          ),
          Container(
              padding: const EdgeInsets.all(20),
              height: 200,)
        ],
      ),
    )));
  }
}

//! moneyinformationwidget
class MoneyInfowidget extends StatelessWidget {
  final String firstText;
  final String secondText;
  final String firstPrice;
  final String secodPrice;

  const MoneyInfowidget({
    Key? key,
    required this.firstText,
    required this.secondText,
    required this.firstPrice,
    required this.secodPrice,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 25, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
              child: Text(
            secodPrice,
            textAlign: TextAlign.right,
          )),
          Text(secondText),
          Expanded(child: Text(firstPrice, textAlign: TextAlign.right)),
          Text(firstText),
        ],
      ),
    );
  }
}
