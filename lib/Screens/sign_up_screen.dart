import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:memberApp/controlllers/ui_controller.dart';

import '../controlllers/api_controller.dart';
import '../main.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/decorations.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';
import 'package:country_code_picker/country_code_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();

  late APIController controller;
  late UIController uiController;

  String selectedPhoneNumber = '';

  @override
  void initState() {
    super.initState();
    controller = Get.put(
      APIController(),
      tag: NamedRoutes.routeSignUp,
    );
    uiController = Get.put(
      UIController(),
      tag: NamedRoutes.routeSignUp,
    );
    controller.baseModel.listen((baseModel) async {
      if (baseModel.status!) {
        Get.toNamed(
          NamedRoutes.routeOTP,
          arguments: {
            'phone': selectedPhoneNumber,
            'registrationFlow': false,
          },
        );
      } else {
        Get.toNamed(
          NamedRoutes.routeOTP,
          arguments: {
            'phone': selectedPhoneNumber,
            'registrationFlow': true,
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MyScaffold(
      body: getBody(size),
    );
  }

  getBody(Size size) {
    return MyCustomScrollBar(
      child: Column(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/ic_bg_sign_up.png",
                    ),
                    fit: BoxFit.cover)),
            child: Stack(
              children: [
                Column(
                  children: [
                    verticalSpace(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            verticalSpace(height: 20),
                            Image.asset(
                              "assets/images/ic_deal_station.png",
                              height: 200,
                              width: 200,
                            ),
                            Text(tr("Welcome to"),
                                style: boldWhiteText32(darkAppBarColor)),
                            Text(
                              tr("Deals Station!"),
                              style: boldWhiteText32(darkAppBarColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    verticalSpace(height: 40),
                    Expanded(
                      child: Container(
                        decoration:
                            rectangularYellowBoxDecorationWithRadiusElevation(
                                40, 2),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20),
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "To register please enter your cell number below",
                                    style: boldWhiteText14(Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration:
                                      rectangularWhiteBoxDecorationWithRadiusElevation(
                                          20, 2),
                                  child: Row(
                                    children: [
                                      horizontalSpace(),
                                      Obx(() {
                                        return CountryCodePicker(
                                          onChanged: (code) {
                                            uiController
                                                .onCountryCodePicked(code);
                                          },
                                          initialSelection: uiController
                                              .selectedCountryCode.value,
                                          padding: EdgeInsets.zero,
                                          showFlag: true,
                                        );
                                      }),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: MyTextField(
                                            hint: tr("Enter phone number"),
                                            keyboardType: TextInputType.phone,
                                            verticalPad: 12.0,
                                            controller: _phoneNumber,
                                          ),
                                        ),
                                      ),
                                      horizontalSpace(),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 40.0),
                                  child: Text(
                                    "Brief description",
                                    style: regularWhiteText12(darkGreyColor),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (isNotEmpty(_phoneNumber.text)) {
                                      if (_phoneNumber.text.startsWith('0')) {
                                        selectedPhoneNumber =
                                            "${uiController.selectedCountryCode.value}${_phoneNumber.text.substring(1, _phoneNumber.text.length)}";
                                      } else {
                                        selectedPhoneNumber =
                                            "${uiController.selectedCountryCode.value}${_phoneNumber.text}";
                                      }

                                      controller.baseModel.value =
                                          await controller.webservice
                                              .apiCallPhoneStatus({
                                        'phone': selectedPhoneNumber,
                                      }, controller.isLoading);
                                    } else {
                                      showToast('Please fill the phone number');
                                    }
                                  },
                                  child: Container(
                                    decoration:
                                        rectangularDarkAppBarBoxDecorationWithRadiusElevation(
                                            10, 2),
                                    child: CustomizedButton(
                                      text: tr('Register Now'),
                                      verticalPadding: 20,
                                      textColor: Colors.white,
                                      img: '',
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                GenericProgressBar(
                  tag: NamedRoutes.routeSignUp,
                )
              ],
            ),

            // child: Image.asset("assets/images/ic_bg_sign_up.png",fit: BoxFit.cover,),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _phoneNumber.dispose();
    countryCodeController.dispose();
    super.dispose();
  }
}
