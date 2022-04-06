import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberApp/models/membership_plan_model.dart';

import '../controlllers/api_controller.dart';
import '../models/subscription_plan_model.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/decorations.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';
import 'package:easy_localization/easy_localization.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({Key? key}) : super(key: key);

  @override
  _MembershipScreenState createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  var seletedIndex = (-1).obs;
  late APIController controller;
  int planId = -1;
  late MembershipPlanModel membershipPlanModel;
  var subscriptionPlans = [].obs;

  @override
  void initState() {
    super.initState();
    controller = Get.put(APIController(), tag: NamedRoutes.routeMembership);

    var mapArgs = Get.arguments;
    planId = mapArgs['id'];
    membershipPlanModel = mapArgs['data'] as MembershipPlanModel;

    fetchSubscriptionPlans(planId);
    controller.baseModel.listen((baseModel) {
      if (baseModel.message!.contains('Membership Subscription Data Fetched')) {
        subscriptionPlans.value = (baseModel.data as List)
            .map((e) => SubscriptionPlanModel.fromMap(e))
            .toList();
      } else {
        if (baseModel.status!) {
          Get.offNamedUntil(NamedRoutes.routeMain, (route) => false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      extendBodyBehindAppBar: true,
      body: getBody(),
      backgroundColor: Colors.white,
    );
  }

  getBody() {
    return SafeArea(
      child: Column(
        children: [
          verticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyBackButton(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 20),
                  child: Text(
                    tr('Memberships'),
                    style: boldWhiteText18(normalTextAndButtonColor),
                  ),
                ),
              )
            ],
          ),
          verticalSpace(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                children: [
                  Container(
                      decoration:
                          rectangularWhiteBoxDecorationWithRadiusElevation(
                              8, 2),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: DottedBorder(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircularAvatar(
                                          imagePath: '${membershipPlanModel.planIcon}',
                                          imageSize: 0,
                                          imageWidth: 40,
                                          imageHeight: 60,
                                          isNetworkImage: true,
                                        ),
                                        horizontalSpace(),
                                        Text(
                                          tr('${membershipPlanModel.planName}'),
                                          style: boldWhiteText14(
                                              normalTextAndButtonColor),
                                        )
                                      ],
                                    ),
                                    horizontalSpace(),
                                    Container(
                                        width: 36,
                                        height: 36,
                                        decoration:
                                            circularCustomColorBoxDecorationWithRadiusElevation(
                                                appBarColor, 2),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/images/ic_dart_tick.png',
                                            height: 16,
                                          ),
                                        ))
                                  ],
                                ),
                                verticalSpace(),
                                Expanded(
                                  child: MyCustomScrollBar(
                                    child: Obx(() {
                                      return Column(
                                        children: List.generate(
                                          subscriptionPlans.value.length,
                                          (index) => GestureDetector(
                                            onTap: () {
                                              if (seletedIndex.value == index) {
                                                seletedIndex.value = -1;
                                              } else {
                                                seletedIndex.value = index;
                                              }
                                            },
                                            child: Column(
                                              children: [
                                                verticalSpace(height: 5),
                                                Visibility(
                                                  // visible: (index ==
                                                  //     seletedIndex.value),
                                                  visible: false,
                                                  child: Container(
                                                    decoration:
                                                        rectangularLightestGreyBoxDecorationWithRadiusElevation(
                                                            2, 2),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 12,
                                                          vertical: 12),
                                                      child: DotAndText(),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  // decoration: (index ==
                                                  //         seletedIndex.value)
                                                  //     ? rectangularCustomColorBoxDecorationWithRadius(
                                                  //         4,
                                                  //         4,
                                                  //         4,
                                                  //         4,
                                                  //         normalTextAndButtonColor,
                                                  //       )
                                                  //     : rectangularLightPurpleBoxDecorationWithRadiusElevation(
                                                  //         4,
                                                  //         2,
                                                  //       ),
                                                  decoration:
                                                      rectangularLightPurpleBoxDecorationWithRadiusElevation(
                                                    4,
                                                    2,
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 12,
                                                        vertical: 12),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: RichText(
                                                                      text:
                                                                          TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                // "${tr('Subscription Plans')} "
                                                                                (subscriptionPlans.value[index] as SubscriptionPlanModel).subscriptionName,
                                                                            style:
                                                                                boldWhiteText14(
                                                                              Colors
                                                                                  .white,
                                                                            ),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                ' / ${(subscriptionPlans.value[index] as SubscriptionPlanModel).subscriptionDuration} Months',
                                                                            style: boldWhiteText14(
                                                                                appBarColor),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  horizontalSpace(),
                                                                ],
                                                              ),
                                                            ),
                                                            horizontalSpace(),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                controller.baseModel
                                                                        .value =
                                                                    await controller
                                                                        .webservice
                                                                        .apiCallSubscribeChildMemberPlan({
                                                                  "plan": planId,
                                                                  "subscription":
                                                                      (subscriptionPlans
                                                                                  .value[index]
                                                                              as SubscriptionPlanModel)
                                                                          .id
                                                                }, controller.isLoading);
                                                              },
                                                              child: Container(
                                                                // decoration: (index ==
                                                                //         seletedIndex
                                                                //             .value)
                                                                //     ? rectangularLightPurpleBoxDecorationWithRadiusElevation(
                                                                //         4,
                                                                //         2,
                                                                //       )
                                                                //     : rectangularCustomColorBoxDecorationWithRadius(
                                                                //         4,
                                                                //         4,
                                                                //         4,
                                                                //         4,
                                                                //         normalTextAndButtonColor,
                                                                //       ),
                                                                decoration:
                                                                    rectangularCustomColorBoxDecorationWithRadius(
                                                                  4,
                                                                  4,
                                                                  4,
                                                                  4,
                                                                  normalTextAndButtonColor,
                                                                ),
                                                                child:
                                                                    const Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                  child:
                                                                      CustomizedButton(
                                                                    verticalPadding:
                                                                        8,
                                                                    text:
                                                                        'Subscribe Now',
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        verticalSpace(height: 5),
                                                        Text(
                                                          "Price: ${(subscriptionPlans.value[index] as SubscriptionPlanModel).subscriptionPrice}",
                                                          style:
                                                          boldWhiteText14(
                                                            Colors
                                                                .white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                verticalSpace(height: 5),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                )
                              ],
                            ),
                          ),
                          color: lightGreyColor,
                          radius: const Radius.circular(8),
                          dashPattern: [6, 6],
                          borderType: BorderType.RRect,
                        ),
                      )),
                  GenericProgressBar(tag: NamedRoutes.routeMembership)
                ],
              ),
            ),
          ),
          verticalSpace(height: 20),
        ],
      ),
    );
  }

  void fetchSubscriptionPlans(int planId) async {
    controller.baseModel.value = await controller.webservice
        .apiCallFetchChildMemberPlans(planId, controller.isLoading);
  }
}
