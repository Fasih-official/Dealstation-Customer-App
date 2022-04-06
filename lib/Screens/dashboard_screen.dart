import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberApp/models/dashboard_model.dart';
import 'package:memberApp/services/web_services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controlllers/api_controller.dart';
import '../controlllers/main_screen_controller.dart';
import '../utils/constants.dart';
import '../utils/decorations.dart';
import '../utils/json_utils.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  CarouselController carouselController = CarouselController();
  var activeIndex = 0.obs;

  late APIController controller;
  var dashBoardData = DashboardModel().obs;

  @override
  void initState() {
    super.initState();

    controller = Get.put(APIController(), tag: NamedRoutes.routeDashboard);

    fetchDashBoardData();
    controller.baseModel.listen((baseModel) {
      if (baseModel.status!) {
        dashBoardData.value = DashboardModel.fromMap(baseModel.data);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MyScaffold(
      extendBodyBehindAppBar: true,
      appBar: getAppBar(),
      body: getBody(size),
    );
  }

  getAppBar() {
    return PreferredSize(
      child: MyAppBar(),
      preferredSize: Size.fromHeight(65),
    );
  }

  getBody(Size size) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Stack(
                children: [
                  CarouselSlider.builder(
                    carouselController: carouselController,
                    itemCount:
                        (dashBoardData.value.advertisements?.length) ?? 0,
                    options: CarouselOptions(
                        height: 240,
                        autoPlay: true,
                        viewportFraction: 1,
                        reverse: false,
                        aspectRatio: 5.0,
                        onPageChanged: (index, reason) {
                          activeIndex.value = index;
                        }),
                    itemBuilder: (context, index, id) {
                      //for onTap to redirect to another screen
                      var advertisement =
                          dashBoardData.value.advertisements?[index];
                      return Stack(
                        children: [
                          CircularAvatar(
                            imagePath: '${advertisement?.advertisementImage}',
                            imageWidth: size.width,
                            imageHeight: 240,
                            imageSize: 0,
                          ),
                          Positioned(
                            left: 20,
                            bottom: 40,
                            right: 20,
                            child: Row(
                              children: [
                                Text(
                                  tr('${advertisement?.advertisementName}'),
                                  style: boldWhiteText20(Colors.white),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  Positioned(
                    left: 20,
                    bottom: 10,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() {
                          return AnimatedSmoothIndicator(
                            activeIndex: activeIndex.value,
                            count: (dashBoardData.value.advertisements?.length) ?? 0,
                            effect: const ScrollingDotsEffect(
                                dotWidth: 6.0,
                                dotHeight: 6.0,
                                activeDotColor: Colors.white),
                          );
                        })
                      ],
                    ),
                  )
                ],
              );
            }),
            verticalSpace(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: MyCustomScrollBar(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyCustomScrollBar(
                        axis: Axis.horizontal,
                        child: Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(
                              (dashBoardData.value.categories ?? []).length,
                                  (index) => GestureDetector(
                                  onTap: () async {
                                    if (isNotEmpty(dashBoardData.value.categories)) {
                                      Get.toNamed(NamedRoutes.routeExploreCategory,
                                          arguments: {
                                            'name': dashBoardData
                                                .value.categories![index].categoryName,
                                            'categoryID': dashBoardData
                                                .value.categories![index].id
                                          });
                                    }
                                  },
                                  child: CategoryCard(
                                    index: index,
                                    categories: dashBoardData.value.categories ?? [],
                                  )),
                            ),
                          );
                        }),
                      ),
                      verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(NamedRoutes.routeExploreCategory,
                                      arguments: {
                                        'name': 'Promo Code Offers',
                                        'type': 'code'
                                      });
                                },
                                child: Container(
                                  decoration:
                                      rectangularAppBarBoxDecorationWithRadius(
                                          4),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            tr('Promo code offers'),
                                            style:
                                                boldWhiteText14(Colors.white),
                                          ),
                                        ),
                                        horizontalSpace(),
                                        Image.asset(
                                          'assets/images/ic_sale_tag.png',
                                          height: 80,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            horizontalSpace(),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(NamedRoutes.routeExploreCategory,
                                      arguments: {
                                        'name': 'Best Offers',
                                        'type': 'qr'
                                      });
                                },
                                child: Container(
                                  decoration:
                                      rectangularLighterGreyBoxDecorationWithRadius(
                                          4),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            tr('Best Offers'),
                                            style:
                                                boldWhiteText14(Colors.white),
                                          ),
                                        ),
                                        horizontalSpace(),
                                        Image.asset(
                                          'assets/images/ic_shop_now.png',
                                          height: 80,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(),
                      SafeArea(
                          top: false,
                          child: Obx(() {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(
                                  (dashBoardData.value.offers ?? []).length,
                                  (index) => buildProductListing(
                                      index, dashBoardData.value.offers!)),
                            );
                          }))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        GenericProgressBar(tag: NamedRoutes.routeDashboard)
      ],
    );
  }

  Widget buildProductListing(int index, offers) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            NamedRoutes.routeOfferDetail,
            arguments: offers?[index].id,
          );
        },
        child: CardProduct(
          index: index,
          offers: offers,
        ),
      ),
    );
  }

  void fetchDashBoardData() async {
    controller.baseModel.value = await controller.webservice
        .apiCallFetchDashboardData(controller.isLoading);
  }
}
