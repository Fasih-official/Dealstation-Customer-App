import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MyScaffold(
      body: getBody(size),
    );
  }

  getBody(Size size) {
   return Column(
     children: [
       Stack(
         children: [
           ClipRRect(
             borderRadius:
             BorderRadius.vertical(bottom: Radius.elliptical(220, 100)),
             child: Container(
               height: size.height * 0.25,
               width: size.width,
               color: appBarColor,
             ),
           ),
           Padding(
             padding: EdgeInsets.symmetric(horizontal: 20),
             child: Column(
               children: [
                 SizedBox(
                   height: size.height * 0.15,
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text("About us", style: boldWhiteText24(darkAppBarColor),)
                   ],
                 ),
                 verticalSpace(height: 20),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: const [
                     Flexible(
                       child: Text('Add long text here Add long text hereAdd long text here Add long text hereAdd long text hereAdd long text here',
                         softWrap: true,
                         overflow: TextOverflow.fade,
                       ),
                     ),
                   ],
                 )
               ],
             ),
           )
         ],
       ),
     ],
   );
  }
}
