import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:get/get.dart';
import 'package:memberApp/models/dashboard_model.dart';

import '../controlllers/api_controller.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class DailyPromotionsScreen extends StatefulWidget {
  const DailyPromotionsScreen({Key? key}) : super(key: key);

  @override
  _DailyPromotionsScreenState createState() => _DailyPromotionsScreenState();
}

class _DailyPromotionsScreenState extends State<DailyPromotionsScreen> {
  late APIController controller;
  var offers = <OffersBean>[].obs;

  @override
  void initState() {
    super.initState();

    controller = Get.put(
      APIController(),
      tag: NamedRoutes.routeDailyPromotions,
    );

    controller.baseModel.listen((baseModel) async {
      if (baseModel.status!) {
        offers.value =
            (baseModel.data as List).map((e) => OffersBean.fromMap(e)).toList();
      }
    });

    fetchPromotions();
  }

  Future<void> fetchPromotions() async {
    controller.baseModel.value = await controller.webservice.apiCallFetchDiscoveryOffers(controller.isLoading);
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      extendBodyBehindAppBar: true,
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
      top: false,
      bottom: true,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 520,
                child: Obx(() {
                  var length = offers.value.length;
                  return TinderSwapCard(
                    orientation: AmassOrientation.BOTTOM,
                    totalNum: length,
                    stackNum: 3,
                    swipeEdge: 8.0,
                    allowVerticalMovement: false,
                    maxWidth: (MediaQuery.of(context).size.width - 80),
                    maxHeight: 420,
                    minWidth: (MediaQuery.of(context).size.width - 82),
                    minHeight: 380,
                    cardBuilder: (context, index) {
                      var offer = offers.value[index];
                      return VerticalCardProduct(index: index, offer: offer,);
                    },
                    cardController: CardController(),
                    swipeUpdateCallback:
                        (DragUpdateDetails details, Alignment align) {
                      /// Get swiping card's alignment
                      if (align.x < 0) {
                        //Card is LEFT swiping
                      } else if (align.x > 0) {
                        //Card is RIGHT swiping
                      }
                    },
                    swipeCompleteCallback:
                        (CardSwipeOrientation orientation, int index) {
                      /// Get orientation & index of swiped card!
                    },
                  );
                }),
              ),
            ],
          ),
          GenericProgressBar(tag: NamedRoutes.routeDailyPromotions)
        ],
      ),
    );
  }

  Widget buildProductListing(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
      child: CardProduct(
        index: index,
        offers: [],
      ),
    );
  }
}
