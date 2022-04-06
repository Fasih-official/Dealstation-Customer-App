import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberApp/models/dashboard_model.dart';
import 'package:memberApp/utils/styles.dart';
import 'package:memberApp/utils/utils.dart';
import '../controlllers/api_controller.dart';
import '../controlllers/main_screen_controller.dart';
import '../models/membership_plan_model.dart';
import 'colors.dart';
import 'constants.dart';
import 'decorations.dart';

class MyScaffold extends StatelessWidget {
  final Widget? body, drawer, bottomNavigationBar, floatingActionButton;
  final PreferredSizeWidget? appBar;
  final Color backgroundColor;
  final Key? scaffoldKey;
  final FloatingActionButtonLocation? floatingActionLocation;
  final bool extendBodyBehindAppBar;

  const MyScaffold({
    Key? key,
    this.body,
    this.drawer,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionLocation,
    this.backgroundColor = moreLighterGreyColor,
    this.scaffoldKey,
    this.extendBodyBehindAppBar = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: backgroundColor,
      appBar: appBar,
      body: body,
      drawer: drawer,
      bottomNavigationBar: bottomNavigationBar,
      extendBody: true,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionLocation,
    );
  }
}

class FABBottomAppBarItem {
  FABBottomAppBarItem(
      {required this.iconDataUnSelected,
      required this.iconDataSelected,
      required this.text});

  String iconDataUnSelected;
  String iconDataSelected;
  String text;
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    required this.items,
    required this.selectedIndex,
    this.centerItemText,
    this.height = 60.0,
    this.iconSize = 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    required this.onTabSelected,
  }) {
    assert(items.length == 2 || items.length == 4);
  }

  final List<FABBottomAppBarItem> items;
  final int selectedIndex;
  final String? centerItemText;
  final double height;
  final double iconSize;
  final Color? backgroundColor;
  final Color? color;
  final Color? selectedColor;
  final NotchedShape? notchedShape;
  final ValueChanged<int> onTabSelected;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  late int _selectedIndex;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    MainScreenController mainScreenController = Get.find();
    _selectedIndex = mainScreenController.indexPage.value;

    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return BottomAppBar(
      shape: widget.notchedShape,
      notchMargin: 5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items,
      ),
      color: widget.backgroundColor,
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 34),
            Text(
              tr("Scan"),
              style: regularWhiteText12(Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem? item,
    int? index,
    required ValueChanged<int> onPressed,
  }) {
    Color? color =
        _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index!),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  _selectedIndex == index
                      ? item!.iconDataSelected
                      : item!.iconDataUnSelected,
                  height: 34,
                  width: 34,
                ),
                SizedBox(
                  height: 1,
                ),
                Text(
                  item.text,
                  style: regularWhiteText12(
                      _selectedIndex == index ? color : Colors.grey),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IntroScreen1 extends StatelessWidget {
  final VoidCallback callBack;

  String text;

  IntroScreen1({
    Key? key,
    required this.callBack,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // TODO: implement build
    return Column(
      children: [
        verticalSpace(height: 20),
        Expanded(
          child: Stack(
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
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: GestureDetector(
                    onTap: callBack,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5, left: 20),
                          child: Text(
                            tr('Skip'),
                            style: boldWhiteText18(normalTextAndButtonColor),
                          ),
                        ),
                        RotatedBox(
                          quarterTurns: (EasyLocalization.of(context)
                                      ?.currentLocale
                                      ?.languageCode ==
                                  'en')
                              ? 2
                              : 0,
                          child: Container(
                            child: Image.asset(
                              "assets/images/ic_back_arrow.png",
                              height: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
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
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/ic_intro.png",
                                height: size.height * 0.4,
                              ),
                              verticalSpace(height: 20),
                              Text(
                                "${text}",
                                style: regularWhiteText12(darkGreyColor),
                              ),
                              verticalSpace(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  child: Image.asset(
                    "assets/images/ic_bottom_intro.png",
                    width: 200,
                    height: 200,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

class CircularAvatar extends StatelessWidget {
  final String imagePath;
  final double imageSize, imageWidth, imageHeight;
  final bool isNetworkImage;

  const CircularAvatar({
    Key? key,
    required this.imagePath,
    required this.imageSize,
    this.imageWidth = 0.0,
    this.imageHeight = 0.0,
    this.isNetworkImage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (imageWidth > 0) ? imageWidth : imageSize,
      height: (imageHeight > 0) ? imageHeight : imageSize,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(imageSize),
        child: (isNetworkImage)
            ? GenericCachedNetworkImage(
                imagePath: imagePath,
              )
            : Image.asset(imagePath),
      ),
    );
  }
}

class CustomizedTouchEventIconButton extends StatelessWidget {
  final String path;
  final double width;
  final double height;
  final VoidCallback callback;
  var color;

  CustomizedTouchEventIconButton(
      {Key? key,
      required this.path,
      required this.width,
      required this.height,
      this.color = null,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        path,
        width: width,
        height: height,
        color: color,
      ),
      onPressed: callback,
    );
  }
}

class GenericCachedNetworkImage extends StatelessWidget {
  final String imagePath;

  const GenericCachedNetworkImage({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imagePath,
      placeholder: (_, url) => PlaceholderWidget(),
      errorWidget: (_, url, error) => PlaceholderWidget(),
      fit: BoxFit.cover,
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/ic_app_launcher.png',
      fit: BoxFit.cover,
    );
  }
}

class CustomizedButton extends StatelessWidget {
  final String text;
  final String img;
  final double verticalPadding;
  final Color textColor;

  const CustomizedButton(
      {Key? key,
      required this.text,
      this.verticalPadding = 0,
      this.textColor = Colors.white,
      this.img = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isEmpty(img)
                ? Container()
                : Row(
                    children: [
                      Image.asset(
                        img,
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
            Text(
              text,
              style: boldWhiteText12(textColor),
            ),
          ],
        ),
      ),
    );
  }
}

class GenericProgressBar extends StatelessWidget {
  final String tag;

  GenericProgressBar({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    APIController controller = Get.find(tag: tag);
    return Obx(() {
      return (controller.isLoading.value)
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : Container();
    });
  }
}

class CutomizedTextField extends StatelessWidget {
  String prefixImage, hintText, _phone = "", _password = "";
  bool passwordVisible;
  TextInputType? keyboard;
  TextEditingController? descriptionController;

  final Function(bool)? callbackFocus;

  CutomizedTextField({
    Key? key,
    required this.passwordVisible,
    required this.keyboard,
    this.descriptionController,
    this.prefixImage = "",
    this.hintText = "",
    required this.callbackFocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 4,
        child: FocusScope(
          child: Focus(
            onFocusChange: callbackFocus,
            child: TextField(
              controller: descriptionController,
              keyboardType: keyboard,
              obscureText: passwordVisible,
              cursorColor: appBarColor,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                    color: darkGreyColor, fontWeight: FontWeight.w400),
                hintText: hintText,
                prefixIconConstraints: BoxConstraints(),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(
                      top: 12.0, bottom: 12, left: 20, right: 12),
                  child: isNotEmpty(prefixImage)
                      ? Image.asset(
                          prefixImage,
                          height: 20,
                          width: 20,
                        )
                      : Container(),
                ),
              ),
              onChanged: (value) {
                _password = value;
              },
            ),
          ),
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  final Color color;

  MyAppBar({
    Key? key,
    this.color = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          rectangularCustomColorBoxDecorationWithRadius(0, 0, 0, 0, color),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/images/ic_deal_station.png',
                height: 36,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Get.toNamed(NamedRoutes.routeHome);
                    },
                    child: Image.asset(
                      'assets/images/ic_yellow_heart.png',
                      height: 28,
                    ),
                  ),
                  horizontalSpace(),
                  GestureDetector(
                    onTap: () {},
                    child: Image.asset(
                      'assets/images/ic_search_magnifier.png',
                      height: 28,
                    ),
                  ),
                  horizontalSpace(),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(NamedRoutes.routeProfile);
                    },
                    child: Image.asset(
                      'assets/images/ic_user.png',
                      height: 28,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  bool obscureText;
  TextEditingController? controller;
  int textLength;
  TextInputType keyboardType;
  TextAlign textAlign;
  String? hint;
  double verticalPad, horizontalPad;

  MyTextField({
    Key? key,
    this.controller,
    this.obscureText = false,
    this.textLength = 100,
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.start,
    this.hint,
    this.verticalPad = 0.0,
    this.horizontalPad = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        decoration: densedFieldDecorationWithoutPadding(
          hint: hint,
          verticalPad: verticalPad,
          horizontalPad: horizontalPad,
        ),
        keyboardType: keyboardType,
        obscureText: obscureText,
        textAlign: textAlign,
        maxLength: textLength,
        controller: controller,
      ),
    );
  }
}

class AnimatedContainerWrapper extends StatelessWidget {
  const AnimatedContainerWrapper({
    required this.closedBuilder,
    required this.openBuilder,
    required this.transitionType,
    required this.onClosed,
  });

  final Widget closedBuilder;
  final Widget openBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool?> onClosed;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionType: transitionType,
      openBuilder: (_, v) => openBuilder,
      onClosed: onClosed,
      tappable: true,
      closedBuilder: (_, v) => closedBuilder,
    );
  }
}

class FadeIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;
  final Duration duration;

  const FadeIndexedStack({
    Key? key,
    required this.index,
    required this.children,
    this.duration = const Duration(
      milliseconds: 800,
    ),
  }) : super(key: key);

  @override
  _FadeIndexedStackState createState() => _FadeIndexedStackState();
}

class _FadeIndexedStackState extends State<FadeIndexedStack>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void didUpdateWidget(FadeIndexedStack oldWidget) {
    if (widget.index != oldWidget.index) {
      _controller.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: IndexedStack(
        index: widget.index,
        children: widget.children,
      ),
    );
  }
}

class HideScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class MyCustomScrollBar extends StatelessWidget {
  final Axis axis;
  final ScrollController? controller;
  final Widget child;

  const MyCustomScrollBar({
    Key? key,
    this.axis = Axis.vertical,
    this.controller,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        scrollDirection: axis,
        controller: controller,
        child: child,
      ),
    );
  }
}

class CardProduct extends StatelessWidget {
  final String imageURL, title, description, date, percentageDiscount;
  final int index;
  final List offers;

  const CardProduct({
    Key? key,
    required this.index,
    required this.offers,
    this.imageURL = 'assets/images/ic_daniyal.png',
    this.title = 'LC WaIKIKI',
    this.description = 'BASIC Crew Neck Short\nsleeve Basic Men\'s T-Shirt',
    this.date = '2 : 16 : 22',
    this.percentageDiscount = '30\n%',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: rectangularWhiteBoxDecorationWithRadiusElevation(8, 2),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
                child: CircularAvatar(
                  imagePath: (offers[index] as OffersBean).offerImageLink!,
                  imageWidth: 125,
                  imageHeight: 120,
                  imageSize: 0,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 30, end: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsetsDirectional.only(end: 10),
                                  child: Text(
                                    '${(offers[index] as OffersBean).offerName}',
                                    style: boldWhiteText14(lightGreyColor),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  horizontalSpace(),
                                  Image.asset(
                                    (index == 0)
                                        ? 'assets/images/ic_yellow_heart.png'
                                        : 'assets/images/ic_grey_heart.png',
                                    height: 24,
                                  ),
                                ],
                              )
                            ],
                          ),
                          verticalSpace(height: 5),
                          Text(
                            '${(offers[index] as OffersBean).offer_description}',
                            maxLines: 2,
                            style: regularWhiteText12(normalTextAndButtonColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                          verticalSpace(height: 5),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${(offers[index] as OffersBean).offerTo?.replaceAll('-', ':')}',
                              style: boldWhiteText14(lightGreyColor),
                            ),
                          ),
                          horizontalSpace(),
                          Container(
                            decoration:
                                rectangularButtonBoxDecorationWithRadiusElevation(
                                    8, 2),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: CustomizedButton(
                                text: tr('Redeem Coupon'),
                                verticalPadding: 10,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 4,
          left: 4,
          right: 4,
          bottom: 4,
          child: DottedBorder(
            child: Container(),
            color: lightGreyColor,
            radius: const Radius.circular(8),
            dashPattern: [6, 6],
            borderType: BorderType.RRect,
          ),
        ),
        Positioned.directional(
          start: 100,
          top: 0,
          bottom: 0,
          textDirection: Directionality.of(context),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: circularCustomColorBoxDecorationWithRadiusElevation(
                    appBarColor, 2),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    '${(offers[index] as OffersBean).offerDiscount}\n%',
                    style: boldWhiteText20(Colors.black, height: 0.8),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class VerticalCardProduct extends StatelessWidget {
  final String imageURL, title, description, date, percentageDiscount;
  final int index;
  final OffersBean offer;

  const VerticalCardProduct({
    Key? key,
    required this.index,
    this.imageURL = 'assets/images/ic_daniyal.png',
    this.title = 'LC WaIKIKI',
    this.description =
        'BASIC Crew Neck Short\nsleeve Basic Men\'s T-ShirtBASIC Crew Neck Short\nsleeve Basic Men\'s T-Shirt',
    this.date = '2 : 16 : 22',
    this.percentageDiscount = '30\n%',
    required this.offer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: rectangularWhiteBoxDecorationWithRadiusElevation(8, 2),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                  child: CircularAvatar(
                    imagePath: '${offer.offerImageLink}',
                    imageWidth: MediaQuery.of(context).size.width,
                    imageSize: 0,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      verticalSpace(height: 50),
                      Column(
                        children: [
                          Text(
                            '${offer.offerName}',
                            style: boldWhiteText14(lightGreyColor),
                          ),
                          verticalSpace(),
                          Text(
                            '${offer.offer_description}',
                            style: regularWhiteText12(normalTextAndButtonColor),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                          verticalSpace(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration:
                                rectangularButtonBoxDecorationWithRadiusElevation(
                                    8, 2),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: CustomizedButton(
                                text: tr('Redeem Coupon'),
                                verticalPadding: 10,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned.directional(
          textDirection: Directionality.of(context),
          top: 4,
          start: 4,
          end: 4,
          bottom: 4,
          child: DottedBorder(
            child: Container(),
            color: lightGreyColor,
            radius: const Radius.circular(8),
            dashPattern: [6, 6],
            borderType: BorderType.RRect,
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 76,
                height: 76,
                decoration: circularCustomColorBoxDecorationWithRadiusElevation(
                    appBarColor, 2),
                child: Padding(
                  padding: const EdgeInsets.only(top: 28),
                  child: Text(
                    percentageDiscount,
                    style: boldWhiteText20(Colors.black, height: 0.8),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned.directional(
          textDirection: Directionality.of(context),
          top: 10,
          start: 0,
          end: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                (index == 0)
                    ? 'assets/images/ic_yellow_heart.png'
                    : 'assets/images/ic_grey_heart.png',
                height: 24,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CardCoupon extends StatelessWidget {
  final String title, description, date, percentageDiscount;
  final int index;

  const CardCoupon({
    Key? key,
    required this.index,
    this.title = 'LC WaIKIKI',
    this.description = 'BASIC Crew Neck Short\nsleeve Basic Men\'s T-Shirt',
    this.date = '2 : 16 : 22',
    this.percentageDiscount = '30%',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: rectangularWhiteBoxDecorationWithRadiusElevation(8, 2),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        percentageDiscount,
                        style: boldWhiteText20(Colors.black, height: 0.8),
                        textAlign: TextAlign.center,
                      ),
                      verticalSpace(height: 5),
                      Column(
                        children: [
                          Text(
                            title,
                            style: boldWhiteText14(lightGreyColor),
                          ),
                          verticalSpace(height: 5),
                          Text(
                            description,
                            style: regularWhiteText12(normalTextAndButtonColor),
                            textAlign: TextAlign.center,
                          ),
                          verticalSpace(height: 5),
                        ],
                      ),
                      Text(
                        date,
                        style: boldWhiteText14(lightGreyColor),
                      ),
                      verticalSpace(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(NamedRoutes.routeOfferDetail);
                            },
                            child: Container(
                              decoration:
                                  rectangularButtonBoxDecorationWithRadiusElevation(
                                      8, 2),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: CustomizedButton(
                                  text: tr('Redeem Coupon'),
                                  verticalPadding: 10,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 4,
          left: 4,
          right: 4,
          bottom: 4,
          child: DottedBorder(
            child: Container(),
            color: lightGreyColor,
            radius: const Radius.circular(8),
            dashPattern: [6, 6],
            borderType: BorderType.RRect,
          ),
        ),
      ],
    );
  }
}

class FiltersAndAdidas extends StatelessWidget {
  final bool exploreCategory;
  final String name;
  RxBool? switchListView;

  FiltersAndAdidas({
    Key? key,
    this.exploreCategory = false,
    this.switchListView,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const MyBackButton(),
            (exploreCategory)
                ? Text(
                    '${name}',
                    style: boldWhiteText18(normalTextAndButtonColor),
                    textAlign: TextAlign.center,
                  )
                : Container(),
            const Opacity(
              child: MyBackButton(),
              opacity: 0.0,
            ),
          ],
        ),
        (exploreCategory)
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/ic_adidas_logo.png',
                          height: 36,
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'There are many variations of Lorem Ipsum texts available, but the majority have been altered in some form. There are many differences in paragraphs.',
                      style: regularWhiteText12(normalTextAndButtonColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  verticalSpace(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Al Aroooz',
                          style: boldWhiteText14(normalTextAndButtonColor),
                        ),
                        Obx(() {
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (isNotEmpty(switchListView)) {
                                    switchListView!.value = false;
                                  }
                                },
                                child: Image.asset(
                                  (switchListView?.value) ?? false
                                      ? 'assets/images/ic_gallery.png'
                                      : 'assets/images/ic_gallery.png',
                                  height: 24,
                                ),
                              ),
                              horizontalSpace(),
                              GestureDetector(
                                onTap: () {
                                  if (isNotEmpty(switchListView)) {
                                    switchListView!.value = true;
                                  }
                                },
                                child: Image.asset(
                                  (switchListView?.value) ?? false
                                      ? 'assets/images/ic_filters.png'
                                      : 'assets/images/ic_filters.png',
                                  height: 24,
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              )
      ],
    );
  }
}

class MyBackButton extends StatelessWidget {
  const MyBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: RotatedBox(
          quarterTurns:
              (EasyLocalization.of(context)?.currentLocale?.languageCode ==
                      'en')
                  ? 0
                  : 2,
          child: Image.asset(
            'assets/images/ic_back_arrow.png',
            height: 24,
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final int index;
  final List categories;

  const CategoryCard({
    Key? key,
    required this.index,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Container(
        decoration: (index == 0)
            ? rectangularWhiteBoxDecorationWithRadius(4)
            : rectangularWhiteBoxDecorationWithRadius(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            children: [
              CircularAvatar(
                imagePath: (categories[index] as CategoriesBean).categoryIcon!,
                imageSize: 0,
                imageHeight: 36,
                imageWidth: 36,
              ),
              verticalSpace(height: 5),
              Text(
                (categories[index] as CategoriesBean).categoryName!,
                style: regularWhiteText12(
                    (index == 0) ? lightGreyColor : lightGreyColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CardPackage extends StatelessWidget {
  final String imageURL, title, description, date, percentageDiscount;
  final List<MembershipPlanModel> membershipPlan;
  final int index;
  final int selectedIndex;

  const CardPackage({
    Key? key,
    required this.membershipPlan,
    required this.index,
    required this.selectedIndex,
    this.imageURL = 'assets/images/ic_gold_medal.png',
    this.title = 'LC WaIKIKI',
    this.description = 'BASIC Crew Neck Short\nsleeve Basic Men\'s T-Shirt',
    this.date = '2 : 16 : 22',
    this.percentageDiscount = '30',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: selectedIndex == index
          ? rectangularWhiteBoxDecorationWithRadiusSelectedBorder(8)
          : rectangularWhiteBoxDecorationWithRadiusBlackBorder(8),
      child: Stack(
        children: [
          Container(
            child: Container(
              decoration:
                  rectangularWhiteBoxDecorationWithRadiusElevation(8, 2),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CircularAvatar(
                            imagePath: membershipPlan[index].planIcon!,
                            imageSize: 0,
                            imageWidth: 80,
                            imageHeight: 80,
                            isNetworkImage: true,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    membershipPlan[index].planName!,
                                    style: boldWhiteText14(lightGreyColor),
                                  ),
                                  verticalSpace(height: 5),
                                  Text(
                                    description,
                                    style: regularWhiteText12(
                                        normalTextAndButtonColor),
                                  ),
                                  verticalSpace(height: 5),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   width: 72,
                    //   height: 72,
                    //   decoration:
                    //       circularCustomColorBoxDecorationWithRadiusElevation(
                    //           (index == 0) ? appBarColor : lighterGreyColor, 2),
                    //   child: (index == 0)
                    //       ? Center(
                    //           child: Image.asset(
                    //             'assets/images/ic_dart_tick.png',
                    //             height: 16,
                    //           ),
                    //         )
                    //       : Padding(
                    //           padding: const EdgeInsets.only(
                    //               left: 10, right: 10, top: 12),
                    //           child: Column(
                    //             children: [
                    //               Text(
                    //                 percentageDiscount,
                    //                 style: boldWhiteText20(Colors.black),
                    //                 textAlign: TextAlign.center,
                    //               ),
                    //               Text(
                    //                 'Enemies Ahead',
                    //                 style: boldWhiteText12(lightGreyColor),
                    //                 textAlign: TextAlign.center,
                    //                 overflow: TextOverflow.ellipsis,
                    //                 maxLines: 2,
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 4,
            left: 4,
            right: 4,
            bottom: 4,
            child: DottedBorder(
              child: Container(),
              color: lightGreyColor,
              radius: const Radius.circular(8),
              dashPattern: [6, 6],
              borderType: BorderType.RRect,
            ),
          ),
        ],
      ),
    );
  }
}

class DotAndText extends StatelessWidget {
  final String text;

  const DotAndText({
    Key? key,
    this.text = 'Lorem ipsum',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        6,
        (index) => Column(
          children: [
            verticalSpace(height: 2),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: appCounterDecoration(normalTextAndButtonColor),
                ),
                horizontalSpace(),
                Expanded(
                  child: Text(
                    text,
                    style: boldWhiteText12(normalTextAndButtonColor),
                  ),
                )
              ],
            ),
            verticalSpace(height: 2)
          ],
        ),
      ),
    );
  }
}

class DotWidget extends StatelessWidget {
  final double totalWidth, dashWidth, emptyWidth, dashHeight;

  final Color dashColor;

  const DotWidget({
    this.totalWidth = 200,
    this.dashWidth = 10,
    this.emptyWidth = 5,
    this.dashHeight = 2,
    this.dashColor = Colors.black,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        totalWidth ~/ (dashWidth + emptyWidth),
        (_) => Container(
          width: dashWidth,
          height: dashHeight,
          color: dashColor,
          margin: EdgeInsets.only(left: emptyWidth / 2, right: emptyWidth / 2),
        ),
      ),
    );
  }
}

class NoDataFound extends StatelessWidget {
  const NoDataFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No Data Found',
        style: boldWhiteText16(Colors.white),
      ),
    );
  }
}
