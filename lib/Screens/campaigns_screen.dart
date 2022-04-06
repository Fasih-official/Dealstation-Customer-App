import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:memberApp/models/campaigns_model.dart';
import 'package:memberApp/utils/utils.dart';

import '../controlllers/api_controller.dart';
import '../utils/constants.dart';
import '../utils/styles.dart';
import '../utils/widgets.dart';

class CampaignScreen extends StatefulWidget {
  const CampaignScreen({Key? key}) : super(key: key);

  @override
  _CampaignScreenState createState() => _CampaignScreenState();
}

class _CampaignScreenState extends State<CampaignScreen> {
  late APIController controller;

  var campaigns = <CampaignsModel>[].obs;

  @override
  void initState() {
    super.initState();

    controller = Get.put(
      APIController(),
      tag: NamedRoutes.routeCampaigns,
    );

    //listeners
    controller.baseModel.listen((baseModel) async {
      if (baseModel.status!) {
        campaigns.value = (baseModel.data as List)
            .map((e) => CampaignsModel.fromMap(e))
            .toList();
      }
    });

    //API calls
    fetchCampaigns();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MyScaffold(
      body: getBody(size),
    );
  }

  getBody(Size size) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          MyAppBar(),
          Expanded(
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Obx(() {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                            campaigns.value.length,
                            (index) => GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  NamedRoutes.routeExploreCategory,
                                  arguments: {
                                    'name': campaigns.value[index].campaignName,
                                    'campaignID': campaigns.value[index].id
                                  },
                                );
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 130,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          "${campaigns.value[index].campaignBanner}",
                                        ),
                                        fit: BoxFit.fitWidth
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${campaigns.value[index].campaignName}",
                                                style: boldWhiteText14(Colors.white),
                                              ),
                                              RotatedBox(
                                                  quarterTurns:
                                                      (EasyLocalization.of(context)
                                                                  ?.currentLocale
                                                                  ?.languageCode ==
                                                              'en')
                                                          ? 2
                                                          : 0,
                                                  child: Image.asset(
                                                    "assets/images/ic_forward.png",
                                                    height: 20,
                                                    width: 20,
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.symmetric(horizontal: 20),
                                            child: Text(
                                              "${campaigns.value[index].offers_count} quantity",
                                              style: boldWhiteText14(Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  verticalSpace(),
                                ],
                              ),
                            ),
                          )),
                    );
                  }),
                ),
                GenericProgressBar(tag: NamedRoutes.routeCampaigns)
              ],
            ),
          ),
        ],
      ),
    );
  }

  void fetchCampaigns() async {
    controller.baseModel.value =
        await controller.webservice.apiCallFetchCampaigns(controller.isLoading);
  }
}
