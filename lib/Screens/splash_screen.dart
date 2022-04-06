import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../utils/app_preferences.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _controller.forward(from: 0.0);

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.addListener(() {
      if (_animation.isCompleted) {
        if(isNotEmpty(globalPreferences?.getString(AppPreferences.TOKEN))){
          Get.offNamed(NamedRoutes.routeMain);
        }else{
          Get.offNamed(NamedRoutes.routeIntro);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MyScaffold(
      backgroundColor: appBarColor,
      body: getBody(size),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  getBody(Size size) {
    return Stack(
      children: [
        SafeArea(
          child: Container(
            alignment: Alignment.topCenter,
            height: size.height,
            child: Image.asset("assets/images/ic_text_splash.png"),
          ),
        ),
        FadeTransition(
          opacity: _animation,
          child: Center(
            child: SizedBox(
              child: Image.asset(
                'assets/images/ic_logo_deals_station.png',height: 200,width: 200,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

