import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/decorations.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class NoCreditScreen extends StatefulWidget {
  const NoCreditScreen({Key? key}) : super(key: key);

  @override
  _NoCreditScreenState createState() => _NoCreditScreenState();
}

class _NoCreditScreenState extends State<NoCreditScreen> {
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
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    'No Credits',
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
                      Image.asset("assets/images/ic_not_found.png", height: 180,width: 180,),
                      verticalSpace(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Al Bassati",style: boldWhiteText14(darkAppBarColor),),

                        ],
                      ),
                      verticalSpace(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("lorem Ibsum lorem Ibsum lorem Ibsum lorem Ibsum "
                              "lorem Ibsum lorem Ibsum lorem Ibsum lorem Ibsum ",style: boldWhiteText14(darkAppBarColor),),

                        ],
                      ),
                      verticalSpace(height: 20),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: rectangularRedBoxDecorationWithRadius(4),
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
