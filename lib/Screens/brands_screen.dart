import 'package:flutter/cupertino.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

import '../utils/utils.dart';
import '../utils/widgets.dart';

class BrandsScreen extends StatefulWidget {
  const BrandsScreen({Key? key}) : super(key: key);

  @override
  _BrandsScreenState createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  getAppBar() {
    return PreferredSize(
      child: MyAppBar(),
      preferredSize: Size.fromHeight(65),
    );
  }

  getBody() {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(),
          // const FiltersAndAdidas(switchListView: s,),
          verticalSpace(),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (_, index) => buildProductListing(index),
            ),
          )
        ],
      ),
    );
  }

  Widget buildProductListing(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
      child: CardProduct(
        index: index,
        offers: [],

      ),
    );
  }
}
