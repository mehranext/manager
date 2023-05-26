import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manager/models/constant.dart';
import 'package:manager/models/money.dart';
import 'package:manager/screens/new_transaction_sreen.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static List<Money> moneys = [
    Money(
        id: 0,
        title: 'Tes1',
        price: '1000',
        date: '1400/01/01',
        isReceived: true),
    Money(
        id: 1,
        title: 'Test2',
        price: '2000',
        date: '1400/01/01',
        isReceived: false),
    Money(
        id: 2,
        title: 'Test3',
        price: '3000',
        date: '1400/01/01',
        isReceived: false),
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: const MyfloatingButton(),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              headerwidget(searchController: searchController),
              //const Expanded(child: Picwidget()),
              Expanded(
                child: ListView.builder(
                    itemCount: HomeScreen.moneys.length,
                    itemBuilder: (context, index) {
                      return MyListTileWidget(index: index);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyListTileWidget extends StatelessWidget {
  final int index;
  const MyListTileWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color:
                  HomeScreen.moneys[index].isReceived ? kGreenColor : kRedColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Icon(
                HomeScreen.moneys[index].isReceived ? Icons.add : Icons.remove,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(HomeScreen.moneys[index].title),
          ),
          const Spacer(),
          Column(
            children: [
              const Text(
                'تومان',
                style: TextStyle(fontSize: 14, color: kRedColor),
              ),
              Text(
                HomeScreen.moneys[index].price,
                style: const TextStyle(fontSize: 14, color: kRedColor),
              ),
              Text(HomeScreen.moneys[index].date),
            ],
          ),
        ],
      ),
    );
  }
}

//!floatingbutton
class MyfloatingButton extends StatelessWidget {
  const MyfloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: kPurpleColor,
      elevation: 0,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewTransactionScreen()),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}

//!headerwidgets
// ignore: camel_case_types
class headerwidget extends StatelessWidget {
  const headerwidget({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 20, left: 5),
      child: Row(
        children: [
          Expanded(
            child: SearchBarAnimation(
              hintText: ('...جست و جو کنید'),
              textEditingController: searchController,
              isOriginalAnimation: false,
              buttonColour: kPurpleColor,
              buttonElevation: 0,
              buttonBorderColour: Colors.black54,
              trailingWidget: const Icon(
                Icons.search,
                size: 25,
              ),
              buttonWidget: const Icon(
                Icons.search,
                size: 25,
              ),
              secondaryButtonWidget: const Icon(
                Icons.search,
              ),
              onFieldSubmitted: (String text) {},
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            ' : تراکنش ها',
            style: TextStyle(fontSize: 28),
          ),
        ],
      ),
    );
  }
}

//!center picture codes
class Picwidget extends StatelessWidget {
  const Picwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SvgPicture.asset(
          'assets/images/pages-paper-stacked-640.svg',
          height: 200,
          width: 200,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(':)تراکنشی یوخدی که'),
        const Spacer(),
      ],
    );
  }
}
