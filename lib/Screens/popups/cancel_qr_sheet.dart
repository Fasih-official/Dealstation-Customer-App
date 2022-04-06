import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/decorations.dart';
import '../../utils/styles.dart';
import '../../utils/utils.dart';

class CancelQRSheet extends StatelessWidget {
  const CancelQRSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: rectangularCustomColorBoxDecorationWithRadius(
          20, 0, 0, 20, Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: DottedBorder(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/ic_qr_adidas.png',height: 180,),
                      verticalSpace(),
                      Text(
                        'BASIC Crew Neck Short Sleeve\nBasic Men\'s T-Shirt',
                        style: regularWhiteText12(normalTextAndButtonColor),
                        textAlign: TextAlign.center,
                      ),
                      verticalSpace(),
                      Image.asset('assets/images/ic_tick.png',height: 56,),
                      verticalSpace(height: 5),
                      Text(
                        'Cancel',
                        style: boldWhiteText14(normalTextAndButtonColor),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          color: lightGreyColor,
          radius: const Radius.circular(8),
          dashPattern: [6, 6],
          borderType: BorderType.RRect,
        ),
      ),
    );
  }
}
