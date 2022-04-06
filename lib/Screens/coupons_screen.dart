import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../utils/utils.dart';
import '../utils/widgets.dart';

class CouponsScreen extends StatefulWidget {
  const CouponsScreen({Key? key}) : super(key: key);

  @override
  _CouponsScreenState createState() => _CouponsScreenState();
}

class _CouponsScreenState extends State<CouponsScreen> {
  var switchListView = true.obs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MyScaffold(
      appBar: getAppBar(),
      body: getBody(size),
    );
  }

  getAppBar() {
    return PreferredSize(
      child: MyAppBar(),
      preferredSize: Size.fromHeight(65),
    );
  }

  getBody(Size size) {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(),
          FiltersAndAdidas(
            switchListView: switchListView, name: '',
          ),
          verticalSpace(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Obx(
                () {
                  return (switchListView.value)
                      ? ListView.builder(
                          itemCount: 0,
                          itemBuilder: (_, index) => buildListView(index),
                        )
                      : GridView.builder(
                          itemCount: 20,
                          itemBuilder: (_, index) => buildGridView(index),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: (size.width / 2 - 50) /
                                      (size.height / 5)),
                        );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildGridView(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0, left: 5, right: 5),
      child: CardCoupon(
        index: index,
      ),
    );
  }

  Widget buildListView(int index,) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
      child: CardProduct(
        index: index,
        offers: [],
      ),
    );
  }
}
