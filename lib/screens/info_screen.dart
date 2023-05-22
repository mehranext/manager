import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
            body: SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 15, top: 15, left: 5),
            child: Text('مدیریت تراکنش ها'),
          ),
          MoneyInfowidget(
            firstText: ': دریافتی امروز',
            secondText: ': پرداختی امروز',
            firstPrice: '0',
            secodPrice: '0',
          ),
          MoneyInfowidget(
            firstText: ': دریافتی امروز',
            secondText: ': پرداختی امروز',
            firstPrice: '0',
            secodPrice: '0',
          ),
          MoneyInfowidget(
            firstText: ': دریافتی امروز',
            secondText: ': پرداختی امروز',
            firstPrice: '0',
            secodPrice: '0',
          ),
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
