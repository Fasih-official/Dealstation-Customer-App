import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Screens/daily_promotions_screen.dart';
import '../controlllers/main_screen_controller.dart';
import '../utils/colors.dart';
import '../utils/widgets.dart';
import 'dashboard_screen.dart';
import 'map_screen.dart';
import 'campaigns_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> pages = [
    DashboardScreen(),
    MapScreen(),
    DailyPromotionsScreen(),
    CampaignScreen(),
  ];

  late MainScreenController mainScreenController;

  @override
  void initState() {
    super.initState();
    mainScreenController = Get.put(MainScreenController());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MyScaffold(
      body: getBody(size),
      bottomNavigationBar: getBottomNavigationBar(size),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Image.asset(
          "assets/images/ic_qr.png",
          height: 50,
          width: 50,
        ),
        onPressed: () {},
      ),
      floatingActionLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  getBody(size) {
    return Obx(() {
      return FadeIndexedStack(
        index: mainScreenController.indexPage.value,
        children: pages,
      );
    });
  }

  getBottomNavigationBar(Size size) {
    return Obx(() {
      print("${mainScreenController.indexPage.value}");

        return FABBottomAppBar(
          selectedIndex: mainScreenController.indexPage.value,
          selectedColor: darkAppBarColor,
          notchedShape: CircularNotchedRectangle(),
          onTabSelected: (index) {
            mainScreenController.indexPage.value = index;
          },
          items: [
            FABBottomAppBarItem(
                iconDataUnSelected: "assets/images/ic_home_unselected.png",
                text: tr('Home'),
                iconDataSelected: 'assets/images/ic_home_selected.png'),
            FABBottomAppBarItem(
                iconDataUnSelected: "assets/images/ic_location_unselected.png",
                text: tr('Map'),
                iconDataSelected: 'assets/images/ic_location_selected.png'),
            FABBottomAppBarItem(
                iconDataUnSelected: "assets/images/ic_third_logo_unselected.png",
                text: tr('Discover'),
                iconDataSelected: 'assets/images/ic_third_logo_selected.png'),
            FABBottomAppBarItem(
                iconDataUnSelected: "assets/images/ic_settings_unselected.png",
                text: tr('Campaigns'),
                iconDataSelected: 'assets/images/ic_settings_selected.png'),
          ],
        );
      }
    );
  }
}
