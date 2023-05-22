import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manager/models/constant.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: kPurpleColor,
            elevation: 0,
            child: Icon(Icons.add),
          ),
          body: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20, top: 20, left: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: SearchBarAnimation(
                          hintText: '...جست و جو کنید',
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
                        width: 15,
                      ),
                      const Text(
                        ' : تراکنش ها',
                        style: TextStyle(fontSize: 28),
                      ),
                    ],
                  ),
                ),
                Expanded(child: Picwidget()),
              ],
            ),
          )),
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
     const   SizedBox(
          height: 10,
        ),
    const    Text(':)تراکنشی یوخدی که'),
        const Spacer(),
      ],
    );
  }
}
