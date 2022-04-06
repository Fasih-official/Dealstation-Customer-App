import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controlllers/api_controller.dart';
import '../models/membership_plan_model.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/decorations.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({Key? key}) : super(key: key);

  @override
  _PackagesScreenState createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  late APIController controller;

  var memberPlans = [].obs;

  var selectedIndex = (-1).obs;

  @override
  void initState() {
    super.initState();
    controller = Get.put(APIController(), tag: NamedRoutes.routePackage);

    fetchMemberPlans();
    controller.baseModel.listen((baseModel) {
      if (baseModel.status!) {
        memberPlans.value = (baseModel.data as List)
            .map((e) => MembershipPlanModel.fromMap(e))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(memberPlans.value.length);
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
            children: [
              MyBackButton(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
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
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Obx(() {
                  return MyCustomScrollBar(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          memberPlans.value.length,
                          (index) => buildProductListing(
                                memberPlans.value,
                                index,
                              )),
                    ),
                  );
                })),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() {
                return Container(
                  decoration: selectedIndex.value < 0
                      ? rectangularLighterGreyBoxDecorationWithRadius(4)
                      : rectangularDarkGreyAppBarBoxDecorationWithRadius(4),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(NamedRoutes.routeMembership, arguments: {
                          'id': (memberPlans.value[selectedIndex.value]
                                  as MembershipPlanModel)
                              .id,
                          'data': (memberPlans.value[selectedIndex.value]
                              as MembershipPlanModel),
                        });
                      },
                      child: CustomizedButton(
                        text: tr('Continue'),
                        verticalPadding: 16,
                      ),
                    ),
                  ),
                );
              })),
          verticalSpace(height: 20),
        ],
      ),
    );
  }

  Widget buildProductListing(membershipPlan, index) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
        child: Obx(() {
          return GestureDetector(
            onTap: () {
              selectedIndex.value = index;
            },
            child: CardPackage(
              membershipPlan: membershipPlan,
              index: index,
              selectedIndex: selectedIndex.value,
            ),
          );
        }));
  }

  Future<void> fetchMemberPlans() async {
    controller.baseModel.value = await controller.webservice
        .apiCallFetchMemberPlans(controller.isLoading);
  }
}
