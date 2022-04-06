import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/decorations.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';

import '../utils/widgets.dart';

class PaymentModeScreen extends StatefulWidget {
  const PaymentModeScreen({Key? key}) : super(key: key);

  @override
  _PaymentModeScreenState createState() => _PaymentModeScreenState();
}

class _PaymentModeScreenState extends State<PaymentModeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MyScaffold(
      extendBodyBehindAppBar: true,
      body: getBody(size),
      backgroundColor: Colors.white,
    );
  }

  getBody(Size size) {
    return SafeArea(
        child: Column(
          children: [
            verticalSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyBackButton(),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Text(
                    tr('Payment Modes'),
                    style: boldWhiteText18(normalTextAndButtonColor),
                  ),
                )
              ],
            ),
            verticalSpace(height: 20),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Image.asset("assets/images/ic_money.png", height: 180,width: 180,),
                    verticalSpace(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(tr("Choose Card"),style: boldWhiteText14(darkAppBarColor),),

                      ],
                    ),
                    verticalSpace(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              Get.toNamed(NamedRoutes.routeCoupon);
                            },

                            child: Container(
                              decoration:
                              rectangularDarkGreyAppBarBoxDecorationWithRadius(4),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset("assets/images/ic_credit_card.png", height: 20,width: 20,),
                                        RotatedBox(
                                          quarterTurns:(EasyLocalization.of(context)
                                              ?.currentLocale
                                              ?.languageCode ==
                                              'en')
                                              ? 2
                                              : 0,
                                          child: Image.asset('assets/images/ic_forward.png', height: 16,width: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    verticalSpace(height: 10),
                                    Text(tr("Card Info"),style: regularWhiteText12(Colors.white),),
                                    verticalSpace(height: 5),

                                    Text("1234567",style: regularWhiteText12(Colors.white),),
                                    verticalSpace(height: 5),

                                    Text("20/10/2022",style: regularWhiteText12(Colors.white),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        horizontalSpace(),
                        Expanded(
                          child: GestureDetector(
                            onTap: (){
                              Get.toNamed(NamedRoutes.routeCredit);
                            },
                            child: Container(
                              decoration:
                              rectangularDarkGreyAppBarBoxDecorationWithRadius(4),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset("assets/images/ic_credit_card.png", height: 20,width: 20,),
                                        RotatedBox(
                                          quarterTurns:                  (EasyLocalization.of(context)
                                              ?.currentLocale
                                              ?.languageCode ==
                                              'en')
                                              ? 2
                                              : 0,
                                          child: Image.asset('assets/images/ic_forward.png', height: 16,width: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    verticalSpace(height: 10),
                                    Text("Basati",style: regularWhiteText12(Colors.white),),
                                    verticalSpace(height: 5),

                                    Text("1234567",style: regularWhiteText12(Colors.white),),
                                    verticalSpace(height: 5),

                                    Text("20/10/2022",style: regularWhiteText12(Colors.white),),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: rectangularLighterGreyBoxDecorationWithRadius(4),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CustomizedButton(
                    text: 'Add a new card',
                    verticalPadding: 16,
                  ),
                ),
              ),
            ),
            verticalSpace(height: 20),

          ],
        ));
  }
}
