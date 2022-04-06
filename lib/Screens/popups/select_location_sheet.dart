import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/decorations.dart';
import '../../utils/styles.dart';
import '../../utils/utils.dart';
import '../../utils/widgets.dart';

class SelectLocationSheet extends StatelessWidget {
  const SelectLocationSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: rectangularCustomColorBoxDecorationWithRadius(
          20, 0, 0, 20, Colors.white),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: DottedBorder(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: rectangularLighterGreyBoxDecorationWithRadius(4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                      child: MyCustomScrollBar(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(
                           20,
                            (index) {
                              return GestureDetector(
                                onTap: (){
                                  onTapCity(context);
                                },
                                child: Column(
                                  children: [
                                    Text('Jeddah',style: boldWhiteText14(Colors.white),),
                                    verticalSpace(),
                                    DotWidget(
                                      dashHeight: 0.5,
                                      dashWidth: 5,
                                    ),
                                    verticalSpace(),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
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

  void onTapCity(BuildContext context) {
    
  }
}
