import 'dart:convert';

import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:memberApp/main.dart';
import 'package:memberApp/models/user_model.dart';

import '../controlllers/api_controller.dart';
import '../utils/app_preferences.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/decorations.dart';
import '../utils/json_utils.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late APIController controller;
  var user = UserModel().obs;

  @override
  void initState() {
    super.initState();

    var userJson = globalPreferences?.getString(AppPreferences.USER_MODEL)??'{}';
    var jsonMap = jsonDecode(userJson);
    user.value =  UserModel.fromMap(jsonMap);

    controller = Get.put(
      APIController(),
      tag: NamedRoutes.routeProfile,
    );
    controller.baseModel.listen((baseModel) async {
      if (baseModel.status!) {
        if(baseModel.message == 'Member Data Retrieved'){
          var userModel = UserModel.fromMap(baseModel.data);
          user.value = userModel;
          globalPreferences?.setString(AppPreferences.USER_MODEL, jsonEncode(userModel.toJson()));
        }else{
          logoutUser();
        }
      }
    });

    getProfile();
  }

  Future<void> getProfile() async {
    controller.baseModel.value =
        await controller.webservice.apiCallFetchProfile(controller.isLoading);
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
        Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(220, 100)),
                  child: Container(
                    height: size.height * 0.25,
                    width: size.width,
                    color: appBarColor,
                  ),
                ),
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        const MyBackButton(),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Burger Week',
                                style:
                                    boldWhiteText18(normalTextAndButtonColor),
                                textAlign: TextAlign.center,
                              ),
                              CoolDropdown(
                                dropdownList: List.generate(
                                  languages.length,
                                  (index) {
                                    return languages[index];
                                  },
                                ).toList(),
                                dropdownWidth: 120,
                                resultWidth: 120,
                                resultHeight: 30,
                                dropdownHeight: 140,
                                dropdownPadding: EdgeInsets.zero,
                                selectedItemPadding: EdgeInsets.zero,
                                selectedItemBD: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                selectedItemTS:
                                    regularWhiteText12(Colors.white),
                                defaultValue: EasyLocalization.of(context)
                                            ?.currentLocale
                                            ?.languageCode ==
                                        'en'
                                    ? languages[0]
                                    : languages[1],
                                resultPadding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                resultBD:
                                    rectangularWhiteBoxDecorationWithRadiusElevation(
                                        20, 2),
                                resultTS: regularWhiteText8(Colors.black),
                                resultIcon: Image.asset(
                                  "assets/images/ic_arrow_down.png",
                                  height: 16,
                                  width: 16,
                                  color: Colors.grey,
                                ),
                                onChange: (item) {
                                  var selectedItem =
                                      (item as Map)['value'] as String;
                                  if (selectedItem == languages[0]['value']) {
                                    //en
                                    EasyLocalization.of(context)
                                        ?.setLocale(Locale('en'));
                                    Get.offNamedUntil(NamedRoutes.routeSplash,
                                        (route) => false);
                                    Future.delayed(Duration(milliseconds: 150),
                                        () {
                                      MyApp.restartApp(context);
                                    });
                                  } else {
                                    //ar
                                    EasyLocalization.of(context)
                                        ?.setLocale(Locale('ar'));
                                    Get.offNamedUntil(NamedRoutes.routeSplash,
                                        (route) => false);
                                    Future.delayed(Duration(milliseconds: 150),
                                        () {
                                      MyApp.restartApp(context);
                                    });
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                        horizontalSpace(width: 20)
                        // const Opacity(
                        //   child: MyBackButton(),
                        //   opacity: 0.0,
                        // ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.15,
                      ),
                      Obx(() {
                        var data = user.value;
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Card(
                                          shape: const CircleBorder(),
                                          elevation: 8,
                                          child: CircularAvatar(
                                              imagePath:
                                              "assets/images/ic_active_charity.png",
                                              imageSize: 150)),
                                      verticalSpace(height: 20),
                                      Text(
                                        "${data.name}",
                                        style: boldWhiteText16(darkAppBarColor),
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/ic_location.png",
                                            height: 10,
                                            width: 10,
                                          ),
                                          horizontalSpace(width: 5),
                                          Text(
                                            "${data.city}",
                                            style: regularWhiteText12(darkGreyColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              verticalSpace(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "HELLO",
                                        style: regularWhiteText12(darkGreyColor),
                                      ),
                                      verticalSpace(),
                                      Text(
                                        "25",
                                        style: regularWhiteText18(darkAppBarColor),
                                      ),
                                      verticalSpace(),
                                      Text(
                                        "HELLO",
                                        style: regularWhiteText12(darkGreyColor),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 1,
                                    height: 80,
                                    color: lightGreyColor.withOpacity(0.5),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "HELLO",
                                        style: regularWhiteText12(darkGreyColor),
                                      ),
                                      verticalSpace(),
                                      Text(
                                        "25",
                                        style: regularWhiteText18(darkAppBarColor),
                                      ),
                                      verticalSpace(),
                                      Text(
                                        "HELLO",
                                        style: regularWhiteText12(darkGreyColor),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 1,
                                    height: 80,
                                    color: lightGreyColor.withOpacity(0.5),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "HELLO",
                                        style: regularWhiteText12(darkGreyColor),
                                      ),
                                      verticalSpace(),
                                      Text(
                                        "23",
                                        style: regularWhiteText18(darkAppBarColor),
                                      ),
                                      verticalSpace(),
                                      Text(
                                        "HELLO",
                                        style: regularWhiteText12(darkGreyColor),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          );
                        }
                      )
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: SingleChildScrollView(
                  child: SafeArea(
                    top: false,
                    child: Column(
                      children: List.generate(
                          1,
                          (index) => Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      controller.baseModel.value =
                                          await controller
                                              .webservice
                                              .apiCallLogout(
                                                  controller.isLoading);
                                    },
                                    child: Container(
                                      width: size.width - 20,
                                      decoration:
                                          rectangularLightPurpleBoxDecorationWithRadiusElevation(
                                              10, 4),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                child: Image.asset(
                                                  "assets/images/ic_profile.png",
                                                  height: 30,
                                                  width: 30,
                                                ),
                                              ),
                                              Text(
                                                "Logout",
                                                style: regularWhiteText12(
                                                    Colors.white),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: RotatedBox(
                                              quarterTurns:
                                                  (EasyLocalization.of(context)
                                                              ?.currentLocale
                                                              ?.languageCode ==
                                                          'en')
                                                      ? 2
                                                      : 0,
                                              child: Image.asset(
                                                "assets/images/ic_back_button.png",
                                                height: 16,
                                                width: 16,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  verticalSpace(height: 10),
                                ],
                              )),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        GenericProgressBar(tag: NamedRoutes.routeProfile)
      ],
    );
  }
}
