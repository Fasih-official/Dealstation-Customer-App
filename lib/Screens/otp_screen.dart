import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberApp/controlllers/ui_controller.dart';
import 'package:memberApp/utils/handlers.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../controlllers/api_controller.dart';
import '../services/firebase_service.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/decorations.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    Key? key,
  }) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String verificationId = '';
  var phoneNumber = '';
  bool registrationFlow = false;

  final _pinCodeController = TextEditingController();

  late APIController controller;
  late UIController uiController;

  @override
  void initState() {
    super.initState();

    controller = Get.put(
      APIController(),
      tag: NamedRoutes.routeOTP,
    );

    uiController = Get.put(
      UIController(),
      tag: NamedRoutes.routeOTP,
    );

    controller.baseModel.listen((baseModel) async {
      if (baseModel.status!) {
        navigateUserToPage(baseModel,
            route: NamedRoutes.routeMain,
            navigationType: 'push_current_on_stack_and_pop_all_previous_route');
      }
    });

    var mapArgs = Get.arguments;
    phoneNumber = mapArgs['phone'];
    registrationFlow = mapArgs['registrationFlow'];

    listenForOTPChanges();

    sendOTP();
  }

  void sendOTP() {
    uiController.startCountDownTimer();
    FirebaseService().serviceVerifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) {
        //Android Only
        signIn(credential);
      },
      verificationFailed: (exc) {
        Handlers().apiExceptionHandler(exc, (errMsg) => showToast(errMsg));
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId = verificationId;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MyScaffold(
      body: getBody(size),
    );
  }

  getBody(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/images/ic_bg_sign_up.png",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              verticalSpace(height: 20),
              SafeArea(
                child: Row(
                  children: [
                    MyBackButton(),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: MyCustomScrollBar(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Please enter your OTP",
                            style: boldWhiteText14(
                              normalTextAndButtonColor,
                            ),
                          ),
                        ),
                        verticalSpace(height: 40),
                        Container(
                          decoration:
                              ellipticalCustomColorBoxDecorationWithRadius(
                            220,
                            120,
                            appBarColor,
                            top: true,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                verticalSpace(height: 80),
                                PinFieldAutoFill(
                                  cursor: Cursor(
                                    color: Colors.black,
                                    enabled: true,
                                    width: 1,
                                  ),
                                  currentCode: "",
                                  controller: _pinCodeController,
                                  onCodeSubmitted: (smsCode) {
                                    print('onCodeChanged-->${smsCode}');
                                    PhoneAuthCredential credential =
                                        PhoneAuthProvider.credential(
                                      verificationId: verificationId,
                                      smsCode: smsCode,
                                    );
                                    signIn(credential);
                                  },
                                  //code submitted callback
                                  onCodeChanged: (code) {
                                  },
                                  codeLength: 6, //code length, default 6
                                ),
                                verticalSpace(height: 80),
                                Column(
                                  children: [
                                    Text(
                                      "Require English Text here",
                                      style: regularWhiteText12(
                                        normalTextAndButtonColor,
                                      ),
                                    ),
                                    verticalSpace(height: 5),
                                    Obx(() {
                                      return GestureDetector(
                                        onTap: () {
                                          if ((uiController
                                                  .resendOTPStatus.value) <
                                              1) {
                                            sendOTP();
                                          }
                                        },
                                        child: Text(
                                          (uiController.resendOTPStatus.value) >
                                                  0
                                              ? "Resend OTP in ${uiController.resendOTPStatus.value}s"
                                              : "Resend",
                                          style: boldWhiteText14(
                                            normalTextAndButtonColor,
                                            decoration: (uiController
                                                        .resendOTPStatus
                                                        .value) >
                                                    0
                                                ? null
                                                : TextDecoration.underline,
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                                verticalSpace(height: 80),
                                SafeArea(
                                  top: false,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        PhoneAuthCredential credential =
                                            PhoneAuthProvider.credential(
                                          verificationId: verificationId,
                                          smsCode: _pinCodeController.text,
                                        );
                                        signIn(credential);
                                      },
                                      child: Container(
                                        decoration:
                                            rectangularDarkAppBarBoxDecorationWithRadiusElevation(
                                                10, 2),
                                        child: CustomizedButton(
                                          text: tr('Confirm'),
                                          verticalPadding: 20,
                                          textColor: Colors.white,
                                          img: '',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                verticalSpace(height: 20)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          GenericProgressBar(
            tag: NamedRoutes.routeOTP,
          )
        ],
      ),
    );
  }

  void signIn(credential) {
    FirebaseService().loginUser(credential).then((value) async {
      if (isNotEmpty(value)) {
        //Phone Verified Successfully
        if (registrationFlow) {
          Get.offAndToNamed(
            NamedRoutes.routeRegistration,
            arguments: {'phone': phoneNumber},
          );
        } else {
          await doLogin(phoneNumber);
        }
      }
    });
  }

  Future<void> doLogin(phoneNumber) async {
    controller.baseModel.value = await controller.webservice.apiCallSignIn({
      'phone': phoneNumber,
    }, controller.isLoading);
  }

  @override
  void dispose() {
    _pinCodeController.dispose();
    unregisterListener();
    super.dispose();
  }

  void listenForOTPChanges() async{
    await SmsAutoFill().listenForCode;
  }

  void unregisterListener() async{
    await SmsAutoFill().unregisterListener();
  }
}
