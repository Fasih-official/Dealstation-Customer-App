import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/decorations.dart';
import '../utils/json_utils.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';

import '../utils/widgets.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
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
      bottom: false,
        child: Column(
      children: [
        verticalSpace(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const MyBackButton(),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                'Settings',
                style: boldWhiteText18(normalTextAndButtonColor),
              ),
            )
          ],
        ),
        verticalSpace(height: 20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
            child: SingleChildScrollView(
              child: SafeArea(
                top: false,
                child: Column(
                  children: List.generate(
                      settingsData.length,
                          (index) => Column(
                        children: [
                          Container(
                            width: size.width - 20,
                            decoration:
                            rectangularLightestGreyBoxDecorationWithRadiusElevation(
                                10, 4),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 15),
                                      child: Image.asset(
                                        settingsData[index]['image'] as String,
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                    Text(
                                      settingsData[index]['title'] as String,
                                      style:
                                      regularWhiteText12(darkGreyColor),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: RotatedBox(
                                    quarterTurns:         (EasyLocalization.of(context)
                                        ?.currentLocale
                                        ?.languageCode ==
                                        'en')
                                        ? 2
                                        : 0,
                                    child: Image.asset(
                                      "assets/images/ic_settings_forward.png",
                                      height: 16,
                                      width: 16,
                                    ),
                                  ),
                                )
                              ],
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
    ));
  }
}
