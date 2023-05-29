import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:manager/main.dart';
import 'package:manager/models/constant.dart';
import 'package:manager/models/money.dart';
import 'package:manager/screens/new_transaction_sreen.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static List<Money> moneys = [];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  Box<Money> hiveBox = Hive.box<Money>('moneyBox');

  @override
  void initState() {
    super.initState();
    Manage.getdata();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FabWidget(),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              headerWidget(),
              //const Expanded(child: Picwidget()),
              Expanded(
                child: HomeScreen.moneys.isEmpty
                    ? const Picwidget()
                    : ListView.builder(
                        itemCount: HomeScreen.moneys.length,
                        itemBuilder: (context, index) {
                          //!Delete
                          return GestureDetector(
                              //*Edit
                              onTap: () {
                                //
                                NewTransactionScreen.date =
                                    HomeScreen.moneys[index].date;
                                //
                                NewTransactionScreen.decriptionController.text =
                                    HomeScreen.moneys[index].title;
                                //
                                NewTransactionScreen.priceController.text =
                                    HomeScreen.moneys[index].price;
                                //
                                NewTransactionScreen.groupId =
                                    HomeScreen.moneys[index].isReceived ? 1 : 2;
                                //
                                NewTransactionScreen.isEditing = true;
                                //
                                NewTransactionScreen.id =
                                    HomeScreen.moneys[index].id;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const NewTransactionScreen(),
                                  ),
                                ).then((value) {
                                  Manage.getdata();
                                  setState(() {});
                                });
                              },
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    actionsAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    title: const Text(
                                      'آیا مطمعن هستید از حذف آیتم؟',
                                      style: TextStyle(
                                          fontSize: 15, color: kRedColor),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'خیر',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          hiveBox.deleteAt(index);
                                          Manage.getdata();
                                          setState(() {});
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'بله',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: MyListTileWidget(index: index));
                        }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  //!FAB Widget
  // ignore: non_constant_identifier_names
  Widget FabWidget() {
    return FloatingActionButton(
      backgroundColor: kPurpleColor,
      elevation: 0,
      onPressed: () {
        NewTransactionScreen.date = '';
        NewTransactionScreen.decriptionController.text = '';
        //
        NewTransactionScreen.priceController.text = '';
        //
        NewTransactionScreen.groupId = 0;
        //
        NewTransactionScreen.isEditing = false;
        //
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewTransactionScreen()),
        ).then((value) {
          Manage.getdata();
          setState(() {});
        });
      },
      child: const Icon(Icons.add),
    );
  }

  //!HeaderWidget
  Widget headerWidget() {
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
              onCollapseComplete: () {
                Manage.getdata();
                searchController.text = '';
                setState(() {});
              },
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
              onFieldSubmitted: (String text) {
                List<Money> result = hiveBox.values
                    .where(
                      (value) =>
                          value.title.contains(text) ||
                          value.date.contains(text),
                    )
                    .toList();
                HomeScreen.moneys.clear();
                setState(() {
                  for (var value in result) {
                    HomeScreen.moneys.add(value);
                  }
                });
              },
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

//!MyListTile
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
        const Text(':)تراکنشی موجود نیست'),
        const Spacer(),
      ],
    );
  }
}
