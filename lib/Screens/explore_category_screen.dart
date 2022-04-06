import 'package:flutter/cupertino.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:memberApp/models/campaigns_model.dart';
import 'package:memberApp/models/dashboard_model.dart';

import '../controlllers/api_controller.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class ExploreCategoryScreen extends StatefulWidget {
  const ExploreCategoryScreen({Key? key}) : super(key: key);

  @override
  _ExploreCategoryScreenState createState() => _ExploreCategoryScreenState();
}

class _ExploreCategoryScreenState extends State<ExploreCategoryScreen> {
  late APIController controller;

  var offers = List<OffersBean>.empty().obs;

  String name = '';

  @override
  void initState() {
    super.initState();

    name = (Get.arguments as Map)['name'];

    controller = Get.put(
      APIController(),
      tag: NamedRoutes.routeExploreCategory,
    );

    //listeners
    controller.baseModel.listen((baseModel) async {
      if (baseModel.status!) {
        offers.value =
            (baseModel.data as List).map((e) => OffersBean.fromMap(e)).toList();
      }
    });

    //API calls
    fetchOffers();
  }

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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(),
              FiltersAndAdidas(
                exploreCategory: true,
                name: name,
              ),
              verticalSpace(),
              Expanded(
                child: Container(
                  color: sandColor,
                  padding: EdgeInsets.only(top: 20),
                  child: Obx(() {
                    return (offers.value.length >0)? ListView.builder(
                      itemCount: offers.value.length,
                      itemBuilder: (_, index) => buildProductListing(index),
                    ):NoDataFound();
                  }),
                ),
              )
            ],
          ),
          GenericProgressBar(
            tag: NamedRoutes.routeExploreCategory,
          )
        ],
      ),
    );
  }

  Widget buildProductListing(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(NamedRoutes.routeOfferDetail, arguments: offers.value[index].id);
        },
        child: CardProduct(
          index: index,
          offers: offers.value,
        ),
      ),
    );
  }

  void fetchOffers() async {
    var campaignID = (Get.arguments as Map)['campaignID'];
    var categoryID = (Get.arguments as Map)['categoryID'];
    var type = (Get.arguments as Map)['type'];
    if (isNotEmpty(campaignID)) {
      controller.baseModel.value = await controller.webservice
          .apiCallCampaignOffers(campaignID, controller.isLoading);
    } else if (isNotEmpty(categoryID)) {
      controller.baseModel.value = await controller.webservice
          .apiCallCategorizedOffers(categoryID, controller.isLoading);
    }else if (isNotEmpty(type)) {
      controller.baseModel.value = await controller.webservice
          .apiCallFetchOffersByType(type, controller.isLoading);
    }
  }
}
