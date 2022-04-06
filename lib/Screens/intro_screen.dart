import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/widgets.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late List<Widget> pages;
  CarouselController carouselController = CarouselController();

  int activeIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pages = [
      IntroScreen1(
        callBack: () {
          _navigateToScreen();
        },
        text: 'مليت من العروض المزيفة ؟ وتبغى عروض وخصومات حقيقية ؟',
      ),
      IntroScreen1(
        callBack: () {
          _navigateToScreen();
        }, text: 'تطبيق ديل ستيشن يوفر المصداقية والثقة في كل مرة تشتري فيها وبأسعار مخفضة، وفي عدة أسواق بالمملكة.',
      ),
      IntroScreen1(
        callBack: () {
          _navigateToScreen();
        }, text: 'ديل ستيشن يوفر لمشتركيه الاطلاع الدائم على العروض المميزة من شركاء النجاح من محال البيع ومرافق تقديم الخدمات، ويقدم خطط أسعار مناسبة من خلال باقات الشراء وقسائم الخصومات للعديد من المنتجات والخدمات العالمية والمحلية داخل المملكة',
      ),
    ];
  }

  void _navigateToScreen() {
    // Get.toNamed(NamedRoutes.routeMain);
    Get.toNamed(NamedRoutes.routeSignUp);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MyScaffold(
      body: getBody(size),
    );
  }

  getBody(Size size) {
    return Stack(
      children: [
        CarouselSlider.builder(
          carouselController: carouselController,
          itemCount: pages.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  pages[itemIndex],
          options: CarouselOptions(
              height: size.height,
              // aspectRatio: 0.9,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              }),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedSmoothIndicator(
                  activeIndex: activeIndex,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                      dotWidth: 6.0,
                      dotHeight: 6.0,
                      activeDotColor: appBarColor),
                ),
              ],
            ))
      ],
    );
  }
}
