import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  getAppBar() {
    return PreferredSize(
      child: MyAppBar(),
      preferredSize: Size.fromHeight(65),
    );
  }

  getBody() {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const MyBackButton(),
              Text(
                'Burger Week',
                style: boldWhiteText18(normalTextAndButtonColor),
                textAlign: TextAlign.center,
              ),
              const Opacity(
                child: MyBackButton(),
                opacity: 0.0,
              ),
            ],
          ),
          verticalSpace(),
          MyCustomScrollBar(
            axis: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: List.generate(
                  10,
                  (index) => CategoryCard(index: index,categories: [],),
                ),
              ),
            ),
          ),
          verticalSpace(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView.builder(
                itemBuilder: (_, index) => buildProductListing(index),
                itemCount: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProductListing(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
      child: CardProduct(index: index,offers: [],),
    );
  }
}
